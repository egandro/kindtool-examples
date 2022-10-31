# Kubernetes dashboard

You can start the kubernetes Dashboard at any time.

```
$ kindtool dashboard [-v version of dashboard]
```

This will install the k8s dashbard (if not present). I also creates an admin user/admin role for the dahboard and creates an access token.

The token is keped in `$(Kindfile_dir)/.kind/config/token`.


## Accessing the dashboard

After the dashboard is running you can access the dashboard via kubectl. That can be:

1) the developer machine
2) any other machine where you have setup `kubectl` acces e.g. via a copy of the [Kubeconfig](kubeconfig.md).

```
$ KUBECONFIG=$(kindtool get kubeconfig) kubectl proxy

# open on computer running kubectl proxy
# http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

# enter the tokein in `$(Kindfile_dir)/.kind/config/token`
```


## Pitfalls

The token changes after a cluster is recreated.

