#!/bin/bash

sudo k3d cluster delete bonus-cluster
sudo k3d cluster create bonus-cluster

sudo kubectl create namespace argocd
sudo kubectl create namespace dev
sudo kubectl create namespace gitlab
# sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# sudo kubectl config set-context --current --namespace=argocd
# sudo argocd login --insecure --core

# echo "waiting for argocd to be ready..."
# sudo kubectl wait --for=condition=ready --timeout=600s pods --all -n argocd

# sudo kubectl port-forward svc/argocd-server -n argocd 8080:443 > /dev/null &

# sudo kubectl apply -f ../confs/manifest.yaml

# echo "waiting for pod to be ready..."
# sudo kubectl wait --for=condition=ready --timeout=600s pods --all -n dev

# echo admin password: $(sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d)

# sudo kubectl port-forward svc/will42 -n dev 8888:8888
# curl localhost:8888

sudo kubectl config set-context --current --namespace=gitlab
sudo helm repo add gitlab https://charts.gitlab.io/
sudo helm repo update
sudo helm upgrade --insecure-skip-tls-verify --install -n gitlab gitlab gitlab/gitlab \
  --timeout 600s \
  --set global.hosts.domain=locallab.com \
  --set global.hosts.externalIP=127.0.1.1 \
  --set certmanager-issuer.email=me@example.com