#!/bin/bash

read -rp "Would you like to run htop? (y/n) " ans

if [[ "$ans" =~ ^[Yy]$ ]]; then
    if ! command -v htop >/dev/null 2>&1; then
        echo "htop is not installed. Install it with your system package manager."
        exit 1
    fi

    echo "Starting htop..."
    sleep 2
    exec htop
else
    echo "Cancel htop..."
    sleep 1
    exit 0
fi
