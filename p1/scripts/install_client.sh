echo "Installing k3s in agent mode..."
source /home/vagrant/.env
curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.110:6443 K3S_TOKEN=$K3S_TOKEN sh -
apt install kubectl
