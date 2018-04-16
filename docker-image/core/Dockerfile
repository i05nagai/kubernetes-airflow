FROM ubuntu:16.04

RUN  apt-get update \
    && apt-get install -y \
        --no-install-recommends \
        sudo \
        curl \
        python \
        python-pip \
    && pip install \
        setuptools \
        wheel

COPY ./opt /opt
RUN /opt/local/core/build_cleanup.sh
ENTRYPOINT ["/opt/local/core/entrypoint.sh"]
