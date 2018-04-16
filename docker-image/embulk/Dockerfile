ARG DOCKER_REGISTRY_HOST
ARG DOCKER_IMAGE_BASE
FROM ${DOCKER_REGISTRY_HOST}/${DOCKER_IMAGE_BASE}/java8:latest

ENV EMBULK_VERSION=0.8.38 \
    PATH_TO_EMBULK=/opt/local/embulk \
    PATH_TO_EMBULK_BIN=/usr/local/bin \
    PATH=${PATH}:/usr/local/bin

RUN mkdir -p ${PATH_TO_EMBULK} \
    && curl -L "https://bintray.com/artifact/download/embulk/maven/embulk-${EMBULK_VERSION}.jar" -o "${PATH_TO_EMBULK_BIN}/embulk" \
    && chmod +x "${PATH_TO_EMBULK_BIN}/embulk"

WORKDIR "${PATH_TO_EMBULK}"
COPY ./opt /opt

RUN ${PATH_TO_EMBULK_BIN}/embulk bundle install

ENTRYPOINT ["/opt/local/core/entrypoint.sh", "/opt/local/embulk/entrypoint.sh"]
CMD ["--help"]
