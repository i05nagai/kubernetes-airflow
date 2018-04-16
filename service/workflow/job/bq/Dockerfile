ARG DOCKER_REGISTRY_HOST
ARG DOCKER_IMAGE_BASE
FROM ${DOCKER_REGISTRY_HOST}/${DOCKER_IMAGE_BASE}/core:latest

RUN pip install \
    google-cloud-bigquery \
    pytest==3.1.2 \
    pytest-cov \
    pytest-pep8 \
    pytest-mock==1.6.2

COPY ./opt /opt
ENTRYPOINT ["/opt/local/core/entrypoint.sh", "/opt/local/workflow/job/bq/entrypoint.sh"]
