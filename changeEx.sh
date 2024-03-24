#!/bin/zsh

# Function to prompt the user for a directory
prompt_for_directory() {
    echo -n "Enter the directory path: "
    read directory
}

# Prompt the user for a directory
prompt_for_directory

# Check if the directory exists
if [[ ! -d "$directory" ]]; then
  echo "Directory not found!"
  exit 1
fi

# Change directory to the specified directory
cd "$directory" || exit

# Set all files in the directory to be executable
for file in *; do
  if [[ -f "$file" ]]; then
    chmod +x "$file"
    echo "Set executable permission for: $file"
  fi
done

echo "Execution permission has been set for all files in the directory."
