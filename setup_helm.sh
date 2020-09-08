# Source this file to restore state for configuration.
# Source config
source set_config.sh

# Reset cluster context, just in case
# Warning: Google Cloud specific; generalize in due course.
kubectl config use-context gke_${PROJECT_ID}_${REGION}_${JHUB_CLUSTER}

# optional autocompletion
kubectl config set-context $(kubectl config current-context) --namespace ${NAMESPACE:-jhub}

# Check correct version of helm is installed
HELM_VER=$(helm version --client --template '{{ .Client.SemVer }}')
if [ "${HELM_VER:0:3}" != "v2." ]; then
    echo run install_helm.sh for helm 2
    return 1
fi

# Initalize helm
helm init --service-account tiller --history-max 100 --wait

# Reinit jupyterhub helm chart repo
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update

# Show what's running
kubectl get pod --namespace $NAMESPACE

echo Next run
echo source init_jhub.sh