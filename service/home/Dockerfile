ARG DOCKER_REGISTRY_HOST
ARG DOCKER_IMAGE_BASE
FROM ${DOCKER_REGISTRY_HOST}/${DOCKER_IMAGE_BASE}/core:latest

## Software Instllations

# You can install arbitary software here.
# SSH
RUN \
  apt-get update \
  && apt-get install -y \
      openssh-server\
      ssh \
      supervisor \
      netcat \
      git \
      tmux \
      vim \
      build-essential \
      docker.io \
  && mkdir /var/run/sshd \
  && chmod 0755 /var/run/sshd \
  && /opt/local/core/build_cleanup.sh

# embulk
RUN \
    apt-get update \
    && apt-get install -y \
            openjdk-8-jdk \
    && curl -L "https://bintray.com/artifact/download/embulk/maven/embulk-0.8.38.jar" -o "/usr/local/bin/embulk" \
    && chmod +x "/usr/local/bin/embulk" \
    && /opt/local/core/build_cleanup.sh

# aws cli
RUN \
    pip install --upgrade awscli \
    && /opt/local/core/build_cleanup.sh

# gcloud
ENV CLOUD_SDK_VERSION=190.0.1
RUN \
    apt-get -qqy update \
    && apt-get install -qqy \
        apt-transport-https \
        lsb-release \
        openssh-client \
    && pip install -U crcmod \
    && export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" \
    && echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" > /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && apt-get update \
    && apt-get install -y \
        google-cloud-sdk=${CLOUD_SDK_VERSION}-0 \
        google-cloud-sdk-app-engine-python=${CLOUD_SDK_VERSION}-0 \
        google-cloud-sdk-app-engine-java=${CLOUD_SDK_VERSION}-0 \
        google-cloud-sdk-app-engine-go=${CLOUD_SDK_VERSION}-0 \
        google-cloud-sdk-datalab=${CLOUD_SDK_VERSION}-0 \
        google-cloud-sdk-datastore-emulator=${CLOUD_SDK_VERSION}-0 \
        google-cloud-sdk-pubsub-emulator=${CLOUD_SDK_VERSION}-0 \
        google-cloud-sdk-bigtable-emulator=${CLOUD_SDK_VERSION}-0 \
        google-cloud-sdk-cbt=${CLOUD_SDK_VERSION}-0 \
        kubectl \
    && gcloud config set core/disable_usage_reporting true \
    && gcloud config set component_manager/disable_update_check true \
    && gcloud config set metrics/environment github_docker_image \
    && gcloud --version \
    && docker --version \
    && kubectl version --client \
    && /opt/local/core/build_cleanup.sh

# bash_completion
RUN \
    apt-get -qqy update \
    && apt-get install -qqy \
        bash-completion \
    && /opt/local/core/build_cleanup.sh

# You can put your configurations here.
COPY ./skelton /

EXPOSE 22

## Bootstrap

ENTRYPOINT ["/opt/local/core/entrypoint.sh", "/opt/local/home/entrypoint.sh", "/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
