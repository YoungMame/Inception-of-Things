#!/bin/bash

sudo k3d cluster delete p3-cluster
sudo k3d cluster create p3-cluster \
  --port 80:80@loadbalancer \
  --port 443:443@loadbalancer \

sudo kubectl create namespace argocd
sudo kubectl create namespace dev
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

sudo kubectl config set-context --current --namespace=argocd
sudo argocd login --insecure --core

echo "waiting for argocd to be ready..."
sudo kubectl wait --for=condition=ready --timeout=600s pods --all -n argocd

sudo kubectl port-forward svc/argocd-server -n argocd 8080:443 > /dev/null 2>&1 &

sudo kubectl config set-context --current --namespace=dev
sudo kubectl apply -f ./confs/manifest.yaml
sudo kubectl apply -f ./confs/ingress.yaml

echo admin password: $(sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d)

# curl localhost