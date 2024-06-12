#!/bin/bash

LOG_FILE="/var/log/system_monitor.log"
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=90

# Função para coletar o uso de CPU
check_cpu() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    echo "CPU Usage: $CPU_USAGE%" >> $LOG_FILE
    if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
        echo "ALERT: CPU usage is above $CPU_THRESHOLD%!" >> $LOG_FILE
        echo "ALERT: CPU usage is above $CPU_THRESHOLD%!"
    fi
}

# Função para coletar o uso de memória
check_memory() {
    MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    echo "Memory Usage: $MEM_USAGE%" >> $LOG_FILE
    if (( $(echo "$MEM_USAGE > $MEM_THRESHOLD" | bc -l) )); then
        echo "ALERT: Memory usage is above $MEM_THRESHOLD%!" >> $LOG_FILE
        echo "ALERT: Memory usage is above $MEM_THRESHOLD%!"
    fi
}

# Função para coletar o uso de espaço em disco
check_disk() {
    DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
    echo "Disk Usage /: $DISK_USAGE%" >> $LOG_FILE
    if [ $DISK_USAGE -gt $DISK_THRESHOLD ]; then
        echo "ALERT: Disk usage is above $DISK_THRESHOLD% on /!" >> $LOG_FILE
        echo "ALERT: Disk usage is above $DISK_THRESHOLD% on /!"
    fi

    DISK_USAGE_HOME=$(df /home | grep /home | awk '{ print $5 }' | sed 's/%//g')
    echo "Disk Usage /home: $DISK_USAGE_HOME%" >> $LOG_FILE
    if [ $DISK_USAGE_HOME -gt $DISK_THRESHOLD ]; then
        echo "ALERT: Disk usage is above $DISK_THRESHOLD% on /home!" >> $LOG_FILE
        echo "ALERT: Disk usage is above $DISK_THRESHOLD% on /home!"
    fi
}

# Registro de data e hora no arquivo de log
echo "----- $(date) -----" >> $LOG_FILE

# Chamada das funções de monitoramento
check_cpu
check_memory
check_disk
