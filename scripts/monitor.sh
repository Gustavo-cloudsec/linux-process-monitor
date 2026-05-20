#!/bin/bash


DIR_CPU="/home/gustavo/process-monitor/logs/cpu"
DIR_MEM="/home/gustavo/process-monitor/logs/memoria"

LOG_CPU="${DIR_CPU}/process-monitor-cpu.log"
LOG_MEM="${DIR_MEM}/process-monitor-mem.log"


mkdir -p "$DIR_CPU" 
mkdir -p "$DIR_MEM"

echo "=== Registro em: $(date) ===" | tee -a "$LOG_CPU" "$LOG_MEM"

top -b -n 1 | awk 'NR>7 && $9 > 10.0 {print $0}' >> "$LOG_CPU"

top -b -n 1 | awk 'NR>7 && $10 > 10.0 {print $0}' >> "$LOG_MEM"
