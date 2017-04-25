#!/bin/bash

# execute.sh

set -e

FULL_LIFECYCLE_OPERATION_NAME=$(ctx operation name)
ctx logger info "FULL_LIFECYCLE_OPERATION_NAME ${FULL_LIFECYCLE_OPERATION_NAME}"

LIFECYCLE_OPERATION=’;’ read -ra STRINGS <<< "$FULL_LIFECYCLE_OPERATION_NAME" echo ${STRINGS[${#STRINGS[@]} - 1]}
ctx logger info "LIFECYCLE_OPERATION ${LIFECYCLE_OPERATION}"

SCRIPT_FROM_BLUEPRINT=$(ctx node properties resource_config lifecycle_scripts ${LIFECYCLE_OPERATION} blueprint_resource)
ctx logger info "SCRIPT_FROM_BLUEPRINT: ${SCRIPT_FROM_BLUEPRINT}"

EXECUTING=$(ctx download-resource ${SCRIPT_FROM_BLUEPRINT})
ctx logger info "EXECUTING: ${EXECUTING}"

output=$(/bin/bash SCRIPT_PATH)
ctx logger info "output ${output}"
