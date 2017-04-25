#!/bin/bash

EXECUTABLE=$(ctx instance runtime-properties executable)
rm -f ${EXECUTABLE}

if [ -n "${!EXECUTABLE}" ]; then
    kill -9 ${EXECUTABLE}
    ctx logger info "Deleted EXECUTABLE ${EXECUTABLE}"
else
  ctx logger info "EXECUTABLE ${EXECUTABLE} not set."
fi
