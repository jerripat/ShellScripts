#!/bin/bash

read -p "Would you like to run htop? (y/n) " ans
if [[ ${ans} == 'y' ]]
then
	
	echo 'Starting htop...'
	sleep 2
	exec htop
else
		echo 'Cancel htop...'
		sleep 1
		exit 0
fi

