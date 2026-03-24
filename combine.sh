#!/bin/bash
set -euo pipefail

SOURCE="$HOME/PycharmProjects/"
DEST="$HOME/PythonProjects/"

mkdir -p "$DEST"

# Add/update files from SOURCE into DEST.
# - Does NOT delete anything from DEST.
rsync -av --progress "$SOURCE" "$DEST"

