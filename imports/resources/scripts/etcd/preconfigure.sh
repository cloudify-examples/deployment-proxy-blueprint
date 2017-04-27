#!/bin/bash

DISCOVERY_URL=$(ctx target instance runtime-properties DISCOVERY_URL)
ctx source instance runtime-properties DISCOVERY_URL $DISCOVERY_URL
