# https://github.com/kubernetes-sigs/kind/blob/main/site/static/examples/config-with-mounts.yaml
#
# https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/
# 	kubectl apply -f https://k8s.io/examples/pods/storage/pv-volume.yaml
#	kubectl apply -f https://k8s.io/examples/pods/storage/pv-claim.yaml
#	kubectl apply -f https://k8s.io/examples/pods/storage/pv-pod.yaml


export KUBECONFIG?=$(shell kindtool get kubeconfig)

run: start-cluster example-storage-workers test-service

start-cluster:
	kindtool up

stop-cluster:
	@# as docker creates files as root, you need to run this as sudo
	@# sudo kindtool destroy -f
	@# that is why we go without the -f
	kindtool destroy

example-storage-workers:
	kubectl apply -f deployment/storage-shared-volume.yaml
	kubectl apply -f deployment/storage-worker-volume.yaml
	kubectl apply -f deployment/storage-shared-claim.yaml
	kubectl apply -f deployment/storage-worker-claim.yaml
	sleep 10
	kubectl apply -f deployment/storage-pod-worker1.yaml
	kubectl apply -f deployment/storage-pod-worker2.yaml
	kubectl apply -f deployment/storage-pod-worker3.yaml
	./scripts/wait-for-pod.sh storage-pod-worker1
	./scripts/wait-for-pod.sh storage-pod-worker2
	./scripts/wait-for-pod.sh storage-pod-worker3

test-service:
	kubectl exec -it storage-pod-worker1 -- /bin/bash -c 'date > /data/worker/print_to_worker1_local_data'
	kubectl exec -it storage-pod-worker2 -- /bin/bash -c 'date > /data/worker/print_to_worker2_local_data'
	kubectl exec -it storage-pod-worker3 -- /bin/bash -c 'date > /data/worker/print_to_worker3_local_data'

	kubectl exec -it storage-pod-worker1 -- /bin/bash -c 'date > /data/shared/ping_to_shared'
	kubectl exec -it storage-pod-worker2 -- /bin/bash -c 'ls /data/shared/ping_to_shared'
	kubectl exec -it storage-pod-worker2 -- /bin/bash -c 'ls /data/shared/ping_to_shared'

	ls  .kind/data/worker1
	ls  .kind/data/worker2
	ls  .kind/data/worker3

	ls  .kind/data/shared

remove-example-storage-workers:
	kubectl delete -n default pod storage-pod-worker1
	kubectl delete -n default pod storage-pod-worker2
	kubectl delete -n default pod storage-pod-worker3
	kubectl delete persistentvolumeclaim storage-shared-claim
	kubectl delete persistentvolumeclaim storage-worker-claim
	kubectl delete persistentvolume storage-shared-volume
	kubectl delete persistentvolume storage-worker-volume
