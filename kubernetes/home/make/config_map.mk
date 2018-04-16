# config map
create-config-map:
	${PATH_TO_KUBERNETES_EXEC} create ${PATH_TO_KUBERNETES}/config-map/home-environment-variable.yml $(KUBERNETES_OPTIONS)

delete-config-map:
	${PATH_TO_KUBERNETES_EXEC} delete ${PATH_TO_KUBERNETES}/config-map/home-environment-variable.yml $(KUBERNETES_OPTIONS)
