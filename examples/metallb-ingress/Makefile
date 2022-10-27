# https://kind.sigs.k8s.io/docs/user/loadbalancer/
# ubectl apply -f https://kind.sigs.k8s.io/examples/loadbalancer/usage.yaml

# https://kind.sigs.k8s.io/docs/user/ingress/
# kubectl get nodes --show-labels
# kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/usage.yaml # nodeSelector missing

SHELL := /bin/bash
export CLUSTER_HTTP_PORT=$(shell kindtool get ingress_http_port)
export CLUSTER_HTTPS_PORT=$(shell kindtool get ingress_https_port)
export KUBECONFIG?=$(shell kindtool get kubeconfig)

run: start-cluster example-metallb-ingress test-service

start-cluster:
	kindtool up

stop-cluster:
	kindtool destroy -f

example-metallb-ingress:
	kubectl apply -f deployment/metallb-ingress.yaml
	./scripts/wait-for-pod.sh foo-app
	./scripts/wait-for-pod.sh bar-app

test-service:
	for _ in {1..10}; do curl localhost:$(CLUSTER_HTTP_PORT)/foo-or-bar-lb; done

remove-example-metallb-ingress:
	kubectl delete -n default ingress example-ingress
	kubectl delete -n default service foo-service
	kubectl delete -n default pod bar-app
	kubectl delete -n default pod foo-app