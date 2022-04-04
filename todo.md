# Setting up cluster

At the moment, I believe, if the NFS pod goes down, it might come up with a different IP address.

It may be desirable to reserve an IP address for the NFS server:

See <https://cloud.google.com/compute/docs/ip-addresses/reserve-static-internal-ip-address>

I think this involves:

* Creating a VPC network.
* Creating a subnet.
* Starting the cluster within that subnet.
* Reserving the IP address.
* Putting the IP address into `spec` for the deployment.  Maybe:

```yaml
# https://kubernetes.io/docs/concepts/workloads/controllers/deployment/
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nfs-server
spec:
  replicas: 1
  selector:
    matchLabels:
      # Manage pods matching these key: value pairs.
      role: nfs-server
  template:
    metadata:
      labels:
        role: nfs-server
    spec:
      clusterIP: 10.100.0.82
      containers:
      - name: nfs-server
      ...
```

(From `kubectl get service nfs-server -o yaml`).

I believe this also involves setting up [Cloud
NAT](https://cloud.google.com/nat/docs/overview) so users can access their
pods from outside the cluster.
