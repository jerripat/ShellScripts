#!/bin/bash

createMenu() {

  # This function creates the menu
    PS3="Enter index: "
	# Install curl, wget or git
	echo 'Select curl, wget or git if needs to be installed'
    select i in curl wget git exit; do
        echo "You selected: $i"
        echo "Index selected: $REPLY"
        makeSelection "$REPLY"
		done
}

installCWG(){
	echo 'Installing curl...'
	sleep 2
	if [[ "${1}" == '1' ]]; then
		sudo apt install curl
		createmenu
	echo 'Installing wget...'
	sleep 2
	elif [[ "${1}" == '2' ]]; then
		sudo apt install wget
		createmenu
	echo 'Installing git...'
	sleep 2
	elif [[ "${1}" == '3' ]] ; then
		sudo apt install git
	sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
	echo 'Adding powerlevel10k to .zshrc'
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
	echo 'Opening .zshrc...add powerlevel10k to ZSH_THEME'
	sleep 2
	echo 'Installing zsh-autosuggestions and zsh-syntax-highlighting'
	git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
	sleep 2
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
	echo 'plugins = (git zsh-autosuggestions zsh-syntax-highlighting)' >> ~/.zshrc
	vim ~/.zshrc
	source ~/.zshrc
	createmenu
	else
	echo 'Cancelling install'
	sleep 2
	createMenu
fi
}

doUpdate(){

	echo 'Starting update...'
	sleep 2
	sudo apt update && sudo apt upgrade


}

makeSelection() {

    echo "In makeSelection() you chose $1"

    if [[ ${1} == '4' ]]; then
        echo "Good-Bye"
	    sleep 2
		exit 0
    elif [[ "${1}" == '1' ]]; then
        installCWG ${1}
    fi

}


# This script will install ZSH
read -p 'Begin ZSH installation? (y/n): ' ans

if [[ "${ans}" == 'y' ]] ; then
	createMenu

else
		echo 'Cancelling installation...'
		sleep 2
		exit 0
fi
