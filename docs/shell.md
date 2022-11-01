# Shell to Kubernetes


Manual way

```shell
# create a pod to play with
$ kubectl run --stdin --tty k8sshell --image=ubuntu:22.04 --command -- /bin/bash

# reattach to the pod
$ kubectl exec --stdin --tty k8sshell -- /bin/bash

# delete the pod
$ kubectl delete pod k8sshell
```

Shortcut in kindtool

```shell
# create a pod to play with
$ kindtool shell

# reattach to the pod
$ kindtool shell

# delete the pod
$ kindtool shell -k
```

Kindtool supports the following options:

- pod (name of the pod)
- image (name of the image e.g. 'alpine:latest')
- cmd (commmand to execute - default "guestimate" shell e.g. bash, ash, sh)
- namespace (k8s namespace)
