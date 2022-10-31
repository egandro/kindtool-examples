# Internal Docker Registry

In case you want to do create your own docker containers on your developer machine, you will need a local registry in your kind cluster.

k8s can perfectly download any images from the official docker registry. However your images on your development machine are on your developer machine.

## Kindfile

```
internal_registry=true
# <clustername>-registry is the default
internal_registry_docker_name=
# 5001 is the default
internal_registry_docker_port=
```

## Workflow

Your app:

``` Dockerfile
FROM alpine
CMD  ["/bin/sh", "-ec", "while :; do echo '.'; sleep 5 ; done"]
```

Development:

```
$ BASE_NAME="myapp:latest"
$ docker build -t example.com/v1/myapps/$(BASE_NAME) .
```

### Uploading to internal registry using `kind load`

```
# e.g. "localhost:5001"
$ INTERNAL_REGISTRY_PREFIX?=$(shell kindtool get internal_registry_prefix)

# add a 2nd tag to your image
$ docker tag example.com/v1/myapps/$(BASE_NAME) $(INTERNAL_REGISTRY_PREFIX)/$(BASE_NAME)

# this uploads to all workers
$ kind load docker-image $(INTERNAL_REGISTRY_PREFIX)/$(BASE_NAME)--name $(kindtool get name)
```

You can now use the image in your k8s deployments e.g. `localhost:5001/myapp:latest`.


### Pitfalls

If you use lazy tags as `:latest` k8s won't replace the images so you have to force it.

```
# wont work with ":latest" tag, as there is no change on the deployment
$ kubectl apply -f deployment/myapp-pod.yaml

# just force the replacement (for develompment!)
# kubectl replace --force -f deployment/myapp-pod.yaml
```

Kind cluster with local registry - always put the ImagePullPolicy to 'Never' or 'IfNotPresent'

```
      #imagePullPolicy: IfNotPresent
      # or
      imagePullPolicy: Never
```