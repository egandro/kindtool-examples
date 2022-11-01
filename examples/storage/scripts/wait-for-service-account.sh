#!/bin/sh

echo "waiting for service account to become ready ready"

# this prevents a race condition for k8s clusters during bootup
# idea from: https://github.com/puppetlabs/puppetlabs-kubernetes/pull/247

while true; do
	kubectl -n default get serviceaccount default -o name 2>/dev/null && break
    sleep 1
done

