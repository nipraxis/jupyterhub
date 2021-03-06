#!/bin/sh
# Teardown everything
# Depends on:
#   vars.sh
#   config.yaml
. set_config.sh

echo "Deleting $RELEASE on $JHUB_CLUSTER".
read -n1 -r -p "Press y to continue, any other key to cancel." key
echo

if [ "$key" = 'y' ]; then
    ./teardown_jhub.sh
    ./teardown_gcloud_now.sh
    # Check teardown
    ./show_gcloud.sh
else
    echo "Cancelled"
fi
