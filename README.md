# kindtool-examples

Examples for kindtool <https://github.com/egandro/kindtool>

WARNING: Do not put kind clusters with an exposed port API port to the internet!

## Installation

Requirements:

- docker
- python3
- kind
- kubectl

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
$ pip3 install kindtool
```


## Hello World

```
$ cd apps/hello_world
$ kindtool up
$ kubectl cluster-info --context kind-kind
$ kindtool destroy
```

Hint: You get something like `cluster kind is already running`?

```
# manually destroy the cluster
$ kind delete cluster -n kind
```

Hint: remove config files on termination

```
# this also removes the .kind folder
$ kindtool destroy -f
```

Hint: the default kubeconfig approach of kind is used (that is ether `$KUBECONFIG` or `$HOME/.kube/config`. kindtool offers a better approach - see [kubeconfig](docs/kubeconfig.md) )

## Documentation


- [Basics](docs/basics.md)
- [Kubeconfig](docs/kubeconfig.md)
- [Ingress](docs/ingress.md)

### TBD

- kustomize / helm / Variables in yamls


- [kindtool basic](docs/basics.md)
- [kubeconfig](docs/kubeconfig.md)
- [accessing the cluster from developer machine](docs/developermachine.md)
- [k8s dashboard](docs/dashboard.md)
- [k8shell](docs/k8shell.md)
- [localregistry](docs/localregistry.md)
- [ingress](docs/ingress.md)
- [local docer registry](docs/registry.md)
- [loadbalancer](docs/loadbalancer.md)
- [port forwarding](docs/ports.md)

## Sample Applications

- TBD