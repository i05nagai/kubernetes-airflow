ARG DOCKER_REGISTRY_HOST
ARG DOCKER_IMAGE_BASE
FROM ${DOCKER_REGISTRY_HOST}/${DOCKER_IMAGE_BASE}/core:latest

RUN \
    apt-get update \
    && apt-get install -y \
        make \
        docker.io \
    && /opt/local/core/build_cleanup.sh

COPY ./skelton /
ENTRYPOINT ["/opt/local/core/entrypoint.sh", "/opt/local/builder/entrypoint.sh"]
