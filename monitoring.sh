#!/bin/bash

    #System Info
    #architecture=$(uname)
    pcpu=$(lscpu | grep 'Socket(s):' | awk '{print $2}')
    vcpu=$(nproc)

    # Memory Usage
    total_memory=$(free -m | awk '/^Mem:/{print $2"MB"}')
    used_memory=$(free -m | awk '/^Mem:/{print $3}')
    memory_percent=$(free | awk '/^Mem:/{print int($3/$2*100)}')

    # Disk Usage
    total_disk=$(df -h --total | awk '/^total/{print $2"b"}')
    used_disk=$(df -h --total | awk '/^total/{print $3}')
    disk_percent=$(df --total | awk '/^total/{print $5}')

    # CPU Usage
    cpu_percent=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

    # System Information
    last_boot=$(who -b | awk '{print $3, $4}')
    lvm_status=$(lsblk | grep lvm | wc -l | echo "yes" || echo "no")

    # Network Information
    active_connections=$(netstat -an | grep -c ESTABLISHED)
    user_count=$(who | awk '{print $1}' | uniq | wc -l)
    ipv4_address=$(hostname -I | awk '{print $1}')
    mac_address=$(ip link show | grep ether | head -1 | awk '{print $2}')

    # sudo Commands Executed
    sudo_commands=$(grep -c 'COMMAND=' /var/log/sudo/sudo.log)

    wall "  
                        #Architecture: $(uname) $(uname -n) $(uname -r) $(uname -v) $(uname -m) $(uname -o)
                        #CPU physical : $pcpu
                        #vCPU : $vcpu
                        #Memory Usage: $used_memory/$total_memory ($memory_percent%)
                        #Disk Usage: $used_disk/$total_disk ($disk_percent)
                        #CPU load: $cpu_percent%
                        #Lastboot: $last_boot
                        #LVM use: $lvm_status
                        #Connections TCP : $active_connections ESTABLISHED
                        #User log: $user_count
                        #Network: IP $ipv4_address ($mac_address)
                        #Sudo : $sudo_commands cmd"
