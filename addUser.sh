#!/bin/bash

# This script creates an account on the local system.
# You will be propted for the account name and password.
# The -p is for a propt to tell the user the info requested.

# Ask for the user name.
read -p 'Enter the username you want to create: ' USER_NAME

# Ask for the REAL name
read -p 'Enter the name of the person who this account is for: ' COMMENT

# Ask for a password.
read -p 'Enter the password to use for the account: ' PASSWORD

# Create the user. The quotes around COMMENT is used in case
# the user adds more than one name or there are spaces'
useradd -c "${COMMENT}" -m ${USER_NAME}

# Set the password for the user.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Force password change on first login.
passwd -e ${USER_NAME}

