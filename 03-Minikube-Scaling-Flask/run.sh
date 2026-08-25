#!/bin/bash
# Exercise 3 - Scaling Flask app with ReplicaSets (Linux/WSL, run from this directory)
set -e
minikube stop || true
minikube delete || true
minikube start --nodes=1
kubectl get nodes

# Build the image inside Minikube's Docker daemon BEFORE applying (imagePullPolicy: Never)
eval $(minikube docker-env)
docker build -t flashsale:1.0 .

kubectl apply -f flashsale-replicaset.yaml
kubectl wait --for=condition=Ready pod -l app=flashsale --timeout=180s
echo "== Initial (3 replicas) =="; kubectl get rs flashsale-rs; kubectl get pods -l app=flashsale

kubectl scale rs flashsale-rs --replicas=5
kubectl wait --for=condition=Ready pod -l app=flashsale --timeout=180s
echo "== After scaling (5 replicas) =="; kubectl get rs flashsale-rs; kubectl get pods -l app=flashsale

VICTIM=$(kubectl get pods -l app=flashsale -o jsonpath='{.items[0].metadata.name}')
kubectl delete pod "$VICTIM"
sleep 5
echo "== Self-healing (still 5) =="; kubectl get pods -l app=flashsale -o wide

echo "== Load distribution via service =="
kubectl port-forward svc/flashsale-svc 8080:80 >/dev/null 2>&1 &
PF=$!; sleep 3
for i in $(seq 1 10); do curl -s "http://127.0.0.1:8080/buy?user=$i"; echo; done
kill $PF
