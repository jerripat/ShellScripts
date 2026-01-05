#!/bin/bash

case "${1}" in
	start)
	echo "Starting"
	;;
	stop)
	echo "Stopping"
	;;
	status|state)
	echo "Status updated"
	;;
	*)
	echo "Supply a valid option." >&2
	exit 1
	;;


esac
