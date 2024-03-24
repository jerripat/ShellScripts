#!/bin/bash

read -p 'Start nala install? (y/n): ' ans

if [[ ${ans} == 'y' ]]
then
echo 'Installing repository...'

# Install repository
echo "deb [arch=amd64,arm64,armhf] http://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
else
		echo 'exiting nala install'
		sleep 1
		exit 0
fi
echo 'Sleeping...'
sleep 3
echo 'Adding GPG key...'
# Add GPG key
wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null
echo 'Sleeping...'
sleep 3
	read -p 'Update and install nala? (y/n) :' ans2
		if [[ ${ans2} == 'y' ]]
		then
			# Update and install nala
			echo 'Starting installation'
			sleep 2
			sudo apt update && sudo apt install nala -y
			read -p 'Update and install new mirrors? (y/n): ' ans3
				if [[ ${ans3} == 'y' ]]
				then
					# get mirrors
					echo 'Updating and upgradng mirrors'
					sleep 2
						sudo nala fetch
						sudo nala update && sudo nala upgrade
					echo "Nala successfully installed"
					sleep 3
				fi
else
		echo 'Cancelling nala update and installation'
		sleep 2
		exit 0
fi
echo "Nala successfully installed"
