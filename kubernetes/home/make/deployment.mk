# nfs-server
deploy-nfs-server:
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/deployment/nfs-server.yml $(KUBERNETES_OPTIONS)

delete-nfs-server:
	kubectl delete -f ${PATH_TO_KUBERNETES}/deployment/nfs-server.yml

# home
deploy-home:
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/deployment/home.yml $(KUBERNETES_OPTIONS)

delete-home:
	kubectl delete -f ${PATH_TO_KUBERNETES}/deployment/home.yml

# docker
deploy-docker:
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/deployment/docker.yml $(KUBERNETES_OPTIONS)

delete-docker:
	kubectl delete -f ${PATH_TO_KUBERNETES}/deployment/docker.yml

