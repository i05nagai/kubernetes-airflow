ARG DOCKER_REGISTRY_HOST
ARG DOCKER_IMAGE_BASE
FROM ${DOCKER_REGISTRY_HOST}/${DOCKER_IMAGE_BASE}/embulk:latest

COPY ./opt/local/workflow/job/job1/Gemfile /opt/local/workflow/job/job1/Gemfile
RUN \
    cd /opt/local/workflow/job/job1 \
    && embulk bundle install
COPY ./opt /opt
ENTRYPOINT ["/opt/local/core/entrypoint.sh", "/opt/local/workflow/job/job1/entrypoint.sh"]
