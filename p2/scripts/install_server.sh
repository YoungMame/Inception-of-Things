VAGRANT_PATH="/home/vagrant";

cp ${VAGRANT_PATH}/confs/config.yaml /etc/rancher/k3s/config.yaml

echo "Installing k3s in server mode..."
curl -sfL https://get.k3s.io | KUBECONFIG_MODE=644 sh -

apt install kubectl

kubectl apply -f ${VAGRANT_PATH}/confs/app-one.yaml
kubectl apply -f ${VAGRANT_PATH}/confs/app-two.yaml
kubectl apply -f ${VAGRANT_PATH}/confs/app-three.yaml

kubectl apply -f ${VAGRANT_PATH}/confs/ingress.yaml