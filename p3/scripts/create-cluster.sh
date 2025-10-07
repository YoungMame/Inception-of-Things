if [ "$(k3d cluster list | grep -c mycluster)" -gt 0 ]; then
    echo "Cluster mycluster already exists."
else
    k3d cluster create --config ./dev/cluster.yaml
    kubectl apply -f ./dev/namespace.yaml
    kubectl apply -f ./argocd/namespace.yaml
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml > /dev/null
fi