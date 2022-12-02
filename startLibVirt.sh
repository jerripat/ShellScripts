#!/bin/bash
read -p "Start libvirt? :" ans
if [[ "${ans}" == 'y' ]] 
then
	sudo systemctl start libvirtd
	echo 'libvirtd started'
else
	echo 'libvirt not started'
	exit 0
fi
