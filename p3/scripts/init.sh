#!/bin/bash

sudo k3d cluster delete p3-cluster
sudo k3d cluster create p3-cluster

sudo kubectl create namespace argocd
sudo kubectl create namespace dev
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for apply to finish, wait for pods to be ready
# sudo kubectl wait --for=condition=Ready pod -l app.kubernetes.io/name=argocd-server -n argocd --timeout=300s
sleep 20

sudo kubectl config set-context --current --namespace=argocd
sudo argocd login --insecure --core

sudo kubectl port-forward svc/argocd-server -n argocd 8080:443 &
sleep 10

# default admin password
echo admin password: $(sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d)


sudo kubectl config set-context --current --namespace=argocd

sudo argocd app create will42 --insecure --repo https://github.com/Gpatrix/42.Inception-of-Things.manifests.git --path main --dest-server https://kubernetes.default.svc --dest-namespace dev
sudo argocd app sync will42
argocd app set will42 --sync-policy automated
argocd app set will42 --auto-prune

# TODO better way ?
sudo kubectl port-forward svc/will42 -n dev 8888:8888
# curl localhost:8888