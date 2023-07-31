#!/bin/sh
# Reset helm chart for cluster
# Start call to helm upgrade with any passed arguments
# Depends on:
#   vars.sh (via set_config.sh)
source set_config.sh

# Timeout from:
# https://zero-to-jupyterhub.readthedocs.io/en/latest/administrator/optimization.html#pulling-images-before-users-arrive
# Allows pre-pulling of new Docker images on install / upgrade.
helm upgrade \
    $RELEASE \
    jupyterhub/jupyterhub  \
    --cleanup-on-fail \
    --atomic \
    --timeout 15m0s \
    --namespace=$NAMESPACE \
    --create-namespace \
    --version=$JHUB_VERSION \
    --values ${CONFIG_YAML:-config.yaml}
