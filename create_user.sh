#!/bin/bash

DB_FILE="users.db"

# Ask for input
read -p "Enter the username you want to create: " USER_NAME
read -p "Enter the password you want to create: " PASSWORD
read -p "Enter the URL you want to create: " URL

# Create table if it doesn't exist
sqlite3 "$DB_FILE" "
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT,
    password TEXT,
    url TEXT
);
"

# Insert the data
sqlite3 "$DB_FILE" "
INSERT INTO users (username, password, url)
VALUES ('$USER_NAME', '$PASSWORD', '$URL');
"

echo "User added to database: $DB_FILE"

