
#!/bin/bash
set -e

echo "=== Netdata dashboard test ==="
echo "Open: http://192.168.64.8:19999"
echo "Generating load for 20 seconds..."

PROCESS_TIME=20

if ! command -v stress >/dev/null 2>&1; then
  echo "stress not found. Installing..."
  sudo apt-get update -y
  sudo apt-get install -y stress
fi

if command -v stress >/dev/null 2>&1; then
  echo "Using stress..."
  # 2 workers CPU + 1 worker IO pendant 20s
  stress --cpu 3 --io 1 --timeout "${PROCESS_TIME}s"
else
  echo "stress still not available, using 2 process  (yes + dd)..."

  # CPU load
  yes > /dev/null &
  P1=$!
  yes > /dev/null &
  P2=$!

  # Disk I/O load
  dd if=/dev/zero of=/tmp/netdata_testfile bs=1M count=200 status=none
  sync
  rm -f /tmp/netdata_testfile

  sleep "$PROCESS_TIME"
  kill "$P1" "$P2" 2>/dev/null || true
fi

echo "Done. Check CPU and disk charts on the dashboard."

