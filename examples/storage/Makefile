# https://github.com/kubernetes-sigs/kind/blob/main/site/static/examples/config-with-mounts.yaml
#
# https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/
# 	kubectl apply -f https://k8s.io/examples/pods/storage/pv-volume.yaml
#	kubectl apply -f https://k8s.io/examples/pods/storage/pv-claim.yaml
#	kubectl apply -f https://k8s.io/examples/pods/storage/pv-pod.yaml


export KUBECONFIG?=$(shell kindtool get kubeconfig)

run: start-cluster example-storage test-service

start-cluster:
	kindtool up

stop-cluster:
	@# as docker creates files as root, you need to run this as sudo
	@# sudo kindtool destroy -f
	@# that is why we go without the -f
	kindtool destroy

example-storage:
	kubectl apply -f deployment/storage-shared-volume.yaml
	kubectl apply -f deployment/storage-worker-volume.yaml
	kubectl apply -f deployment/storage-shared-claim.yaml
	kubectl apply -f deployment/storage-worker-claim.yaml
	sleep 10
	kubectl apply -f deployment/storage-pod.yaml
	./scripts/wait-for-pod.sh storage-pod

test-service:
	kubectl exec -it storage-pod -- /bin/ls -la /data/shared /data/worker
	kubectl exec -it storage-pod -- /bin/bash -c 'date > /data/shared/ping_to_shared'
	kubectl exec -it storage-pod -- /bin/bash -c 'date > /data/worker/ping_to_worker_local_data'
	ls -la .kind/data/controller
	ls -la .kind/data/shared

remove-example-storage:
	kubectl delete -n default pod storage-pod
	kubectl delete persistentvolumeclaim storage-shared-claim
	kubectl delete persistentvolumeclaim storage-worker-claim
	kubectl delete persistentvolume storage-shared-volume
	kubectl delete persistentvolume storage-worker-volume
