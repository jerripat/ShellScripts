#!/bin/bash

# Function to get disk space before cleanup
get_disk_space_before_cleanup() {
    df -h / | awk 'NR==2 {print $4}'
}

# Function to get disk space after cleanup
get_disk_space_after_cleanup() {
    df -h / | awk 'NR==2 {print $4}'
}

# Function to purge Temporary Files
purge_temporary_files() {
    echo "Purging Temporary Files..."
    sudo rm -rf /tmp/*
}

# Function to empty Trash
empty_trash() {
    echo "Emptying Trash..."
    rm -rf ~/.local/share/Trash/*
}

# Get disk space before cleanup
disk_space_before=$(get_disk_space_before_cleanup)

# Perform cleanup
purge_temporary_files
empty_trash

# Get disk space after cleanup
disk_space_after=$(get_disk_space_after_cleanup)

# Calculate freed disk space
freed_space=$(echo "$disk_space_before - $disk_space_after" | bc)

echo "Cleanup complete."
echo "Freed disk space: $freed_space"

