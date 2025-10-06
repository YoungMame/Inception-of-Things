PATH="/home/vagrant"

mv ${PATH}/confs/config.yaml /etc/rancher/k3s/config.yaml

echo "Installing k3s in server mode..."
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE=644 K3S_TOKEN=mynodetoken sh -

apt install kubectl

kubectl apply -f ${PATH}/confs/apps.yaml
kubectl apply -f ${PATH}/confs/ingress.yaml