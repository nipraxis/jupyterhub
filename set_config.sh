# Set configuration

# Get variables
. vars.sh

# Set gcloud parameters
gcloud config set project ${PROJECT_ID}
gcloud config set container/cluster $JHUB_CLUSTER
gcloud compute project-info add-metadata \
    --metadata google-compute-default-region=$REGION,google-compute-default-zone=$ZONE
