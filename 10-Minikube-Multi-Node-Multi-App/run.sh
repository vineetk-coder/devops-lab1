#!/bin/bash
# Exercise 10 - multi-node Minikube, two apps (Linux/WSL, run from this directory)
set -e
P=devops-multinode
minikube stop || true
minikube delete || true
minikube start --nodes 3 -p $P --force
minikube -p $P addons enable registry
kubectl get nodes -o wide

docker build -t product-catalog:latest -f Dockerfile.product .
docker build -t shopping-cart:latest -f Dockerfile.shopping .
minikube -p $P image load product-catalog:latest
minikube -p $P image load shopping-cart:latest
minikube -p $P image ls | grep -E 'product-catalog|shopping-cart'

kubectl apply -f product_catalog_deployment.yaml
kubectl apply -f shopping_cart_deployment.yaml
kubectl apply -f product_catalog_service.yaml
kubectl apply -f shopping_cart_service.yaml
kubectl rollout status deployment/product-catalog --timeout=180s
kubectl rollout status deployment/shopping-cart --timeout=180s

kubectl get deployments
kubectl get pods -o wide
kubectl get svc
kubectl get endpoints product-catalog-service shopping-cart-service

# Access through port-forward (works with every driver; minikube service also works)
kubectl port-forward svc/product-catalog-service 18080:80 >/dev/null 2>&1 & PF1=$!
kubectl port-forward svc/shopping-cart-service 18081:80 >/dev/null 2>&1 & PF2=$!
sleep 3
curl -s http://127.0.0.1:18080/products; echo
curl -s http://127.0.0.1:18081/cart; echo
curl -s -X POST http://127.0.0.1:18081/cart -H "Content-Type: application/json" -d '{"id": 1, "name": "Laptop", "quantity": 1}'; echo
kill $PF1 $PF2
