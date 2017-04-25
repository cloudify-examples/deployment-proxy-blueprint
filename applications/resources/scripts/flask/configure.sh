#!/bin/bash

RESOURCE_FILE=$(ctx download-resource "applications/resources/scripts/flask/app.py")
TEMP_FILE=$(mktemp)
ctx instance runtime-properties TEMP_FILE $TEMP_FILE
mv $RESOURCE_FILE $TEMP_FILE
