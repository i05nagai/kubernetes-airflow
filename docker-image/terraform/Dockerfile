ARG DOCKER_REGISTRY_HOST
ARG DOCKER_IMAGE_BASE
FROM ${DOCKER_REGISTRY_HOST}/${DOCKER_IMAGE_BASE}/core:latest

ENV TERRAFORM_VERSION=0.11.7 \
    TERRAFORM_SHA256SUM=6b8ce67647a59b2a3f70199c304abca0ddec0e49fd060944c26f666298e23418

RUN \
    apt-get update \
    && apt-get install -y \
        curl \
        unzip \
        git \
        make \
    && curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && echo "${TERRAFORM_SHA256SUM}  /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > /tmp/terraform_${TERRAFORM_VERSION}_SHA256SUMS \
    && sha256sum -c --strict /tmp/terraform_${TERRAFORM_VERSION}_SHA256SUMS \
    && unzip /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin \
    && rm -f /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && /opt/local/core/build_cleanup.sh

COPY ./opt /opt
ENTRYPOINT ["/opt/local/core/entrypoint.sh", "/opt/local/terraform/entrypoint.sh"]
