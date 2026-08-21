#!/bin/bash
# Exercise 2 - Deploy Flask app on Minikube (run from this directory, Linux/WSL)
set -e
minikube status >/dev/null 2>&1 || minikube start
eval $(minikube docker-env)
docker build -t flask-app .
kubectl apply -f flask-deployment.yaml
kubectl rollout status deployment/flask-app --timeout=180s
kubectl get deployments
kubectl get pods -l app=flask-app
kubectl describe deployment flask-app
kubectl logs deployment/flask-app
kubectl get services
URL=$(minikube service flask-app-service --url | head -n1)
echo "URL: $URL"
curl -s "$URL"; echo
