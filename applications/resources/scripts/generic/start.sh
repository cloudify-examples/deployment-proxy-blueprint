#!/bin/bash

EXECUTABLE=$(ctx instance runtime-properties executable)
nohup ${EXECUTABLE} > /dev/null 2>&1 &
PID=$!
ctx instance runtime_properties pid ${PID}
