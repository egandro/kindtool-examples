# Loadbalancer MetalLB

A loadbalancer is used to scale your internal services by an internal reverse proxy,
e.g. http://my-internal-service:<port>/v1/api will be served by multiple pods but is available on one address.

## Kindfile

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
