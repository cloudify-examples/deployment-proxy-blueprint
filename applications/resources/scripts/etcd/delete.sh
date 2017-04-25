#!/bin/bash

# source: https://github.com/coreos/etcd/releases

ETCD_VER=v3.1.6

set -e

rm -f /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz
rm -rf /tmp/test-etcd && mkdir -p /tmp/test-etcd
