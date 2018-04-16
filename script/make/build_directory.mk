DIRECTORIES ?= $(wildcard *)
IGNORE_FILES ?= Makefile
TARGETS ?= $(filter-out ${IGNORE_FILES},${DIRECTORIES})
PUSH_TARGETS ?= $(addprefix push-,${TARGETS})
DO_BUILD_TARGETS ?= $(addprefix do-build-,${TARGETS})
PRE_BUILD_TARGETS ?= $(addprefix pre-build-,${TARGETS})
POST_BUILD_TARGETS ?= $(addprefix post-build-,${TARGETS})

.PHONY: build push ${TARGETS} ${PUSH_TARGETS}

build: ${TARGETS}

push: build ${PUSH_TARGETS}

${TARGETS}:
	$(MAKE) --directory $@ build

${PUSH_TARGETS}:
	$(MAKE) --directory $(subst push-,,$@) push
