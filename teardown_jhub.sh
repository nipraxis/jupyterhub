# Teardown jhub
. set_config.sh
echo "Deleting JHub $RELEASE"
helm delete $RELEASE

kubectl delete namespace $NAMESPACE
