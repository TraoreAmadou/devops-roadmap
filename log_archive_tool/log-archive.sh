#!/bin/bash

# Color
RED='\033[0;31m'
GREEN='\033[0;32m'
RESET='\033[0m'

DEFAULT_LOG_DIR="/var/log"

if [ $# -ge 1 ]; then
  LOG_DIR="$1"
else
  warning_message=$(echo -e "${RED}Please provide you logs location...${RESET}Or press Enter for default $DEFAULT_LOG_DIR:")
  read -r -p "${warning_message}" LOG_DIR
  if [ -z "$LOG_DIR" ]; then
    LOG_DIR="$DEFAULT_LOG_DIR"
  fi
fi


if [ ! -d "$LOG_DIR" ]; then
  echo "Error: '$LOG_DIR' does not exist or is not a directory."
  exit 1
fi

echo "Using log directory: $LOG_DIR"

ARCHIVE_DIR="./log_archives" # we stock in current directory, we can change this ($HOME/log_archives)
mkdir -p "$ARCHIVE_DIR" || { echo -e "${RED}Failed to create archive directory $ARCHIVE_DIR.${RESET}"; exit 1; }

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="${ARCHIVE_DIR}/${ARCHIVE_NAME}"

sudo tar -czf "$ARCHIVE_PATH" -C "$LOG_DIR" . 2> /dev/null
TAR_STATUS=$?

LOG_TIME=$(date +"%Y-%m-%d %H:%M:%S") 
ARCHIVE_SIZE=$(du -sh "$ARCHIVE_PATH" | cut -f1)

if [ $TAR_STATUS -eq 0 ]; then
  LOG_FILE="${ARCHIVE_DIR}/archive.log"
  echo -e "$LOG_TIME | ${GREEN}Succes archived${RESET}: $LOG_DIR -> $ARCHIVE_PATH ${RED}(Size: $ARCHIVE_SIZE)${RESET}" >> "$LOG_FILE"
  
  echo -e "${GREEN}Logs have been archived and compressed successfully."
  echo -e "${RESET}Archive stored at:	$ARCHIVE_PATH"
  echo -e "Log file updated:	$LOG_FILE"
else
  echo -e "${RED}Error: Failed to archive and compress logs.${RESET}"
  echo -e "$LOG_TIME | ${RED}Failled archived${RESET}: $LOG_DIR -> $ARCHIVE_PATH ${RED}(Size: $ARCHIVE_SIZE)${RESET}" >> "$LOG_FILE"
  exit 1
fi
