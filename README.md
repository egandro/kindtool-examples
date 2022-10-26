# kindtool-examples

Examples for kindtool <https://github.com/egandro/kindtool>

WARNING: Do not put kind clusters with an exposed port API port to the internet!

## Installation

Requirements:

- docker
- python3
- kind

### Kind installation

Official documentation: <https://kind.sigs.k8s.io/docs/user/quick-start/>

Fast lane:


```
get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}
KIND_LATEST=$(get_latest_release kubernetes-sigs/kind)
ARCH=$(dpkg --print-architecture 2>/dev/null || echo "amd64")

curl -Lo ./kind https://kind.sigs.k8s.io/dl/${KIND_LATEST}/kind-linux-${ARCH}
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```

### Kindtool installation

```
$ pip install kindtool
```

## Quickstarts


### Hello World

```
$ cd 01_hello_world
$ kindtool up
$ kubectl cluster-info  --context kind-kind
$ kindtool destroy
```

Hint: You get something like `cluster kind is already running`?

```
# manually destroy the cluster
$ kind delete cluster -n kind
```

Hindt: remove config files on termination

```
# this also removes the .kind folder
$ kindtool destroy -f
```

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