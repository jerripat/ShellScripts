#!/bin/bash
echo "Welcome to the Pycharm Backup"
read -p "Would you like to backup the home directory? (y/n): " ans

if [[ "$ans" == "y" ]]; then
	  rsync -aHAXv /home/jerripat/PycharmProjects /media/jerripat/Sam/PythonProjects/
else
echo "Exiting..."
fi
