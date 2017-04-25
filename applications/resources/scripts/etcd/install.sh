#!/bin/bash

# Source: https://github.com/coreos/etcd/releases/tag/v3.1.6

SOFTWARE_PACKAGE_NAME=$(ctx node properties resource_config name)
ctx logger info "Installing ${SOFTWARE_PACKAGE_NAME}"

ETCD_VER=$(ctx node properties resource_config version)
SYSTEM_BINARIES_DIR=$(ctx node properties resource_config system_binaries_directory)

ctx logger info "Installing ETCD_VER ${ETCD_VER} to system_binaries_directory ${SYSTEM_BINARIES_DIR}"

# choose either URL
GOOGLE_URL=https://storage.googleapis.com/etcd
GITHUB_URL=https://github.com/coreos/etcd/releases/download
DOWNLOAD_URL=${GOOGLE_URL}

ctx logger info "DOWNLOAD_URL ${DOWNLOAD_URL}"

ctx logger debug "If {SYSTEM_BINARIES_DIR}/etcd exist, this script will delete it."
rm -f /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz
rm -f ${SYSTEM_BINARIES_DIR}/etcd

curl -L ${DOWNLOAD_URL}/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz -o /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz
tar xzvf /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz -C ${SYSTEM_BINARIES_DIR} --strip-components=1

EXECUTABLE=$(SYSTEM_BINARIES_DIR)/etcd
ctx logger info "EXECUTABLE ${EXECUTABLE}"
ctx instance runtime-properties executable ${EXECUTABLE}

ETCDCTL_API=$(EXECUTABLE) --version
ctx logger info "ETCDCTL_API ${ETCDCTL_API}"

CTL_EXECUTABLE=${SYSTEM_BINARIES_DIR}/etcdctl
ctx logger info "CTL_EXECUTABLE ${CTL_EXECUTABLE}"

ETCDCTL_API=$(CTL_EXECUTABLE) version
ctx logger info "CTL_EXECUTABLE ${CTL_EXECUTABLE}"
