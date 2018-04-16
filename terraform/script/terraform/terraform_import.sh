#!/bin/bash

PATH_TO_FILE=$1
shift
readonly TERRAFORM_OPTIONS=$@

function usage {
  cat <<EOF
terraform_import.sh is a tool for importing terraform from lists.

Usage:
     [command] <path_to_reousrce_file>

Example:
    terrafomr_import.sh /path/to/resource.txt -var=<tf-var> -var=<tf-var>
EOF
}

################################################################################
# Description
#  import terraform resource if it haven't already imported
# Globals:
#   TERRAFORM_OPTIONS
# Arguments:
#   RESOURCE_ADDR
#   RESOURCE_ID
# Returns:
#   None
################################################################################
import_if_it_does_not_exist()
{
  local RESOURCE_ADDR=$1
  local RESOURCE_ID=$2
  if terraform state list | grep --quiet --fixed-strings ${RESOURCE_ADDR} ; then
    echo "${RESOURCE_ADDR} of ${RESOURCE_ID} is already imported"
  else
    terraform import ${TERRAFORM_OPTIONS} ${RESOURCE_ADDR} ${RESOURCE_ID}
  fi
}

cat ${PATH_TO_FILE} | while read line
do
  # ignore comments
  [[ "$line" =~ ^#.*$ ]] && continue
  # ignore empty line
  echo ${line} | grep --quiet '^\s*$' && continue
  import_if_it_does_not_exist ${line}
done
