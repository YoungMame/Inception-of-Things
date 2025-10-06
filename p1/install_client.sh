echo "Installing k3s in agent mode..."
curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.10:6443 K3S_TOKEN=mynodetoken sh -