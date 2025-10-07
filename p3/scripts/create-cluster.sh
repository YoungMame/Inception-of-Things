if [ "$(k3d cluster list | grep -c mycluster)" -gt 0 ]; then
    echo "Cluster mycluster already exists."
else
    k3d cluster create --config ./dev/cluster.yaml
    kubectl apply -f ./dev/namespace.yaml
    kubectl apply -f ./argocd/namespace.yaml
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml > /dev/null
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout tls.key -out tls.crt -subj "/CN=argocd.example.com"

    kubectl create secret tls argocd.example.com \
    --cert=tls.crt --key=tls.key -n argocd
    kubectl apply -f ./argocd/ingress.yaml

    kubectl config set-context --current --namespace=argocd
fi