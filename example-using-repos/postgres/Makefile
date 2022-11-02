export KUBECONFIG?=$(shell kindtool get kubeconfig)

run: start-cluster

start-cluster:
	kindtool up

start-db:
	kindtool app up my-postgres

stop-db:
	kindtool app destroy my-postgres

stop-cluster:
	kindtool destroy -f
