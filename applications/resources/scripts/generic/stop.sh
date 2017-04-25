#!/bin/bash

set -e

PID=$(ctx instance runtime_properties pid)

if [ -n "${!PID}" ]; then
    kill -9 ${PID}
    ctx logger info "Stopped PID ${PID}"
else
  ctx logger info "PID ${PID} not set."
fi
