#!/bin/bash

# Install Netdata
#echo "Installing Netdata..."

#sudo curl https://get.netdata.cloud/kickstart.sh > /tmp/netdata-kickstart.sh && sh /tmp/netdata-kickstart.sh

#echo "Netdata installation complete."




# A script to automate the installation of Netdata.
#echo "--- Running Netdata Installer ---"
#bash <(curl -Ss https://my-netdata.io/kickstart.sh) --dont-wait
#echo "--- Netdata installation script finished. ---"


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
# Run installer (non-interactive)
sudo sh /tmp/netdata-kickstart.sh --non-interactive

echo "=== Netdata installed ==="
echo "Dashboard: http://localhost:19999"
echo "Remote:    http://<server-ip>:19999"

