# Teardown jhub
. set_config.sh
echo "Deleting JHub $RELEASE"
helm delete $RELEASE
sleep 10
./teardown_nfs.sh
sleep 10
kubectl delete namespace $NAMESPACE
