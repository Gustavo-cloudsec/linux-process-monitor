# Linux Process Monitor Lab

## Overview

This project is a Linux process monitoring script created as part of my Linux and cybersecurity learning journey.

The script monitors running processes using the `top` command, filters processes with high CPU and memory usage, and stores the results in dedicated log files for later analysis.

The goal of this lab is to practice:

- Linux process monitoring
- Bash scripting
- Log management
- Command pipelines
- Directory organization
- Basic automation concepts

---

## Technologies Used

- Linux (Ubuntu)
- Bash scripting
- `top`
- `awk`
- `tee`

---

## Project Structure

```bash
process-monitor/
│
├── scripts/
│   └── monitor.sh
│
├── logs/
│   ├── cpu/
│   │   └── process-monitor-cpu.log
│   │
│   └── memoria/
│       └── process-monitor-mem.log
│
├── prints/
│   ├── script-logic.png
│   └── logs-output.png
│
└── README.md
```

---

## How It Works

The script:

1. Creates log directories automatically if they do not exist
2. Runs the `top` command in batch mode
3. Ignores header lines from the output
4. Filters processes using `awk`
5. Detects processes with high CPU usage
6. Detects processes with high memory usage
7. Separates logs into dedicated directories
8. Stores execution date and time in log files
9. Prints execution information in the terminal using `tee`

---

## Script Example

```bash
#!/bin/bash

DIR_CPU="/home/gustavo/process-monitor/logs/cpu"
DIR_MEM="/home/gustavo/process-monitor/logs/memoria"

LOG_CPU="${DIR_CPU}/process-monitor-cpu.log"
LOG_MEM="${DIR_MEM}/process-monitor-mem.log"

mkdir -p "$DIR_CPU"
mkdir -p "$DIR_MEM"

echo "=== Registro em: $(date) ===" | tee -a "$LOG_CPU" "$LOG_MEM"

top -b -n 1 | awk 'NR>7 && $9 > 50.0 {print $0}' >> "$LOG_CPU"

top -b -n 1 | awk 'NR>7 && $10 > 50.0 {print $0}' >> "$LOG_MEM"
```

---

## Example Output

```bash
=== Registro em: Mon May 18 11:12:15 PM -03 2026 ===

2268 gustavo 20 0 4086712 317944 82356 S 18.2 10.4 1:44.20 gnome-shell
```

---

## Screenshots

### Script Logic

![Script Logic](prints/script-logic.png)

### Logs Output

![Logs Output](prints/logs-output.png)

---

## Concepts Practiced

- Linux process analysis
- CPU usage monitoring
- Memory usage monitoring
- Bash pipelines
- Output redirection
- Log management
- Process filtering
- Directory automation
- Variable usage in Bash

---

## Future Improvements

- Add configurable thresholds
- Create whitelist for critical processes
- Add automatic alerts
- Automate execution using cron
- Implement process priority adjustments
- Add automatic process termination for critical resource usage
- Improve log formatting and reporting
- Add monitoring statistics

---

## Author

Gustavo Henrique Oliveira

---

## Final Notes

This lab is part of my practical studies in Linux, Cloud, and Cybersecurity.

The focus of this project is to improve hands-on skills with Linux system administration, monitoring, automation, and resource analysis.
