#!/bin/bash

read -p "Do you want to enter a user? (y/n): " ans

if [[ $ans == 'y' ]]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    DB_FILE="$SCRIPT_DIR/users.db"

    read -p "Enter username: " USER_NAME
    read -p "Enter password: " PASSWORD
    read -p "Enter URL: " URL

    # Create the table if it doesn't exist
    sqlite3 "$DB_FILE" <<EOF
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT,
    password TEXT,
    url TEXT
);
EOF

    # Insert safely (prevent SQL injection)
    sqlite3 "$DB_FILE" <<EOF
INSERT INTO users (username, password, url)
VALUES ('$(sqlite3 "$DB_FILE" "SELECT quote('$USER_NAME')")',
        '$(sqlite3 "$DB_FILE" "SELECT quote('$PASSWORD')")',
        '$(sqlite3 "$DB_FILE" "SELECT quote('$URL')")');
EOF

    echo "User added to database: $DB_FILE"
else
    echo "Exiting..."
    exit 0
fi

