# Linux Process Monitor Lab

## Overview

This project is a simple Linux process monitoring script created as part of my Linux and cybersecurity learning journey.

The script monitors running processes using the `top` command, filters processes with high CPU usage, and stores the results in a log file for later analysis.

The goal of this lab is to practice:

- Linux process monitoring
- Bash scripting
- Log management
- Command pipelines
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
│   └── process-monitor.log
│
├── screenshots/
│
└── README.md
```

---

## How It Works

The script:

1. Runs the `top` command in batch mode
2. Ignores header lines from the output
3. Filters processes using `awk`
4. Detects processes with CPU usage above a defined threshold
5. Saves the output to a log file
6. Prints the result in the terminal using `tee`

---

## Script Example

```bash
#!/bin/bash

(date && top -b -n 1 | awk 'NR>7 && $9 > 50.0 {print $0}') \
| tee -a /home/gustavo/process-monitor/logs/process-monitor.log
```

---

## Example Output

```bash
Mon May 11 04:31:35 PM -03 2026
3915 gustavo 20 0 23180 5672 3536 R 18.2 0.2 0:00.02 top
```

---

## Screenshots

### Script Running

Add here a screenshot showing the script execution in the terminal.

### Log Output

Add here a screenshot showing the generated log file.

---

## Concepts Practiced

- Linux process analysis
- CPU usage monitoring
- Bash pipelines
- Output redirection
- Log creation
- Process filtering

---

## Future Improvements

- Add memory usage monitoring
- Separate suspicious processes into dedicated logs
- Use variables for configuration
- Automate execution with cron
- Create alert system for high resource usage
- Improve log formatting

---

## Author

Gustavo Henrique Oliveira

---

## Final Notes

This lab is part of my practical studies in Linux, Cloud, and Cybersecurity.

The focus of this project is to improve hands-on skills with Linux system administration and automation.
