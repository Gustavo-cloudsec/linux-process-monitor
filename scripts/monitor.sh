#!/bin/bash

CONFIG_FILE="$(dirname "$0")/monitor.conf"
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "Erro: Arquivo de configuracao nao encontrado!" && exit 1
fi

DIR_CPU="/home/gustavo/process-monitor/logs/cpu"
DIR_MEM="/home/gustavo/process-monitor/logs/memoria"
LOG_CPU="${DIR_CPU}/process-monitor-cpu.log"
LOG_MEM="${DIR_MEM}/process-monitor-mem.log"

mkdir -p "$DIR_CPU" "$DIR_MEM"

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
HAS_ALERT=false
ALERT_MSG="Alerta de Recursos em $TIMESTAMP:\n"

WHITELIST_REGEX=$(IFS="|"; echo "${WHITELIST[*]}")

TOP_DATA=$(top -b -n 1 | tail -n +8)

while read -r pid user pr ni virt res shr s cpu mem time command; do

    [ -z "$pid" ] && continue

    if [[ -n "$WHITELIST_REGEX" && "$command" =~ ^($WHITELIST_REGEX)$ ]]; then
        continue
    fi

    if (( $(echo "$cpu > $ALERT_CPU" | bc -l) )); then
        echo "[$TIMESTAMP] PID: $pid | CMD: $command | CPU: $cpu%" >> "$LOG_CPU"
        ALERT_MSG+="- [CPU] $command ($pid) usando $cpu%\n"
        HAS_ALERT=true
    fi

       if (( $(echo "$mem > $ALERT_MEM" | bc -l) )); then
        echo "[$TIMESTAMP] PID: $pid | CMD: $command | MEM: $mem%" >> "$LOG_MEM"
        ALERT_MSG+="- [MEM] $command ($pid) usando $mem%\n"
        HAS_ALERT=true
    fi
done <<< "$TOP_DATA"

if [ "$HAS_ALERT" = true ]; then

    echo -e "$ALERT_MSG"
fi
