#!/bin/sh
# Reset autohttps
# See:
# https://discourse.jupyter.org/t/trouble-getting-https-letsencrypt-working-with-0-9-0-beta-4/3583/5?u=matthew.brett

echo "Please see https://github.com/jupyterhub/zero-to-jupyterhub-k8s/issues/2601#issuecomment-1050406952"
echo "You might want to first run the 'kubectl edit deploy autohttps' suggested there"

read -n1 -r -p "Press y to continue, any other key to cancel." key
echo

if [ "$key" = 'y' ]; then
    . set_config.sh
    # Deleting the secret appears to be unnecessary - comment for now.
    #
    # kubectl get secrets
    # kubectl delete secret $(kubectl get secrets -o custom-columns=SECRET:metadata.name | grep "proxy-.*-tls-acme")
    # kubectl get secrets
    https_pod=$(kubectl --namespace=$NAMESPACE get pods -o custom-columns=POD:metadata.name | grep autohttps-)
    kubectl delete pods $https_pod
else
    echo "Cancelled"
fi
