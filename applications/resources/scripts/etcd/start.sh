#!/bin/bash

# source: https://github.com/coreos/etcd/releases

# start a local etcd server

# write,read to etcd
# ETCDCTL_API=3 /tmp/test-etcd/etcdctl --endpoints=localhost:2379 put foo bar
# ETCDCTL_API=3 /tmp/test-etcd/etcdctl --endpoints=localhost:2379 get foo

PRIVATE_IP=$(ctx instance host-ip)
MEMBER_NAME=$(ctx instance id)
UUID=$(ctx instance runtime-properties UUID)
DISCOVERY_URL=$(ctx instance runtime-properties DISCOVERY_URL)

read -r -d '' COMMAND << EOM
/bin/etcd --name ${MEMBER_NAME} --initial-advertise-peer-urls http://${PRIVATE_IP}:2380 \
  --listen-peer-urls http://${PRIVATE_IP}:2380 \
  --listen-client-urls http://${PRIVATE_IP}:2379,http://127.0.0.1:2379 \
  --advertise-client-urls http://${PRIVATE_IP}:2379 \
  --discovery ${DISCOVERY_URL}
EOM

sudo nohup ${COMMAND} > /tmp/test-etcd/log 2>&1 &
PID=$!
ctx instance runtime-properties pid ${PID}
