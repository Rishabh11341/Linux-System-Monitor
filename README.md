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
