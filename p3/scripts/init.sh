#!/bin/bash

sudo k3d cluster create p3-cluster

sudo kubectl create namespace argocd
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

sudo kubectl config set-context --current --namespace=argocd
sudo argocd login --insecure --core

sudo kubectl port-forward svc/argocd-server -n argocd 8080:443 &

# default admin password
echo admin pasword: $(sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d)


kubectl config set-context --current --namespace=argocd
argocd app create guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace default
argocd app sync guestbook
