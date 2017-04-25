#!/bin/bash

# source: https://github.com/coreos/etcd/releases

# start a local etcd server

nohup /tmp/test-etcd/etcd > /dev/null 2>&1 &
PID=$!
ctx instance runtime_properties pid ${PID}

# write,read to etcd
# ETCDCTL_API=3 /tmp/test-etcd/etcdctl --endpoints=localhost:2379 put foo bar
# ETCDCTL_API=3 /tmp/test-etcd/etcdctl --endpoints=localhost:2379 get foo
