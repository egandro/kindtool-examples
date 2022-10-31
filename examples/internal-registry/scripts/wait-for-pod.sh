#!/bin/sh

POD=$1
NAMESPACE=$2

if [ -z "$2" ]; then
    NAMESPACE='default'
fi

echo "waiting for pod ${POD} to become ready"
while true; do
    kubectl get pods \
            --namespace=${NAMESPACE} \
            ${POD} \
            -o jsonpath='{.status.containerStatuses[0].ready}' 2>/dev/null | grep -o true >/dev/null && break
    sleep 1
done

