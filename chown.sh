#!/bin/bash

# Prompt the user for a directory
echo "Please enter the directory path:"
read directory_path

# Check if the directory exists
if [ -d "$directory_path" ]; then
    # Change the ownership to jerripat:jerripat
    sudo chown -R jerripat:jerripat "$directory_path"
    echo "Ownership of $directory_path has been changed to jerripat:jerripat."
else
    echo "The directory $directory_path does not exist."
fi

