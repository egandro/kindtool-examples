# https://kind.sigs.k8s.io/docs/user/private-registries/

export KUBECONFIG?=$(shell kindtool get kubeconfig)
INTERNAL_REGISTRY_PREFIX?=$(shell kindtool get internal_registry_prefix)


REGISTRY_PREFIX=example.com/v1/myapps
IMAGE_BASE_NAME=myapp
IMAGE_VERSION?=latest
IMAGE_NAME=$(REGISTRY_PREFIX)/${IMAGE_BASE_NAME}:$(IMAGE_VERSION)

#
#  we don't use helm/kustomize - the image in the yaml file is "localhost:5001/myapp:latest"
#
INTERNAL_REGISTRY_IMAGE_NAME=$(INTERNAL_REGISTRY_PREFIX)/${IMAGE_BASE_NAME}:$(IMAGE_VERSION)

run: start-cluster example-internal-registry test-service

start-cluster:
	kindtool up

stop-cluster:
	kindtool destroy -f

example-internal-registry:
	docker rmi -f $(IMAGE_NAME)
	docker build -t $(IMAGE_NAME) ./app
	docker tag $(IMAGE_NAME) $(INTERNAL_REGISTRY_IMAGE_NAME)
	kind load docker-image $(INTERNAL_REGISTRY_IMAGE_NAME) --name $$(kindtool get name)
	@# prevent race condition - wait until the serice account is ready
	./scripts/wait-for-service-account.sh
	@# as we use no nice tags and go by ":latest", we need to use replace
	@# kubectl apply -f deployment/myapp-pod.yaml
	kubectl replace --force -f deployment/myapp-pod.yaml
	./scripts/wait-for-pod.sh myapp-pod

test-service:
	kubectl exec -it myapp-pod -- /bin/sh -c 'cat /app/info.txt'

remove-example-internal-registry:
	kubectl delete -n default pod myapp-pod
