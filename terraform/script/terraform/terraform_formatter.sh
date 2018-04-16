#!/bin/bash

PATH_TO_THIS_DIR=$(cd $(dirname ${0});pwd)
terraform fmt -diff -write=true -list=true ${PATH_TO_THIS_DIR}/..
