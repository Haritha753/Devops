#!/bin/bash


echo "-----------ROOT FILESYSTEM CHECK-------------"

DISK_USAGE=$(df -P / | awk 'NR==2 {gsub("%","",$5); print $5}')

if ["DISK_USAGE" -ge 80];
then
	echo"WARNING: Root filesystem usage is ${DISK_USAGE}%"
else
	echo"NORMAL: Root filesystem usage is ${DISK_USAGE}%"
fi

echo
echo "---------------SSH SERVICE CHECK-------------"

if systemctl is-active --quiet sshd; then
	echo "NORMAL: SSH service is running"
else
	echo "WARNING: SSH service is not running"
fi

echo
echo "------------------HEALTH CHECK COMPLETED------"
