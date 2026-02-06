#!/bin/bash

GREEN='\033[0;32m'
RESET='\033[0m'

cpu_usage() {
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++"
    	echo -e "${GREEN}CPU${RESET}"
    	echo "+++++++++++++++++++++++++++++++++++++++++++++++++"
	cpu_available=$(top -bn1 | grep "%Cpu" | cut -d ',' -f 4 | awk '{print $1}')
	cpu_used=$(echo "$cpu_available" | awk '{print 100 - $1}')
	echo "Total CPU Usgae: $cpu_used%, so $cpu_available% is available"
	echo

}

memory_usage(){
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++"
    	echo -e "${GREEN}Memory${RESET}"
    	echo "+++++++++++++++++++++++++++++++++++++++++++++++++"
	# free -m donne total/used/free en MB avec l'option m
	mem_total=$(free -m | awk '/Mem:/ {print $2}')

	mem_used=$(free -m | awk '/Mem:/ {print $3}')
	mem_free=$(free -m | awk '/Mem:/ {print $4}')
	mem_available=$(free -m | awk '/Mem:/ {print $7}')

	mem_used_pct=$(awk -v used="$mem_used" -v total="$mem_total" 'BEGIN {printf "%.1f", (used/total)*100}')
	mem_free_pct=$(awk -v fre="$mem_free" -v total="$mem_total" 'BEGIN {printf "%.1f", (fre/total)*100}')
	mem_available_pct=$(awk -v avail="$mem_available" -v total="$mem_total" 'BEGIN {printf "%.1f", (avail/total)*100}')

	echo "  Total: ${mem_total} MB"
	echo "  Used : ${mem_used} MB (${mem_used_pct}%)"
	echo "  Free : ${mem_free} MB (${mem_free_pct}%)"
	echo "  Available : ${mem_available} MB (${mem_available_pct}%)"
	echo	

}


disk_usage(){
	
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++"
	echo -e "${GREEN}Disk (/)${RESET}"
        echo "+++++++++++++++++++++++++++++++++++++++++++++++++"

	# Total disk usage (Free vs Used + %)
	disk_total=$(df -h / | awk 'NR==2 {print $2}')
	
	disk_used=$(df -h / | awk 'NR==2 {print $3}')
	disk_free=$(df -h / | awk 'NR==2 {print $4}')
	
	
	disk_used_pct=$(df -h / | awk 'NR==2 {print $5}')
	disk_free_pct=$(awk -v fre="$disk_free" -v total="$disk_total" 'BEGIN {printf "%.1f", (fre/total)*100}')
	# disk_free_pct=$(awk -v used_pct="$disk_used_pct" '{print 100 - used_pct}') # ou ca

	echo "  Total: $disk_total"
	echo "  Used : $disk_used ($disk_used_pct)%"
	echo "  Free : $disk_free ($disk_free_pct)%"
	echo
}

top_5_processes_by_cpu(){
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++"
        echo -e "${GREEN}Top 5 processes by CPU${RESET}"
        echo "+++++++++++++++++++++++++++++++++++++++++++++++++"
	ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
	echo
}

top_5_processes_by_mem(){
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++"
        echo -e "${GREEN}Top 5 processes by Memory${RESET}"
        echo "+++++++++++++++++++++++++++++++++++++++++++++++++"

	ps -eo pid,comm,%mem --sort=-%mem | head -n 6
	echo
}

some_additional_stats(){
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++"
    echo -e "${GREEN}System${RESET}"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "OS:		$(lsb_release -d | cut -f2-)"
    echo "Hostname:	$(hostname)"
    echo "Kernel:	$(uname -r)"

    echo "Uptime:	$(uptime -p)"

    load_avg=$(uptime | awk -F'load average: ' '{print $2}')
    echo "Load Average (1, 5, 15 mins):	$(cat /proc/loadavg | awk '{print $1, $2, $3}')"
    
    echo "Currently Logged users:	$(who | wc -l)"
    echo "Failed logins:		$(grep "Failed password" /var/log/auth.log | wc -l)"
    echo
}



main() {
    echo -e "${GREEN}===== Server Performance Stats =====${RESET}"
    echo

    some_additional_stats

    cpu_usage

    memory_usage

    disk_usage

    top_5_processes_by_cpu

    top_5_processes_by_mem
}


main



