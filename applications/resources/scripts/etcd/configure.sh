#!/bin/bash

DISCOVERY_URL=$(ctx instance runtime-properties DISCOVERY_URL)

if [[ ! -z ${DISCOVERY_URL} ]]; then
    CLUSTER_SIZE=1
    DISCOVERY_URL=$(curl https://discovery.etcd.io/new?size=${CLUSTER_SIZE})
    ctx instance runtime-properties DISCOVERY_URL $DISCOVERY_URL
else
    exit 0;
fi
