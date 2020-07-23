# Master script to initialize cluster according to specs in:
#
# https://zero-to-jupyterhub.readthedocs.io/en/latest/create-k8s-cluster.html
#
# Depends on:
#   vars.sh (via config.sh)
source set_config.sh

# Create the main cluster.
gcloud container clusters create \
  --machine-type $DEFAULT_MACHINE \
  --num-nodes 2 \
  --cluster-version latest \
  --node-locations $ZONE \
  --region $REGION \
  $JHUB_CLUSTER

# Give your account permissions to perform all administrative actions needed.
kubectl create clusterrolebinding cluster-admin-binding \
  --clusterrole=cluster-admin \
  --user=$EMAIL

# Optional - create a special user cluster.
gcloud beta container node-pools create user-pool \
  --machine-type $USER_MACHINE \
  --num-nodes 0 \
  --enable-autoscaling \
  --min-nodes 0 \
  --max-nodes $MAX_NODES \
  --node-labels hub.jupyter.org/node-purpose=user \
  --node-taints hub.jupyter.org_dedicated=user:NoSchedule \
  --node-locations $ZONE \
  --region $REGION \
  --cluster $JHUB_CLUSTER

# Set up a ServiceAccount for use by tiller.
kubectl --namespace kube-system create serviceaccount tiller

# Give the ServiceAccount full permissions to manage the cluster.
kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller

# Initialize Helm
. reinit.sh

# Ensure that tiller is secure from access inside the cluster:
kubectl patch deployment tiller-deploy \
    --namespace=kube-system --type=json \
    --patch='[{"op": "add", "path": "/spec/template/spec/containers/0/command", "value": ["/tiller", "--listen=localhost:44134"]}]'

echo Next run
echo source build_gjhub.sh