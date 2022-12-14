# Storage

Starting a pod k8s won't persist data after the pod has been stopped or restarted.

For this reason you need to deal with persistan storage.

## kindfile.yaml

```yaml
mountpoints: true
# default is $(kindfile_yaml_dir)/.kind/data
mount_dir: None
```

## Storage Points manifest

kindtool creates two different kind of storage points

- `/data/shared` this will be shared among all worker nodes (including the controller)
- `/data/worker` this is specific created per worker.

Your `$(kindfile_yaml_dir)/.kind/data` will contain the following directories:

```
data/shared
data/controller
```

Optional if kindfile.yaml has `worker_nodes=X
`
```
data/worker1
...
data/workerX
```

Check this in `$(kindfile_yaml_dir)/.kind/data/config.yaml`


## Using storage

- Create a PersistentVolume in k8s, use `/data/shared/YOUR_NAME` or `/data/worker/YOUR_NAME` path.
- Create a Storage Claim based on that Persistent Volume.


If you go with multiple workers, you might want specific serices using worker only storage. You need to select the node

```yaml
specs:
  #[...]
  nodeSelector:
    "worker2": "true" # Keep this pod on this worker e.g. you want your postgres/mysql always on worker2
```

## Pitfalls

Docker Container may run with root users or all sorts of UID/GID Linux groups. Pay attention that `$(kindfile_yaml_dir)/.kind/data` might have data that belongs "root" even other users. For this reason `kindtool destroy -f` may need to be run sudo'ed.

