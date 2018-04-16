ARG DOCKER_REGISTRY_HOST
ARG DOCKER_IMAGE_BASE
FROM ${DOCKER_REGISTRY_HOST}/${DOCKER_IMAGE_BASE}/core:latest

#
# bash-completion
#
RUN \
    apt-get update \
    && apt-get install -y \
        autoconf \
        git \
        make \
    && /opt/local/core/build_cleanup.sh

RUN \
    git clone https://github.com/scop/bash-completion.git /tmp/bash-completion \
    && cd /tmp/bash-completion \
    # if not installing from prepared release tarball
    && autoreconf -i \
    && ./configure \
    && make \
    # optional, requires dejagnu and tcllib
    && make check \
    # as root
    && make install

COPY ./skelton /
ENTRYPOINT ["/opt/local/core/entrypoint.sh"]

