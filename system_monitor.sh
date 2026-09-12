#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# ---------------- LOGGING ----------------

LOG_DIR="./logs"
LOG_FILE="$LOG_DIR/system_monitor.log"

mkdir -p "$LOG_DIR"

# Display output on terminal and save it to log file
exec > >(tee -a "$LOG_FILE") 2>&1


# ---------------- CONFIGURATION ----------------

CONFIG_FILE="./config.conf"

if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "ERROR: Configuration file not found!"
    exit 1
fi


# ---------------- HEADER ----------------

echo ""
echo "================================"
echo "     Linux System Monitor"
echo "================================"

echo "Monitoring Run: $(date)"
echo "Hostname: $(hostname)"
echo "Uptime: $(uptime -p)"


# ---------------- CPU ----------------

echo ""
echo "CPU Usage:"

CPU_IDLE=$(top -bn1 | awk -F',' '/Cpu\(s\)/ {gsub(/[^0-9.]/, "", $4); print $4}')
CPU_USAGE=$(awk "BEGIN {print 100 - $CPU_IDLE}")

printf "CPU Usage: %.0f%%\n" "$CPU_USAGE"

if (( $(printf "%.0f" "$CPU_USAGE") >= CPU_THRESHOLD )); then
    echo "WARNING: High CPU usage!"
else
    echo "CPU Status: NORMAL"
fi


# ---------------- MEMORY ----------------

echo ""
echo "Memory Usage:"

MEM_TOTAL=$(free | awk '/Mem:/ {print $2}')
MEM_AVAILABLE=$(free | awk '/Mem:/ {print $7}')

MEM_USED=$((MEM_TOTAL - MEM_AVAILABLE))
MEM_USAGE=$((MEM_USED * 100 / MEM_TOTAL))

echo "Memory Usage: $MEM_USAGE%"

if [ "$MEM_USAGE" -ge "$MEMORY_THRESHOLD" ]; then
    echo "WARNING: High memory usage!"
else
    echo "Memory Status: NORMAL"
fi


# ---------------- DISK ----------------

echo ""
echo "Disk Usage:"

DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

echo "Disk Usage: $DISK_USAGE%"

if [ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]; then
    echo "WARNING: High disk usage!"
else
    echo "Disk Status: NORMAL"
fi

# ---------------- TOP PROCESSES ----------------

echo ""
echo "Top CPU-consuming processes:"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6

echo ""
echo "Top Memory-consuming processes:"
ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6


# ---------------- SERVICE MONITORING ----------------

echo ""
echo "Service Status:"

SERVICES=("cron")

for SERVICE in "${SERVICES[@]}"; do

    if command -v systemctl >/dev/null 2>&1; then
        if systemctl is-active --quiet "$SERVICE"; then
            echo "$SERVICE: RUNNING"
        else
            echo "$SERVICE: NOT RUNNING"
        fi
    else
        echo "$SERVICE: systemctl unavailable (container)"
    fi

done
