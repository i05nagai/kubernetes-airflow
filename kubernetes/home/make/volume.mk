# pv
create-pv-nfs:
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/volume/pv-nfs.yml ${KUBERNETES_OPTIONS}

delete-pv-nfs:
	${PATH_TO_KUBERNETES_EXEC} delete ${PATH_TO_KUBERNETES}/volume/pv-nfs.yml ${KUBERNETES_OPTIONS}

# pvc
create-pvc-nfs-home:
	${PATH_TO_KUBERNETES_EXEC} apply ${PATH_TO_KUBERNETES}/volume/pvc-nfs-home.yml ${KUBERNETES_OPTIONS}

delete-pvc-nfs-home:
	${PATH_TO_KUBERNETES_EXEC} delete ${PATH_TO_KUBERNETES}/volume/pvc-nfs-home.yml ${KUBERNETES_OPTIONS}

