#!/bin/bash
set -euo pipefail

BACKUP_MNT="/media/jerripat/Sam"
BACKUP_DIR="$BACKUP_MNT/backup"
PY_BACKUP_DIR="$BACKUP_MNT/PythonProjects"   # keep separate as requested
HOME_DIR="/home/jerripat"
LOG_DIR="$BACKUP_MNT/backup-logs"
TS="$(date +%F_%H%M%S)"

require_mount() {
  if ! mountpoint -q "$BACKUP_MNT"; then
    echo "ERROR: $BACKUP_MNT is not mounted. Aborting."
    exit 1
  fi
  mkdir -p "$BACKUP_DIR" "$PY_BACKUP_DIR" "$LOG_DIR"
}

# Common rsync options for backups
RSYNC_COMMON=(
  -aH
  --no-owner --no-group
  --delete --delete-delay
  --itemize-changes
  --info=stats2,progress2
  --one-file-system
)

# Excludes for "Backup all" (source is $HOME_DIR/)
EXCLUDES=(
--exclude='.venv/'
--exclude='*/.venv/'
--exclude='venv/'
--exclude='*/venv/'
  --exclude='.cache/'
  --exclude='*/.cache/'
  --exclude='__pycache__/'
  --exclude='*.pyc'
  --exclude='.local/share/Trash/'
  --exclude='.local/share/Steam/'
  --exclude='Downloads/'
  --exclude='PythonProjects/'          # excluded from main backup; handled separately
  --exclude='.config/google-chrome/'   # NOTE: excludes bookmarks/settings too
)

backup_all() {
  require_mount
  local log="$LOG_DIR/backup_all_$TS.log"
  echo "Backing up: $HOME_DIR/ -> $BACKUP_DIR/"
  echo "Log: $log"
  rsync "${RSYNC_COMMON[@]}" "${EXCLUDES[@]}" \
    "$HOME_DIR/" "$BACKUP_DIR/" | tee "$log"
}

backup_python() {
  require_mount
  local log="$LOG_DIR/backup_python_$TS.log"
  echo "Backing up: $HOME_DIR/PythonProjects/ -> $PY_BACKUP_DIR/"
  echo "Log: $log"
  rsync "${RSYNC_COMMON[@]}" \
    "$HOME_DIR/PythonProjects/" "$PY_BACKUP_DIR/" | tee "$log"
}

restore_from_backup() {
  require_mount

  echo "Dry-run restore first (no changes). Review carefully!"
  echo
  rsync -aHvn --no-owner --no-group --itemize-changes \
    "$BACKUP_DIR/" "$HOME_DIR/"
  echo
  echo "If that looks correct, type RESTORE to proceed (anything else cancels):"
  read -r confirm
  if [[ "$confirm" != "RESTORE" ]]; then
    echo "Cancelled."
    return
  fi

  local log="$LOG_DIR/restore_$TS.log"
  echo "Restoring: $BACKUP_DIR/ -> $HOME_DIR/"
  echo "Log: $log"
  rsync -aHv --no-owner --no-group --itemize-changes \
    "$BACKUP_DIR/" "$HOME_DIR/" 
}

while true; do
  echo
  echo "1) Backup all"
  echo "2) Backup Python"
  echo "3) Restore from backup"
  echo "4) Exit"
  echo

  read -r -p "Select an option: " choice

  case "$choice" in
    1) backup_all ;;
    2) backup_python ;;
    3) restore_from_backup ;;
    4) exit 0 ;;
    *) echo "Invalid choice" ;;
  esac
done
