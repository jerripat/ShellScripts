#!/bin/bash


cleanup(){

#!/bin/bash

# Function to get disk space before cleanup
get_disk_space_before_cleanup() {
    df -h / | awk 'NR==2 {print $4}'
}

# Function to get disk space after cleanup
get_disk_space_after_cleanup() {
    df -h / | awk 'NR==2 {print $4}'
}

# Function to purge Temporary Files
purge_temporary_files() {
    echo "Purging Temporary Files..."
    sudo rm -rf /tmp/*
}

# Function to empty Trash
empty_trash() {
    echo "Emptying Trash..."
    rm -rf ~/.local/share/Trash/*
}

# Get disk space before cleanup
disk_space_before=$(get_disk_space_before_cleanup)

# Perform cleanup
purge_temporary_files
empty_trash

# Get disk space after cleanup
disk_space_after=$(get_disk_space_after_cleanup)

# Calculate freed disk space
freed_space=$(echo "$disk_space_before - $disk_space_after" | bc)

echo "Cleanup complete."
echo "Freed disk space: $freed_space"

}



runPycharm(){
cd ~/PycharmProjects/pycharm-2023.3.5/bin
./pycharm.sh

}
chown(){

clear
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

menu
}

startArduino(){
clear
sudo chmod a+rw /dev/ttyACM0
echo 'Port is ready'
menu
}

killport(){
    clear

    echo "Enter the port number:"
    read portnum

    if [ -z "$portnum" ]; then
        echo "Port number cannot be empty"
        exit 1
    fi

    pid=$(lsof -ti:$portnum)

    if [ -z "$pid" ]; then
        echo "No process listening on port $portnum"
    else
        # Kill the process
        kill -9 $pid
        echo "Process listening on $portnum has been terminated"
    fi

    menu
}

backup() {

	rsync -avz /home/jerripat/  /media/jerripat/SeaOne/Backup/
	menu
}


menu(){
	clear
	echo""
	var1=0
	echo " Linux Menu Toolkit
	       *****************
	   1) Kill Port
	   2) Directory Change Permissions
	   3) Change Owner
	   4) Backup
	   5) Arduino
	   6) Pycharm
	   7) Clean up
	   8) Exit "



	read -p "Selection...>" selection
	case $selection in 
	   1) killport ;;
  	   2) prompt_for_dirctory ;;
	   3) chown ;;
	   4) backup  
		read -p "Press Enter to continue"
		menu ;;
	   5) startArduino ;;
	   6) runPycharm ;;
	   7) cleanup ;;
	   8) exit ;;
	   *)  echo "Invalid Selection"
	       read -p "Press enter to continue"
	       menu ;;
	esac

}
clear
menu
