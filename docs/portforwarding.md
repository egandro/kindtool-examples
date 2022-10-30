# Port Forwarding

```
export KUBECONFIG?=$(shell kindtool get kubeconfig)

kubectl port-forward <pod-name> <source-pod-port>:<target-port-on-kubectl-machine>

kubectl port-forward <service-name> <source-service-port>:<target-port-on-kubectl-machine>

kubectl port-forward <deployment-name> <source-deployment-port>:<target-port-on-kubectl-machine>

kubectl port-forward <replicaset-name> <source-replicaset-port>:<target-port-on-kubectl-machine>
```