create:
	sh ./scripts/create-cluster.sh

up: create
	k3d cluster start mycluster

down:
	k3d cluster stop mycluster

clean:
	k3d cluster delete mycluster

re:: clean up
