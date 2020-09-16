#!/bin/sh
# Teardown everything
# Depends on:
#   vars.sh
#   config.yaml
. set_config.sh

helm delete $RELEASE
kubectl delete namespace $NAMESPACE
gcloud container clusters delete $JHUB_CLUSTER --region $REGION --quiet

# Check teardown
gcloud container clusters list
gcloud compute instances list
gcloud compute disks list
