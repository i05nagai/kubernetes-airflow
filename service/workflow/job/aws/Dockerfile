ARG DOCKER_REGISTRY_HOST
ARG DOCKER_IMAGE_BASE
FROM ${DOCKER_REGISTRY_HOST}/${DOCKER_IMAGE_BASE}/core:latest

RUN \
    apt-get update \
    # awscli
    && apt-get install \
        -y \
        groff \
    && pip install \
        setuptools \
        wheel \
    && pip install \
        awscli \
    # Cleanups
    && /opt/local/core/build_cleanup.sh


COPY ./opt /opt
ENTRYPOINT ["/opt/local/core/entrypoint.sh"]
