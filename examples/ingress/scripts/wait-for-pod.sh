#!/bin/bash

POD=$1
NAMESPACE=$2

if [ -z "$2" ]; then
    NAMESPACE='default'
fi

echo "waiting for pod ${POD} to become ready"
while true; do
    kubectl get pods \
            --namespace=${NAMESPACE} \
            -l app=${POD} \
            -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}' 2>/dev/null | grep -o True >/dev/null && break
    sleep 1
done