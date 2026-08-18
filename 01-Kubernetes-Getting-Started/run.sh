#!/bin/bash
# Exercise 1 - Hello Pod (imperative steps exactly as in the lab sheet)
set -e
minikube status >/dev/null 2>&1 || minikube start
kubectl run hello-k8s --image=nginx --port=80
kubectl wait --for=condition=Ready pod/hello-k8s --timeout=180s
kubectl get pods
kubectl expose pod hello-k8s --type=NodePort --port=80
kubectl get svc hello-k8s
URL=$(minikube service hello-k8s --url | head -n1)
echo "Service URL: $URL"
curl -s "$URL" | grep -o "<title>.*</title>"
