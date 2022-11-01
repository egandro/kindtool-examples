# Kubeconfig

## Dealing with kubeconfig

Kubectl will look for your k8s configuration in two places.

```shell
env Variable KUBECONFIG
or $HOME/.kube ( %USERPROFILE%\.kube on Windows)
```

kindfile.yaml supports a cool option

```yaml
local_kubeconfig: true
```

If this is set, the `config` file is created in the `$(kindfile_yaml_dir).kind/config` folder.

You can use kindtool to get it `kindtool get kubeconfig`.

How is this useful?

```yaml
# add this on top of your Makefiles to get some isolation of kubeconfigs
export KUBECONFIG?=$(shell kindtool get kubeconfig)
```

## Access your cluster from your internal network via kubectl / openlens

### Start server

```shell
# your server computer (VM, Linux, developer machine in internal network, ...)

$ cd apps/hello_world
$ kindtool up

# just for info get the IP/port of the k8s API Server
$ kubectl cluster-info --context kind-kind

# meet your kubectl config file (this gives you godlevel access to the cluster)

$ ls -la $HOME/.kube/config

# or as you learned use kindtool (usefull with the `local_kubeconfig: true` option)

$ kindtool get kubeconfig
```


### Prepare client

Linux:

```shell
# install kubectl: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

$ mkdir -p $HOME/.kube
$ cd $HOME/.kube

# get config from server (or what `kindtool get kubeconfig` returned)
$ scp <ip_or_name_of_kind_server>:/home/tha_user/.kube/config .

# get the same information as on your server
$ kubectl cluster-info --context kind-kind
```


Windows:

```
# install kubeclt (Windows): https://community.chocolatey.org/packages/kubernetes-cli

$ mkdir %USERPROFILE%\.kube
$ cd %USERPROFILE%\.kube
`
# install the $HOME/.kube/config (or what `kindtool get kubeconfig` returned) file here ^^^
$ kubectl cluster-info --context kind-kind
```

Hint: After you setup the local .kube/config files, you can use GUI tools like OpenLens <https://github.com/MuhammedKalkan/OpenLens>.

## Pitfalls

After deleting the cluster on your server computer with `kindtool destroy` the config files on your clients are invalid and needs to be updated on the client computer. Restarting docker / k8s / computer however won't change the config file.

