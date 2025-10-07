echo "Installing k3s in server mode..."
source /home/vagrant/.env
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE=644 K3S_TOKEN=$K3S_TOKEN sh -