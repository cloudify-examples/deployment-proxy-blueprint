#!/bin/bash

UUID=$(uuidgen)

ctx instance runtime-properties UUID $UUID
CLUSTER_SIZE=1
DISCOVERY_URL=$(curl https://discovery.etcd.io/new?size=${CLUSTER_SIZE})
ctx instance runtime-properties DISCOVERY_URL $DISCOVERY_URL
