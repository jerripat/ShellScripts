#!/usr/bin/env bash

# ==========================================
# Ubuntu System Backup Script
# ==========================================

set -o pipefail

# Backup configuration
BACKUP_DRIVE="/run/media/jerripat/Sam"
BACKUP_ROOT="$BACKUP_DRIVE/backup"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="$BACKUP_ROOT/Ubuntu_Backup_$DATE"
LOG_FILE="$BACKUP_ROOT/backup_$DATE.log"

# ==========================================
# Check administrator privileges
# ==========================================

if [[ $EUID -ne 0 ]]; then
    echo "ERROR: Run this script using sudo."
    exit 1
fi

# ==========================================
# Check rsync installation
# ==========================================

if ! command -v rsync &>/dev/null; then
    echo "ERROR: rsync is not installed."
    echo "Install it with: sudo apt install rsync"
    exit 1
fi

# ==========================================
# Verify external drive is mounted
# ==========================================

if ! mountpoint -q "$BACKUP_DRIVE"; then
    echo "ERROR: Backup drive is not mounted."
    echo "Expected location: $BACKUP_DRIVE"
    exit 1
fi

# ==========================================
# Create backup directory
# ==========================================

mkdir -p "$BACKUP_DIR" || exit 1

echo "======================================"
echo "       UBUNTU SYSTEM BACKUP"
echo "======================================"
echo "Source:      /"
echo "Destination: $BACKUP_DIR"
echo "Started:     $(date)"
echo "======================================"

# ==========================================
# Run system backup
# ==========================================

rsync -aAXH \
    --numeric-ids \
    --one-file-system \
    --info=progress2 \
    --exclude="/dev/***" \
    --exclude="/proc/***" \
    --exclude="/sys/***" \
    --exclude="/run/***" \
    --exclude="/tmp/***" \
    --exclude="/mnt/***" \
    --exclude="/media/***" \
    --exclude="/lost+found" \
    --exclude="/swapfile" \
    / "$BACKUP_DIR/" 2>&1 | tee "$LOG_FILE"

RESULT=${PIPESTATUS[0]}

# ==========================================
# Check backup result
# ==========================================

echo "======================================"

if [[ $RESULT -eq 0 ]]; then
    echo "BACKUP COMPLETED SUCCESSFULLY!"
    echo "Location: $BACKUP_DIR"
else
    echo "BACKUP FAILED OR WAS INCOMPLETE!"
    echo "rsync exit code: $RESULT"
    echo "Check log: $LOG_FILE"
fi

echo "Finished: $(date)"
echo "======================================"

exit "$RESULT"

