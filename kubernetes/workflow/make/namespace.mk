# namespace
create-namespace:
	kubectl create namespace ${KUBERNETES_NAMESPACE}

delete-namespace:
	kubectl delete namespace ${KUBERNETES_NAMESPACE}
