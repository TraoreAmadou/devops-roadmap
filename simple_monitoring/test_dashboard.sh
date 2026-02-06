#!/bin/bash


GREEN='\033[0;32m'
RESET='\033[0m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'

echo -e "${GREEN}-------- Netdata dashboard ---------${RESET}"
echo -e "Open: http://192.168.64.8:19999"
echo -e "Generating load for 20 seconds..."

PROCESS_TIME=20

if ! command -v stress >/dev/null 2>&1; then
  echo -e "${YELLOW}stress not found. Installing...${RESET}"
  sudo apt-get update -y
  sudo apt-get install -y stress
fi

echo -e "${CYAN}Using stress...${RESET}"
# 2 workers CPU + 1 worker IO pendant 20s
stress --cpu 3 --io 1 --timeout "${PROCESS_TIME}s"

echo -e "${GREEN}Done. Check CPU and disk charts on the dashboard.${RESET}"
