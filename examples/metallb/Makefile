# https://kind.sigs.k8s.io/docs/user/loadbalancer/
# kubectl apply -f https://kind.sigs.k8s.io/examples/loadbalancer/usage.yaml

SHELL := /bin/bash
export KUBECONFIG?=$(shell kindtool get kubeconfig)

run: start-cluster example-metallb test-service

start-cluster:
	kindtool up

stop-cluster:
	kindtool destroy -f

example-metallb:
	kubectl apply -f deployment/metallb.yaml
	./scripts/wait-for-pod.sh foo-app
	./scripts/wait-for-pod.sh bar-app

test-service:
	LB_IP=$$(kubectl get svc/foo-service -o=jsonpath='{.status.loadBalancer.ingress[0].ip}') && \
	echo IP of the loadbalancer: $${LB_IP} && \
	for _ in {1..10}; do curl $${LB_IP}:5678; done

remove-example-metallb:
	kubectl delete -n default service foo-service
	kubectl delete -n default pod bar-app
	kubectl delete -n default pod foo-app
