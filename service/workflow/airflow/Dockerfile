ARG DOCKER_REGISTRY_HOST
ARG DOCKER_IMAGE_BASE
FROM ${DOCKER_REGISTRY_HOST}/${DOCKER_IMAGE_BASE}/core:latest

# Never prompts the user for choices on installation/configuration of packages
ENV DEBIAN_FRONTEND noninteractive \
    TERM linux

# Airflow
ARG AIRFLOW_VERSION=1.9.0
ARG AIRFLOW_HOME=/opt/local/airflow
# ARG AIRFLOW_PACKAGES='crypto,celery,mysql,hive,hdfs,jdbc'
# ARG AIRFLOW_PACKAGES='crypto,celery,mysql,hive,jdbc'
ARG AIRFLOW_PACKAGES='crypto,celery,mysql,hive,jdbc,docker'

# for mysql
# libmysqlclient-dev

# for postgres
# psycopg2

# Define en_US.
ENV LANGUAGE en_US.UTF-8 \
    LANG en_US.UTF-8 \
    LC_ALL en_US.UTF-8 \
    LC_CTYPE en_US.UTF-8 \
    LC_MESSAGES en_US.UTF-8 \
    LC_ALL en_US.UTF-8


RUN set -ex \
    && buildDeps=' \
        python3-dev \
        libkrb5-dev \
        libsasl2-dev \
        libssl-dev \
        libffi-dev \
        build-essential \
        libblas-dev \
        liblapack-dev \
        libpq-dev \
        libmysqlclient-dev \
        git \
    ' \
    && apt-get update -yqq \
    && apt-get install -yqq --no-install-recommends \
        $buildDeps \
        python3 \
        python3-pip \
        apt-utils \
        curl \
        netcat \
        locales \
    && sed -i 's/^# en_US.UTF-8 UTF-8$/en_US.UTF-8 UTF-8/g' /etc/locale.gen \
    && locale-gen \
    && update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 \
    && mkdir -p ${AIRFLOW_HOME} \
    && useradd -ms /bin/bash -d ${AIRFLOW_HOME} airflow \
    && pip3 install --upgrade pip==9.0.1 \
    && pip3 install setuptools \
    && pip3 install wheel \
    && pip3 install Cython \
    && pip3 install pytz \
    && pip3 install pyOpenSSL \
    && pip3 install ndg-httpsclient \
    && pip3 install pyasn1 \
    && pip3 install pystache \
    && pip3 install slackweb \
    && pip3 install psycopg2 \
    && pip3 install apache-airflow[${AIRFLOW_PACKAGES}]==$AIRFLOW_VERSION \
    && pip3 install celery[redis]==3.1.17 \
    && apt-get remove --purge -yqq $buildDeps \
    && apt-get clean \
    && rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/man \
        /usr/share/doc \
        /usr/share/doc-base

RUN \
    apt-get update \
    # awscli
    && apt-get install \
        -y \
        groff \
    && pip3 install \
        awscli

COPY ./skelton /

# Cleanups
RUN /opt/local/core/build_cleanup.sh

EXPOSE 80 5555 8793

# USER airflow
WORKDIR ${AIRFLOW_HOME}
ENTRYPOINT ["/opt/local/workflow/airflow/entrypoint.sh"]
