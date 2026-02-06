#!/bin/bash

GREEN='\033[0;32m'
RESET='\033[0m'
YELLOW='\033[0;33m' 
CYAN='\033[0;36m'      

if command -v netdata >/dev/null 2>&1 || systemctl list-unit-files 2>/dev/null | grep -q '^netdata\.service'; then
  echo -e "${GREEN}Netdata is already installed.${RESET}"
  echo -e "Dashboard: ${YELLOW}http://localhost:19999${RESET}"
  echo -e "Remote:    ${CYAN}http://<server-ip>:19999${RESET}"
  exit 0
fi

echo "Installing Netdata ......"

# Download official Netdata installer
wget -O /tmp/netdata-kickstart.sh https://get.netdata.cloud/kickstart.sh

echo "Running Netdata ......"
# Run installer (non-interactive to allow all without yes or no)
sudo sh /tmp/netdata-kickstart.sh --non-interactive

echo -e "${GREEN}Netdata installed${RESET}"
echo -e "Dashboard: ${YELLOW}http://localhost:19999${RESET}"
echo -e "Remote:    ${CYAN}http://<server-ip>:19999${RESET}"

