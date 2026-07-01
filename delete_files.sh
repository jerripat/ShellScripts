#!/bin/bash

# Check if directory was provided
if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/directory"
    exit 1
fi

DIR="$1"

# Check if it is a real directory
if [ ! -d "$DIR" ]; then
    echo "Error: '$DIR' is not a valid directory."
    exit 1
fi

echo "This will delete all files inside:"
echo "$DIR"
echo
read -p "Are you sure? Type YES to continue: " confirm

if [ "$confirm" != "YES" ]; then
    echo "Canceled."
    exit 0
fi

# Delete files only, not directories
find "$DIR" -maxdepth 1 -type f -delete

echo "All files in '$DIR' have been deleted."
#!/bin/bash

if [[ "$1" == "sn" ]]; then
    sudo nala update
fi

