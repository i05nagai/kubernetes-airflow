ARG DOCKER_REGISTRY_HOST
ARG DOCKER_IMAGE_BASE
FROM ${DOCKER_REGISTRY_HOST}/${DOCKER_IMAGE_BASE}/core:latest

# Init apt
RUN \
    apt-get update \
    && apt-get install -y \
        python3-dev \
    # Install python3
    && apt-get install -y \
        python3 \
        python3-pip \
    # Cleanups
    && /opt/local/core/build_cleanup.sh
