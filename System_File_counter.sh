
#!/bin/bash

# Count all regular files on the system

echo "=================================="
echo "       SYSTEM FILE COUNTER"
echo "=================================="
echo
echo "Scanning your system..."
echo "This may take a few minutes."
echo

# Count regular files, including hidden files
# Exclude virtual system directories
total=$(find / \
    -type f \
    ! -path "/proc/*" \
    ! -path "/sys/*" \
    ! -path "/dev/*" \
    ! -path "/run/*" \
    2>/dev/null | wc -l)

echo
echo "=================================="
printf "Total files: %'d\n" "$total"
echo "=================================="

