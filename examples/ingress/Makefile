

# https://kind.sigs.k8s.io/docs/user/ingress/
# https://projectcontour.io/kindly-running-contour/
# https://mjpitz.com/blog/2020/10/21/local-ingress-domains-kind/

# kubectl get nodes --show-labels
# kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/usage.yaml # nodeSelector missing


export CLUSTER_HTTP_PORT=$(shell kindtool get ingress_http_port)
export CLUSTER_HTTPS_PORT=$(shell kindtool get ingress_https_port)
export KUBECONFIG?=$(shell kindtool get kubeconfig)

run: start-cluster example-ingress test-service

start-cluster:
	kindtool up

stop-cluster:
	kindtool destroy -f

example-ingress:
	kubectl apply -f deployment/ingress.yaml
	./scripts/wait-for-pod.sh foo
	./scripts/wait-for-pod.sh bar

test-service:
	curl localhost:$(CLUSTER_HTTP_PORT)/foo
	curl localhost:$(CLUSTER_HTTP_PORT)/bar

remove-example-ingress:
	kubectl delete -n default ingress example-ingress
	kubectl delete -n default service bar-service
	kubectl delete -n default service foo-service
	kubectl delete -n default pod bar-app
	kubectl delete -n default pod foo-app
