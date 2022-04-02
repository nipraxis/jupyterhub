# Teardown jhub
. set_config.sh
echo "Deleting persistent volumes"

kubectl delete service nfs-server
kubectl delete deployments nfs-server
# https://stackoverflow.com/questions/57401526/how-to-delete-persistent-volumes-in-kubernetes
kubectl delete pvc nfs
kubectl delete pvc nfs-data
