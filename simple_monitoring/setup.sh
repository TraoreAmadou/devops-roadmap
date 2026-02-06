#!/bin/bash

if command -v netdata >/dev/null 2>&1 || systemctl list-unit-files 2>/dev/null | grep -q '^netdata\.service'; then
  echo "Netdata is already installed."
  echo "Dashboard: http://localhost:19999"
  echo "Remote:    http://<server-ip>:19999"
  exit 0
fi

echo "Installing Netdata ......"

# Download official Netdata installer
wget -O /tmp/netdata-kickstart.sh https://get.netdata.cloud/kickstart.sh

echo "Running Netdata ......"
# Run installer (non-interactive to allow all without yes or no)
sudo sh /tmp/netdata-kickstart.sh --non-interactive

echo "=== Netdata installed ==="
echo "Dashboard: http://localhost:19999"
echo "Remote:    http://<server-ip>:19999"

