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
	kubectl get svc/foo-service -o=jsonpath='{.status.loadBalancer.ingress[0].ip}'
	echo ""
	@kubectl delete pod testapp-pod 2>/dev/null >/dev/null || true
	kubectl run --stdin --tty testapp-pod --image=alpine --command -- \
		 /bin/sh -c 'apk add curl && for _ in [1 2 3 4 5 6 7 8 9 10]; do curl http://foo-service:5678; done'
	kubectl delete pod testapp-pod

test-service-outside:
	LB_IP=$$(kubectl get svc/foo-service -o=jsonpath='{.status.loadBalancer.ingress[0].ip}') && \
	echo IP of the loadbalancer: $${LB_IP} && \
	for _ in {1..10}; do curl $${LB_IP}:5678; done

remove-example-metallb:
	kubectl delete -n default service foo-service
	kubectl delete -n default pod bar-app
	kubectl delete -n default pod foo-app
