export KUBECONFIG?=$(shell kindtool get kubeconfig)

run: start-cluster

start-cluster:
	kindtool up

stop-cluster:
	kindtool destroy -f
