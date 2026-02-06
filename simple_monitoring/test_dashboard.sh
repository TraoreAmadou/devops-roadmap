#!/bin/bash

echo "-------- Netdata dashboard ---------"
echo "Open: http://192.168.64.8:19999"
echo "Generating load for 20 seconds..."

PROCESS_TIME=20

if ! command -v stress >/dev/null 2>&1; then
  echo "stress not found. Installing..."
  sudo apt-get update -y
  sudo apt-get install -y stress
fi

echo "Using stress..."
# 2 workers CPU + 1 worker IO pendant 20s
stress --cpu 3 --io 1 --timeout "${PROCESS_TIME}s"

echo "Done. Check CPU and disk charts on the dashboard."

