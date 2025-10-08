VAGRANT_PATH="/home/vagrant";

cp ${VAGRANT_PATH}/confs/config.yaml /etc/rancher/k3s/config.yaml

echo "Installing k3s in server mode..."
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE=644 K3S_TOKEN=mynodetoken sh -

apt install kubectl

kubectl apply -f ${VAGRANT_PATH}/confs/app-one.yaml
kubectl apply -f ${VAGRANT_PATH}/confs/app-two.yaml
kubectl apply -f ${VAGRANT_PATH}/confs/app-three.yaml

kubectl apply -f ${VAGRANT_PATH}/confs/ingress.yaml