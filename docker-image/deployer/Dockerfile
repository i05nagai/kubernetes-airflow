ARG DOCKER_REGISTRY_HOST
ARG DOCKER_IMAGE_BASE
FROM ${DOCKER_REGISTRY_HOST}/${DOCKER_IMAGE_BASE}/kubectl:latest

COPY ./opt /opt
ENTRYPOINT ["/opt/local/core/entrypoint.sh", "/opt/local/deployer/entrypoint.sh"]
