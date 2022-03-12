# Teardown jhub
. set_config.sh
echo "Deleting JHub $RELEASE"
helm delete $RELEASE
sleep 20
./teardown_nfs.sh
sleep 20
kubectl delete namespace $NAMESPACE
