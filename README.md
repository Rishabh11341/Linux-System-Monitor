# Linux System Monitoring & Automation

A Bash-based Linux system monitoring and automation tool designed to track system health, identify resource-intensive processes, monitor critical services, and automatically record system metrics using cron.

---

## Overview

This project automates basic Linux system health monitoring using Bash scripting and standard Linux utilities.

The monitoring script checks CPU, memory, and disk utilization against configurable thresholds. It also identifies the processes consuming the most CPU and memory, checks the status of the cron service, and stores monitoring results in a persistent log file.

The script is automatically executed every 5 minutes using a Linux cron job.

---

## Features

| Feature | Description |
|---|---|
| CPU Monitoring | Tracks current CPU utilization |
| Memory Monitoring | Tracks system memory utilization |
| Disk Monitoring | Checks root filesystem disk usage |
| Threshold Detection | Generates warnings when configured limits are exceeded |
| Process Monitoring | Displays top CPU and memory-consuming processes |
| Service Monitoring | Checks whether the cron service is running |
| Logging | Stores timestamped monitoring results |
| Cron Automation | Automatically executes monitoring every 5 minutes |
| Configuration | Resource thresholds can be modified without changing the script |

---

## Architecture

```text
                    Linux Cron
                        |
                        | Every 5 minutes
                        v
              +---------------------+
              | system_monitor.sh   |
              +---------------------+
                        |
          +-------------+-------------+
          |             |             |
          v             v             v
       CPU Check    Memory Check   Disk Check
          |             |             |
          +-------------+-------------+
                        |
                        v
              Threshold Evaluation
                        |
              +---------+---------+
              |                   |
              v                   v
           NORMAL              WARNING
                                  |
                                  v
                     Top Processes + Service
                            Monitoring
                                  |
                                  v
                         Monitoring Log
                                  |
                                  v
                  logs/system_monitor.log


---

## Technologies Used

- Linux
- Bash Shell Scripting
- Cron
- systemd / systemctl
- AWK
- ps
- df
- free
- top
- Git & GitHub

---

## Project Structure

```text
linux-system-monitor/
├── system_monitor.sh
├── config.conf
├── README.md
├── .gitignore
└── logs/
    └── system_monitor.log
```

---

## Configuration

Resource thresholds are stored in `config.conf`.

```bash
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80
```

This allows resource limits to be changed without modifying the main monitoring script.

---

## How to Run

### Clone the repository

```bash
git clone https://github.com/Rishabh11341/Linux-System-Monitor.git
cd Linux-System-Monitor
```

### Make the script executable

```bash
chmod +x system_monitor.sh
```

### Run the monitor

```bash
./system_monitor.sh
```

---

## Automated Monitoring with Cron

The monitoring script runs automatically every 5 minutes using Linux cron.

```cron
*/5 * * * * /home/rishabh_singh_tomar/linux-system-monitor/system_monitor.sh
```

Monitoring results are stored in:

```text
logs/system_monitor.log
```

To view the configured cron job:

```bash
crontab -l
```

To view the latest monitoring results:

```bash
tail -n 30 logs/system_monitor.log
```

---

## Example Output

```text
================================
     Linux System Monitor
================================
Monitoring Run: Sat Aug 22 06:55:01 UTC 2026
Hostname: Rishabh-PC
Uptime: up 6 minutes

CPU Usage:
CPU Usage: 1%
CPU Status: NORMAL

Memory Usage:
Memory Usage: 7%
Memory Status: NORMAL

Disk Usage:
Disk Usage: 1%
Disk Status: NORMAL

Top CPU-consuming processes:
    PID COMMAND         %CPU %MEM
      1 systemd          0.2  0.1
     88 systemd-udevd    0.0  0.1
    161 networkd-dispat  0.0  0.3

Top Memory-consuming processes:
    PID COMMAND         %CPU %MEM
    220 unattended-upgr  0.0  0.4
    161 networkd-dispat  0.0  0.3

Service Status:
cron: RUNNING
```

---

## Screenshots

### System Monitoring Output

![System Monitoring Output](monitoring-output.png)

### Automated Cron Execution

![Cron Automation](cron-automation.png)

---

## Logging

The script displays monitoring results in the terminal while simultaneously recording them in the monitoring log.

Generated log files are excluded from Git using `.gitignore`.

---

## Learning Outcomes

This project provided hands-on experience with:

- Linux system administration
- Bash scripting and automation
- CPU, memory, and disk monitoring
- Linux process monitoring
- Linux service management
- Cron job scheduling
- Log management
- Configuration-driven scripting
- Git version control
- GitHub repository management

---

## Future Improvements

- Email or messaging alerts for critical thresholds
- Monitoring additional Linux services
- Historical metric visualization
- Monitoring multiple filesystems
- Remote server monitoring
- Prometheus/Grafana integration

---

## Author

**Rishabh Singh Tomar**

B.Tech ECE | Aspiring DevOps Engineer
