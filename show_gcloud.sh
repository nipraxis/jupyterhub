#!/bin/sh
# Show gcloud resources
. set_config.sh
echo "Clusters:"
gcloud container clusters list
echo "Instances:"
gcloud compute instances list
echo "Disks:"
gcloud compute disks list
