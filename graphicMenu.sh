#!/bin/bash

# --- Functions ---

kill_port() {
  # Prompt user for port number
  PORT=$(dialog --inputbox "Enter port number to kill:" 10 50 2>&1 >/dev/tty)

  # Check if user canceled
  if [ -z "$PORT" ]; then
    dialog --msgbox "No port entered. Returning to menu." 8 40
    return
  fi

  # Check if port is in use
  if sudo lsof -i :"$PORT" >/dev/null 2>&1; then
    dialog --yesno "Are you sure you want to kill port $PORT?" 8 50
    response=$?
    if [ $response -eq 0 ]; then
      sudo fuser -k "${PORT}"/tcp
      dialog --msgbox "✅ Port $PORT has been killed." 8 50
    else
      dialog --msgbox "Cancelled. Port $PORT was not killed." 8 50
    fi
  else
    dialog --msgbox "⚠️ No process found using port $PORT." 8 50
  fi
}

show_disk_usage() {
  df_output=$(df -h)
  dialog --msgbox "$df_output" 20 70
}

  dialog --msgbox "❌ Error: File not found at $source_file" 8 50
  rm -f "$tempfile"
  clear
  exit 1
  single_file_backup() {
  # Pick a source FILE
  local tmp=$(mktemp)
  trap 'rm -f "$tmp"' EXIT

  dialog --title "Pick source file" \
         --fselect "$HOME/" 12 70 2> "$tmp"
  local source_file
  source_file=$(<"$tmp")

  # If user hit Cancel or empty
  if [[ -z "$source_file" || ! -f "$source_file" ]]; then
    dialog --msgbox "Cancelled or invalid source file." 8 40
    return
  fi

  # Pick a DESTINATION DIRECTORY
  dialog --title "Pick destination directory" \
         --dselect "$HOME/" 12 70 2> "$tmp"
  local dest_dir
  dest_dir=$(<"$tmp")

  if [[ -z "$dest_dir" ]]; then
    dialog --msgbox "Cancelled." 6 24
    return
  fi

  # Ensure destination exists
  if [[ ! -d "$dest_dir" ]]; then
    dialog --yesno "Destination does not exist:\n$dest_dir\n\nCreate it?" 12 60
    if [[ $? -eq 0 ]]; then
      mkdir -p -- "$dest_dir" || {
        dialog --msgbox "Failed to create destination." 6 40
        return
      }
    else
      dialog --msgbox "Cancelled." 6 24
      return
    fi
  fi

  # Run the copy with rsync (preserves metadata)
  dialog --infobox "Backing up:\n$source_file\n→ $dest_dir" 7 60
  rsync -avh --info=progress2 -- "$source_file" "$dest_dir"/
  local code=$?

  if [[ $code -eq 0 ]]; then
    dialog --msgbox "✅ Backup complete:\n$(basename -- "$source_file") → $dest_dir" 8 60
  else
    dialog --msgbox "❌ Backup failed (exit $code)." 6 40
  fi
}

# Optional: fix your full_backup() status line
full_backup() {
  rsync -av /home/jerripat /media/jerripat/Sam/backup
  local code=$?
  if [[ $code -eq 0 ]]; then
    dialog --msgbox "✅ Full backup complete." 6 40
  else
    dialog --msgbox "❌ Full backup failed (exit $code)." 6 48
  fi
}
single_file_backup() {
  # Use dialog file/dir pickers and copy with rsync
  local tmp
  tmp=$(mktemp) || { dialog --msgbox "Could not create temp file." 6 40; return 1; }
  trap 'rm -f "$tmp"' RETURN

  # Pick source file
  dialog --title "Pick source file" --fselect "$HOME/" 12 70 2> "$tmp"
  local source_file; source_file=$(<"$tmp")
  [[ -z "$source_file" || ! -f "$source_file" ]] && { dialog --msgbox "Cancelled or invalid source file." 8 46; return 1; }

  # Pick destination directory
  dialog --title "Pick destination directory" --dselect "$HOME/" 12 70 2> "$tmp"
  local dest_dir; dest_dir=$(<"$tmp")
  [[ -z "$dest_dir" ]] && { dialog --msgbox "Cancelled." 6 24; return 1; }

  # Ensure destination exists (offer to create)
  if [[ ! -d "$dest_dir" ]]; then
    dialog --yesno "Destination does not exist:\n$dest_dir\n\nCreate it?" 12 60
    if [[ $? -eq 0 ]]; then
      mkdir -p -- "$dest_dir" || { dialog --msgbox "Failed to create destination." 6 44; return 1; }
    else
      dialog --msgbox "Cancelled." 6 24
      return 1
    fi
  fi

  # Copy (preserve metadata; show progress)
  dialog --infobox "Backing up:\n$source_file\n→ $dest_dir" 7 60
  rsync -avh --info=progress2 -- "$source_file" "$dest_dir"/
  local code=$?

  if [[ $code -eq 0 ]]; then
    dialog --msgbox "✅ Backup complete:\n$(basename -- "$source_file") → $dest_dir" 8 60
  else
    dialog --msgbox "❌ Backup failed (exit $code)." 6 48
  fi
}

full_backup() {
  rsync -av /home/jerripat /media/jerripat/Sam/backup
  local code=$?
  if [[ $code -eq 0 ]]; then
    dialog --msgbox "✅ Full backup complete." 6 40
  else
    dialog --msgbox "❌ Full backup failed (exit $code)." 6 48
  fi
}

# --- Step 3: Perform the backup ---
cp "$source_file" "$backup_dir"

# --- Step 4: Display result ---
if [[ $? -eq 0 ]]; then
  dialog --msgbox "✅ Backup successful!\nFile saved to: $backup_dir/$(basename "$source_file")" 10 60
else
  dialog --msgbox "❌ Backup failed!" 8 40
fi

# Cleanup
rm -f "$tempfile"
clear
dialog --msgbox "Task Complete!" 5 10 "Exit status : {$?}"
}
show_goodbye(){
dialog --msgbox "Good Bye" 5 10 "Good-bye"

}

# --- Main Menu Loop ---
while true; do
  dialog --clear --menu "📋 Main Menu" 20 50 5 \
    1 "Disk Usage" \
    2 "Kill Port" \
    3 "Backup" \
    4 "Single File Backup" \
    5 "Exit" 2>output.txt

  choice=$(<output.txt)
  rm -f output.txt

  case $choice in
    1) show_disk_usage ;;
    2) kill_port ;;
    3) full_backup ;;
    4) single_file_backup ;;
    5) clear; echo "Goodbye 👋"; say_goodbye; exit 0 ;;
    *) dialog --msgbox "Invalid option. Try again." 8 40 ;;
  esac
done

