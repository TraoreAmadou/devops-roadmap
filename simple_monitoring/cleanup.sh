#!/bin/bash

if ! command -v netdata >/dev/null 2>&1 && ! systemctl list-unit-files 2>/dev/null | grep -q '^netdata\.service'; then
  echo "Netdata is not installed. Nothing to clean."
  exit 0
fi

echo "Netdata found. Cleaning up and removing..."

# Stop/disable service
sudo systemctl stop netdata 2>/dev/null || true
sudo systemctl disable netdata 2>/dev/null || true


# Official uninstall method: kickstart.sh --uninstall 
wget -O /tmp/netdata-kickstart.sh https://get.netdata.cloud/kickstart.sh
sudo sh /tmp/netdata-kickstart.sh --uninstall --non-interactive || true

# Cleanup résidus (best effort)
sudo rm -rf /etc/netdata 2>/dev/null || true
sudo rm -rf /var/lib/netdata 2>/dev/null || true
sudo rm -rf /var/cache/netdata 2>/dev/null || true
sudo rm -rf /var/log/netdata 2>/dev/null || true
sudo rm -rf /opt/netdata 2>/dev/null || true

# delete script download in /tmp/
rm -f /tmp/netdata-kickstart.sh 2>/dev/null || true

sudo systemctl daemon-reload >/dev/null 2>&1 || true
echo "Done. Netdata removed and system cleaned."



