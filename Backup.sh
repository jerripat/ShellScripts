#!/bin/bash
set -euo pipefail

BACKUP_MNT="/media/jerripat/Sam"
BACKUP_DIR="$BACKUP_MNT/backup"
HOME_DIR="/home/jerripat"

require_mount() {
  if ! mountpoint -q "$BACKUP_MNT"; then
    echo "ERROR: $BACKUP_MNT is not mounted. Aborting."
    exit 1
  fi
}

while true; do
  echo
  echo "1) Backup all"
  echo "2) Backup PyCharm"
  echo "3) Restore from backup"
  echo "4) Exit"
  echo

  read -rp "Select an option: " choice

  case "$choice" in
    1)
      require_mount
      rsync -aHv --delete --delete-delay --no-owner --no-group \
        --exclude='.cache/' \
        --exclude='*/.cache/' \
        --exclude='__pycache__/' \
        --exclude='*.pyc' \
        --exclude='.config/google-chrome/' \
        --exclude='.local/share/Trash/' \
        --exclude='.local/share/Steam/' \
        --exclude='Downloads/' \
        --exclude='PycharmProjects/' \
        "$HOME_DIR/" "$BACKUP_DIR/"
      ;;

    2)
      require_mount
      # Adjust this to the real folder you use:
      rsync -av --delete --delete-delay \
        "$HOME_DIR/PycharmProjects/" "$BACKUP_MNT/PycharmProjects/"
      ;;

    3)
      require_mount
      echo "Dry-run restore first (no changes). Review carefully!"
      rsync -aHvn --no-owner --no-group \
        "$BACKUP_DIR/" "$HOME_DIR/"
      echo "If that looks correct, run the same command without -n to restore."
      ;;

    4)
      exit 0
      ;;

    *)
      echo "Invalid choice"
      ;;
  esac
done
