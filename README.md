# Linux System Monitoring & Automation

A Bash-based Linux system monitoring tool that automatically checks system resources, identifies resource-intensive processes, monitors critical services, and logs system health information.

## Features

- CPU utilization monitoring
- Memory utilization monitoring
- Disk utilization monitoring
- Configurable resource thresholds
- CPU and memory process monitoring
- Linux service monitoring using `systemctl`
- Timestamped monitoring logs
- Automated execution using `cron`
- Console and file-based logging

## Technologies Used

- Linux
- Bash Shell Scripting
- Cron
- systemd
- AWK
- Core Linux utilities
- Git & GitHub

## Project Structure

```text
linux-system-monitor/
├── system_monitor.sh
├── config.conf
├── README.md
├── .gitignore
└── logs/
    └── system_monitor.log
