IGNORE_FILES = Makefile mysql cli-base
IGNORE_FILES = make Makefile README.md script
include ../script/make/build_directory.mk

#
# builder
##
builder: core

push-builder: core

#
# cli-base
#
cli-base: core

push-cli-base: core

#
# cli-base
#
deployer: kubectl

push-deployer: kubectl

#
# java8
#
java8: core

push-java8: core

#
# embulk
#
embulk: java8

push-embulk: java8

#
# python3
#
python3: core

push-python3: core

#
# kubectl
#
kubectl: core cli-base

push-kubectl: core cli-base

#
# pyspark
#
pyspark: java8

push-pyspark: java8

#
# tester
#
tester-gcp-script: pyspark

push-tester-gcp-script: pyspark

#
# tester
#
tester-pyspark: pyspark

push-tester-pyspark: pyspark
