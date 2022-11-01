# Basics


## Do something with your new cluster

```shell
$ cd apps/hello_world
$ kindtool up

# install a deployment using the echo server
$ kubectl create deployment hello-node --image=registry.k8s.io/echoserver:1.4

# show that it was successfull...
$ kubectl get deployments

# ... and it created a pod
$ kubectl get pods

# ... good by cluster
$ kindtool destroy -f
```

That was not super usefull, yet! There is no networking exposed to the world.

ddd