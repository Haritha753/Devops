#!/bin/bash

# Interactive Linux Server Monitoring Menu

check_cpu() {
	echo "---------CPU Information---------"
	uptime
	nproc

}

check_memory() {
	echo "----------Memory Information---------"
	free -h

}

check_disk() {
	echo "----------Disk Information-----------"
	df -h

}

check_processes() {
	echo "----------Top CPU Processes----------"
	ps aux --sort=-%cpu | head -6

}

check_service() {
	read -p "Enter Service name: " service

	if systemctl is-active --quiet "$service"; then
		echo "$service is running"
	else
	        echo "$service is not active"
	fi
}

while true
do
    echo
    echo "===================================="
    echo "       LINUX SERVER MONITOR"
    echo "===================================="

    echo "1. CPU Information"
    echo "2. Memory Information"
    echo "3. Disk Information"
    echo "4. Top CPU Processes"
    echo "5. Service Status"
    echo "6. Exit"
    

    read -p "Enter your choice: " choice

    case "$choice" in
	    1)
		    check_cpu
		    ;;
	    2)
		    check_memory
		    ;;
	    3)    
	            check_disk
	            ;;
	    4)      
	            check_processes
	            ;;
	    5)
	            check_service
	            ;;
	    6)
	            echo "Exiting Monitoring tool.."
	            break
	            ;;
	    *)
	            echo "Invalid choice. Please select 1-6"
	            ;;
    esac

done    
		    
