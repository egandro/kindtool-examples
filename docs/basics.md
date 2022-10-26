# Basics


### Do something with your new cluster

```
$ cd 01_hello_world
$ kindtool up
$ kubectl create deployment hello-node --image=registry.k8s.io/echoserver:1.4
$ kubectl get deployments
$ kubectl get pods
$ kindtool destroy -f
```

(that was not super usefull, yet! there is no networking exposed to the world)

### Access your cluster from your internal network

#### Start server
```
# your server computer (VM, Linux, developer machine in internal network, ...)
$ cd 01_hello_world
$ kindtool up
# just for info get the IP/port of the k8s API Server
$ kubectl cluster-info --context kind-kind
# meet your kubectl config file (this gives you godlevel access to the cluster)
$ ls -la $HOME/.kube/config
```

#### Prepare client

Linux:

```
# install kubectl: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
$ mkdir -p $HOME/.kube
$ cd $HOME/.kube
# get config from server
$ scp <ip_or_name_of_kind_server>:/home/tha_user/.kube/config .
# get the same information as on your server
$ kubectl cluster-info --context kind-kind
```


Windows:

```
# install kubeclt (Windows): https://community.chocolatey.org/packages/kubernetes-cli
$ mkdir %USERPROFILE%\.kube
$ cd %USERPROFILE%\.kube
# install the $HOME/.kube/config file here ^^^
$ kubectl cluster-info --context kind-kind
```

Hint: after you setup the local .kube/config files, you can use GUI tools like OpenLens <https://github.com/MuhammedKalkan/OpenLens>.

Pitfall: after deleting the cluster on your server computer with `kindtool destroy` the config files on your clients are also gone.