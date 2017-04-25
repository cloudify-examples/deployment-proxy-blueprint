#!/bin/bash

export FLASK_APP=$(ctx instance runtime-properties TEMP_FILE)

nohup flask run --host=0.0.0.0 > /dev/null 2>&1 &
PID=$!

ctx instance runtime_properties pid ${PID}
