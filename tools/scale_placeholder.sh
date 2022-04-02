#!/bin/bash
# Usage:
n_replicas=$1
if [ -z "$n_replicas" ]; then
    echo "Usage: $0 n_replicas [delay_minutes [n_replicas_end]]"
    echo "e.g.:"
    echo "$0 25 15 0"
    echo "to scale up to 25 replicas, then scale down to 0 replicas after 15 minutes"
    exit 1
fi
delay_minutes=$2
n_down_to=${3:-0}

MY_DIR=$(dirname "${BASH_SOURCE[0]}")
source ${MY_DIR}/../set_config.sh
# https://gitter.im/jupyterhub/jupyterhub?at=5f885a30bbffc02b581aafe8
# https://kubernetes.io/docs/tasks/run-application/scale-stateful-set/
echo "Scaling to $n_replicas"
kubectl scale sts/user-placeholder --replicas ${n_replicas}
if [ -z "$delay_minutes" ]; then
    echo "Scaled to $n_replicas"
    exit 0
fi
let "delay_seconds = $delay_minutes * 60"
echo "Waiting for $delay_minutes minutes"
sleep $delay_seconds
echo "Scaling to $n_down_to"
kubectl scale sts/user-placeholder --replicas ${n_down_to}
