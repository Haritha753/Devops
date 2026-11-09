#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$SCRIPT_DIR/logs"

mkdir -p "$LOG_DIR"

LOG_FILE="$LOG_DIR/health_$(date +%Y%m%d_%H%M%S).log"

exec > >(tee -a "$LOG_FILE") 2>&1

echo "======================================"
echo "       SERVER HEALTH REPORT"
echo "======================================"

echo "Date       : $(date)"
echo "Hostname   : $(hostname)"
echo "Kernel     : $(uname -r)"

echo
echo "----- CPU INFORMATION -----"

echo "CPU Cores  : $(nproc)"
uptime

echo
echo "----- MEMORY INFORMATION -----"

free -h

echo
echo "----- DISK UTILIZATION -----"

df -h

echo
echo "----- INODE UTILIZATION -----"

df -i

echo
echo "----- TOP CPU PROCESSES -----"

ps aux --sort=-%cpu | head -6

echo
echo "-----------ROOT FILESYSTEM CHECK-------------"

DISK_USAGE=$(df -P / | awk 'NR==2 {gsub("%","",$5); print $5}')

if [ "$DISK_USAGE" -ge 80 ];
then
	echo "WARNING: Root filesystem usage is ${DISK_USAGE}%"
else
	echo "NORMAL: Root filesystem usage is ${DISK_USAGE}%"
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
