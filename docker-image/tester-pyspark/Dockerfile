ARG DOCKER_REGISTRY_HOST
ARG DOCKER_IMAGE_BASE
FROM ${DOCKER_REGISTRY_HOST}/${DOCKER_IMAGE_BASE}/pyspark:latest

#
# pytest
#
ENV PYTEST_VERSION 3.1.2
ENV PYTEST_MOCK_VERSION 1.6.2
ENV PYTEST_FAKER_VERSION 2.0.0
ENV PYTEST_ENV_VERSION 0.6.2
ENV PYTEST_PEP8_VERSION 1.0.2
RUN \
    pip3 install \
        # pytest
        pytest==$PYTEST_VERSION \
        pytest-cov \
        pytest-mock==$PYTEST_MOCK_VERSION \
        pytest-faker==$PYTEST_FAKER_VERSION \
        pytest-pep8==$PYTEST_PEP8_VERSION \
        pytest-env==$PYTEST_ENV_VERSION \
ENV PYTHONPATH="$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.4-src.zip"
COPY ./opt /opt
ENTRYPOINT ["/opt/local/core/entrypoint.sh"]
