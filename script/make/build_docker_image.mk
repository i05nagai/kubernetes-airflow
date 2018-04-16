DOCKER_REGISTRY_HOST = asia.gcr.io
DOCKER_IMAGE_BASE = project
DOCKER_COMMAND = gcloud docker --
NAME = $(shell basename $(shell pwd))
VERSION ?= latest
IMAGE = ${DOCKER_REGISTRY_HOST}/${DOCKER_IMAGE_BASE}/$(NAME)
DOCKER_BUILD_ARGS = --build-arg DOCKER_REGISTRY_HOST=${DOCKER_REGISTRY_HOST} --build-arg DOCKER_IMAGE_BASE=${DOCKER_IMAGE_BASE}

build: pre-build docker-build post-build

pre-build:

post-build:
ifneq (${VERSION}, "latest")
	docker tag ${IMAGE} ${IMAGE}:${VERSION}
endif

docker-build:
	docker build -t ${IMAGE}:latest ${DOCKER_BUILD_ARGS} .

push: docker-push post-push

post-push:

docker-push:
	${DOCKER_COMMAND} push ${IMAGE}:${VERSION}
