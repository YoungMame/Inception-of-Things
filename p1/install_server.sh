echo "Installing k3s in server mode..."
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE=644 K3S_TOKEN=mynodetoken sh -