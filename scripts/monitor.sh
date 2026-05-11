#!/bin/bash

(date && top -b -n 1 | awk 'NR>7 && $9 > 50.0 {print $0}') | tee -a  /home/gustavo/process-monitor.log

