ARG DOCKER_REGISTRY_HOST
ARG DOCKER_IMAGE_BASE
FROM ${DOCKER_REGISTRY_HOST}/${DOCKER_IMAGE_BASE}/cli-base:latest

RUN \
    apt-get update \
    && apt-get install -y \
        curl \
        python \
        make \
        lsb-release \
        gettext \
        apt-transport-https \
    && /opt/local/core/build_cleanup.sh

ENV CLOUD_SDK_VERSION 196.0.0
# gcp
RUN \
    export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" \
    && echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" > /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && apt-get update \
    && apt-get install -y \
        google-cloud-sdk=${CLOUD_SDK_VERSION}-0 \
        kubectl \
    && gcloud config set core/disable_usage_reporting true \
    && gcloud config set component_manager/disable_update_check true \
    && gcloud config set metrics/environment github_docker_image

COPY ./templates /
ENTRYPOINT ["/opt/local/core/entrypoint.sh", "/opt/local/kubectl/entrypoint.sh"]

