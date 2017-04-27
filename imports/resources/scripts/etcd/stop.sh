#!/bin/bash

set -e

PID=$(ctx instance runtime_properties pid)

sudo kill -9 ${PID}
