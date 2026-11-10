#!/bin/bash

#check whether the argument is provided

if [ $# -eq 0 ]; then
	echo "ERROR: please provide service name"
        echo "Usage: $0 <service_name>"
	exit 1
fi

SERVICE="$1"

#check whether input is empty

if [ -z "$SERVICE" ]; then
	echo "ERROR: service name cannot be empty"
	exit 1
fi

echo "checking service: $SERVICE"

#check Service status

if systemctl is-active --quiet "$SERVICE"; then
	echo "SUCCESS: $SERVICE is running"
else
        echo "WARNING: $SERVICE is not active"
fi	

