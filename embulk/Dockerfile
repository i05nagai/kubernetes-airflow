FROM java:8
MAINTAINER i05nagai

ENV EMBULK_VERSION=0.8.38 \
    PATH_TO_EMBULK=/opt/local/embulk \
    PATH=${PATH}:/opt/local/embulk
RUN mkdir -p ${PATH_TO_EMBULK} \
    && curl -L "https://bintray.com/artifact/download/embulk/maven/embulk-${EMBULK_VERSION}.jar" -o "${PATH_TO_EMBULK}/embulk" \
    && chmod +x "${PATH_TO_EMBULK}/embulk"

WORKDIR "${PATH_TO_EMBULK}"
COPY ./opt /opt
RUN ${PATH_TO_EMBULK}/embulk bundle install

ENTRYPOINT ["bash", "./entrypoint.sh"]
CMD ["--help"]
