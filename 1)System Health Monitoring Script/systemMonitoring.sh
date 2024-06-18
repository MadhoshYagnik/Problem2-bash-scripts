#!/bin/bash

# Define thresholds (adjust these as needed)
CPU_THRESHOLD=2    # percent
MEMORY_THRESHOLD=2 # percent
DISK_THRESHOLD=2   # percent
PROCESS_THRESHOLD=5   # number of processes

# Function to send alert
send_alert() {
    local message=$1
    echo "ALERT: $message"
}

# Function to check CPU usage
check_cpu_usage() {
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    if (( $(echo "$cpu_usage > $CPU_THRESHOLD" | bc -l) )); then
        send_alert "CPU usage is high: $cpu_usage%"
    fi
}

# Function to check memory usage
check_memory_usage() {
    local memory_total=$(free -m | grep Mem | awk '{print $2}')
    local memory_used=$(free -m | grep Mem | awk '{print $3}')
    local memory_usage=$(echo "scale=2; $memory_used / $memory_total * 100" | bc)
    if (( $(echo "$memory_usage > $MEMORY_THRESHOLD" | bc -l) )); then
        send_alert "Memory usage is high: $memory_usage%"
    fi
}

# Function to check disk space
check_disk_space() {
    local disk_usage=$(df / | tail -n 1 | awk '{print $5}' | sed 's/%//')
    if (( $disk_usage > $DISK_THRESHOLD )); then
        send_alert "Disk usage is high: $disk_usage%"
    fi
}

# Function to check number of running processes
check_running_processes() {
    local process_count=$(ps aux | wc -l)
    local process_count=$(($process_count - 1))  # Subtract 1 for the header line
    if (( $process_count > $PROCESS_THRESHOLD )); then
        send_alert "Number of running processes is high: $process_count"
    fi
}

# Main function to run checks
main() {
    check_cpu_usage
    check_memory_usage
    check_disk_space
    check_running_processes
}

# Execute main function
main

