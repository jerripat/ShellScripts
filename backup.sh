#!/bin/bash

startBackup() {

    echo 'Starting backup...'
    sleep 2

    # This is the Backup script for home/jerripat
    sudo rsync -avz --progress --exclude '*.config/' --exclude '*.cache/' --exclude ' *.iso' --max-size=1g /home/jerripat/ /media/jerripat/Seagate2TB/rsync_backup/
    echo "Done!"
    sleep 2
    createMenu
}

backupShellScripts() {

    echo 'Starting ShellScript backup...'
    sleep 2
    # ShellScripts backup
    sudo rsync -avz --progress /home/jerripat/ShellScripts /media/jerripat/Seagate2TB/rsync_backup/ShellScripts
    echo "ShellScripts backup was successfull.."
    sleep 2
    createMenu
}

createMenu() {

    # This function creates the menu
    PS3="Enter index: "
    select i in ShellScripts PythonProjects JavascriptProjects Backup Tar exit; do
        echo "You selected: $i"
        echo "Index selected: $REPLY"
        makeSelection "$REPLY"
    done
    exit 0
}

makeSelection() {

    echo "In makeSelection() you chose $1"

    if [[ ${1} == '6' ]]; then
        echo "You chose $1"
        echo "Good-Bye"
<<<<<<< HEAD
	    sleep 2
		exit 0
=======
        sleep 2
>>>>>>> 8579b6d (Update to program)

    elif [[ "${1}" == '1' ]]; then
        backupShellScripts
    elif [[ ${1} == '4' ]]; then
        startBackup

    elif [[ ${1} == '5' ]]; then
        source tar_backup.sh
        echo 'tar created in Seagate2TB/backup'
        read -p 'Start rsync backup (y/n): ' ans1
        if [[ ${ans1} == 'y' ]]; then
            echo 'Starting rsync backup'
            sleep 2
            startBackup

        fi
    fi

}

read -p 'Do you want to start an rsync backup: (y/n) ' ans
if [[ ${ans} == 'y' ]]; then
    echo 'Creating menu...'

    createMenu
else
    echo 'Exiting backup'
    exit 0
fi
