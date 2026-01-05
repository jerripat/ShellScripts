#!/usr/bin/env bash
# A simple script to kill a process running on a user-specified port.
# Works on macOS and Linux.

set -euo pipefail

# Prompt the user for the port
read -rp "Enter the port number to kill: " port

# Validate input (must be a number between 1–65535)
if ! [[ "$port" =~ ^[0-9]+$ ]] || [ "$port" -lt 1 ] || [ "$port" -gt 65535 ]; then
  echo "❌ Invalid port number: $port"
  exit 1
fi

echo "🔍 Searching for processes using port $port..."

# Find process using the port
if command -v lsof >/dev/null 2>&1; then
  pids=$(lsof -t -i:"$port" || true)
elif command -v fuser >/dev/null 2>&1; then
  pids=$(fuser -n tcp "$port" 2>/dev/null || true)
else
  echo "❌ Neither 'lsof' nor 'fuser' is installed. Please install one."
  exit 2
fi

if [ -z "$pids" ]; then
  echo "✅ No process found on port $port."
  exit 0
fi

echo "⚠️  Process(es) using port $port: $pids"

# Confirm before killing
read -rp "Do you want to kill these processes? [y/N]: " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
  echo "🛑 Killing process(es)..."
  kill $pids 2>/dev/null || true
  sleep 0.5
  kill -9 $pids 2>/dev/null || true
  echo "✅ Port $port cleared."
else
  echo "❎ Operation cancelled."
fi

