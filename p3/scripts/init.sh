#!/bin/bash

sudo k3d cluster delete p3-cluster
sudo k3d cluster create p3-cluster

sudo kubectl create namespace argocd
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

sudo kubectl config set-context --current --namespace=argocd
sudo argocd login --insecure --core

# TODO wait for status=ready
sudo kubectl port-forward svc/argocd-server -n argocd 8080:443 &

# default admin password
echo admin pasword: $(sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d)


sudo kubectl config set-context --current --namespace=argocd

sudo argocd app create will42 --insecure --repo https://github.com/Gpatrix/42.Inception-of-Things.manifests.git --path main --dest-server https://kubernetes.default.svc --dest-namespace default
sudo argocd app sync will42

# TODO better way ?
sudo kubectl port-forward svc/will42 -n default 8888:8888
# curl localhost:8888