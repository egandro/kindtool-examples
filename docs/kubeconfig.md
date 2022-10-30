# kubeconfig

## Dealing with kubeconfig

Kubectl will look for your k8s configuration in two places.

```
env Variable KUBECONFIG
or $HOME/.kube ( %USERPROFILE%\.kube on Windows)
```

Kubefile supports a cool option

```
local_kubeconfig=true
```

If this is set, the `config` file is created in the `$(Kindfile_dir).kind/config` folder.

You can use kindtool to get it `kindtool get kubeconfig`.

How is this useful?

```
# add this on top of your Makefiles to get some isolation of kubeconfigs
export KUBECONFIG?=$(shell kindtool get kubeconfig)
```
