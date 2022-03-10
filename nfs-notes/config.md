# Old notes on NFS

These notes are a bit disorganized, from lack of recent use.

I've left them here in case they are useful for debugging.

## Single disk procedure

Assumes GCE disk exists named `uobhub-data-disk`:

```
# Setup
kubectl create -f configs/data_volume.yaml
kubectl create -f configs/test_pd_deployment.yaml
kubectl get pod
```

```
# Test example.
kubectl exec test-deployment-5d8cb48cdd-m7b6x --stdin --tty -- /bin/sh
```

```
# Cleanup
kubectl delete deployment test-deployment
kubectl delete pvc pv-claim-demo
kubectl delete pv pv-demo
```

## NFS procedure

Assumes GCE disks exist named `uobhub-data-disk` and `uobhub-home-disk`:

```
# Setup
kubectl create -f configs/data_volume.yaml
kubectl create -f nfs-configs/nfs_deployment.yaml
kubectl create -f nfs-configs/nfs_service.yaml
kubectl create -f nfs-configs/nfs_pv_pvc.yaml
kubectl create -f nfs-configs/test_nfs_deployment.yaml
kubectl get pod
```

```
# Test example.
kubectl exec --stdin --tty test-deployment-5d8cb48cdd-m7b6x -- /bin/sh
```

```
# Cleanup
kubectl delete deployment test-deployment
kubectl delete service nfs-server
kubectl delete deployment nfs-server
kubectl delete pvc pv-claim-demo
kubectl delete pv pv-demo
kubectl delete pvc nfs
kubectl delete pv nfs
```
