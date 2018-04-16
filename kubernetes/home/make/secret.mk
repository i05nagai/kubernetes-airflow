# secret
create-secret:
	${PATH_TO_KUBERNETES_EXEC} create ${PATH_TO_KUBERNETES}/secret/home-environment-variable.yml $(KUBERNETES_OPTIONS)

delete-secret:
	${PATH_TO_KUBERNETES_EXEC} delete ${PATH_TO_KUBERNETES}/secret/home-environment-variable.yml $(KUBERNETES_OPTIONS)
