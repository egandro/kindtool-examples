# Loadbalancer MetalLB

A loadbalancer is used to scale your internal services by an internal reverse proxy,
e.g. http://my-internal-service:<port>/v1/api will be served by multiple pods but is available on one address.

## kindfile.yaml

```
metallb=true
```

## Deployment

```
kind: Service
apiVersion: v1
metadata:
  name: foo-service
spec:
  type: LoadBalancer
  selector:
    app: http-echo
  ports:
  # Default port used by the image
  - port: 5678
```


You can access your services with `http:/foo-service:5678/` from inside the cluster.


Usefull/Useless Hint: You can access the service via the internal IP Docker IP of metal LB of your kind pod:

```
# ip of the docker container
LB_IP=$(kubectl get svc/foo-service -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')

for _ in {1..10}; do curl http://${LB_IP}:5678; done
```