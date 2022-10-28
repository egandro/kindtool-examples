# https://kind.sigs.k8s.io/docs/user/private-registries/

export KUBECONFIG?=$(shell kindtool get kubeconfig)
REGISTRY_PREFIX?=$(shell kindtool get internal_registry_prefix)
REGISTRY_PREFIX?=$(shell kindtool get internal_registry_prefix)

#
#  we don't use helm/kustomize - the image in the yaml file is "localhost:5001/myapp:latest"
#
BASE_NAME=myapp
IMAGE_NAME=$(REGISTRY_PREFIX)/${BASE_NAME}:latest

run: start-cluster example-internal-registry test-service

start-cluster:
	kindtool up

stop-cluster:
	kindtool destroy -f

example-internal-registry:
	docker rmi -f $(IMAGE_NAME)
	docker build -t $(IMAGE_NAME) ./app
	kind load docker-image $(IMAGE_NAME) --name $$(kindtool get name)
	@# prevent race condition - wait until the serice account is ready
	./scripts/wait-for-service-account.sh
	kubectl apply -f deployment/myapp-pod.yaml
	./scripts/wait-for-pod.sh myapp-pod

test-service:
	kubectl exec -it myapp-pod -- /bin/sh -c 'cat /app/info.txt'

remove-example-internal-registry:
	kubectl delete -n default pod myapp-pod
