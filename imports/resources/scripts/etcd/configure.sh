#!/bin/bash

DISCOVERY_URL=$(ctx instance runtime-properties DISCOVERY_URL)
CLUSTER_SIZE=$(ctx node properties cluster_size)

if [[ ! -z ${DISCOVERY_URL} ]]; then
    exit 0;
else
    CLUSTER_SIZE=1
    DISCOVERY_URL=$(curl https://discovery.etcd.io/new?size=${CLUSTER_SIZE})
    ctx instance runtime-properties DISCOVERY_URL $DISCOVERY_URL
fi
