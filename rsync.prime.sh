

startBackup() {

	if [[ ${1} == '4' ]]; then
		# This is the Backup script for home/jerripat
		echo 'Starting backup to /home/jerripat'
		sleep 2
		sudo rsync -avz --progress --exclude '*.config/' --exclude '*.cache/' --exclude ' *.iso' --max-size=2g 	/home/jerripat/ /media/jerripat/SeaOne/rsync_backup
		echo "Done!"
		sleep 2
		createMenu
	elif [[ ${1} == '5' ]]; then
		sudo rsync -avz --progress --exclude '*.config/' --exclude '*.cache/' --exclude ' *.iso' --max-size=2g /home/ /media/jerripat/SeagateOne/rsync_backup/home_dir/
		echo "Done backing up home dir!"
		sleep 2
		createMenu
	elif [[ ${1} == '6' ]]; then
		createTar
		createMenu
	fi
}

backupShellScripts() {

	echo 'Starting ShellScript backup...'
	sleep 2
	# ShellScripts backup
	sudo rsync -avz --progress /home/jerripat/ShellScripts /media/jerripat/SeagateOne/rsync_backup/ShellScripts
	echo "ShellScripts backup was successfull.."
	sleep 2
	createMenu
}

 createTar(){
	dest_path='/media/jerripat/SeagateOne/backup.tar.gz'
   files_to_backup='/home/jerripat/'

   echo 'the destination is:' ${dest_path}
   echo 'the path is:' ${files_to_backup}
   sleep 2

  read -pr'Begin tar? (y/n) : ' ans
 	 if [[ ${ans} == 'y' ]]
  		then
  		echo 'Starting tar...'
   		sleep 2
  			sudo tar --exclude-caches-all --recursion -zcvpf ${dest_path} ${files_to_backup}
  			echo 'tar.gz created...'
  			echo 'Exiting'
	fi
}

createMenu() {

	# This function creates the menu
	PS3="Enter index: "
	select i in ShellScripts PythonProjects JavascriptProjects jerripat Home Tar exit;
		echo "You selected: $i"
		echo "Index selected: $REPLY"
		makeSelection "$REPLY"
	

}

makeSelection() {

	echo "In makeSelection() you chose $1"

	if [[ ${1} == '7' ]]; then
		echo "You chose $1"
		echo "Good-Bye"
		exit 0

	elif [[ "${1}" == '1' ]]; then
		backupShellScripts
	elif [[ ${1} == '4' ]]; then
		startBackup ${1}
	elif [[ ${1} == '5' ]]; then
		startBackup ${1}
	elif [[ ${1} == '6' ]]; then
		source tar_backup.sh
		echo 'tar created in SeagateOne/backup'
		read -p 'Create Tar backup? (y/n): ' ans1
		if [[ ${ans1} == 'y' ]]; then
			echo 'Creating Tar backup...'
			sleep 2
			createTar

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
