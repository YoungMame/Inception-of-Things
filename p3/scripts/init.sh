#!/bin/bash

sudo k3d cluster delete p3-cluster
sudo k3d cluster create p3-cluster

sudo kubectl create namespace argocd
sudo kubectl create namespace dev
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

sudo kubectl config set-context --current --namespace=argocd
sudo argocd login --insecure --core

# TODO FIX
echo "waiting argocd to be ready..."
sudo kubectl wait --for=condition=ready --timeout=600s pods --all -n argocd

sudo kubectl port-forward svc/argocd-server -n argocd 8080:443 > /dev/null &

sudo kubectl apply -f ../confs/manifest.yaml

echo admin password: $(sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d)

# TODO better way ?
sudo kubectl port-forward svc/will42 -n dev 8888:8888
# curl localhost:8888