# Teardown jhub
. set_config.sh
echo "Deleting persistent volumes"

kubectl delete persistentvolumes nfs
kubectl delete persistentvolumes nfs-data
