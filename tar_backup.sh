#!/bin/bash

dest_path='/media/jerripat/SeagateOne/backup.tar.gz'
files_to_backup='/home/jerripat/'

echo 'the destination is: ${dest_path}'
echo 'the path is: ${files_to_backup}'
sleep 2

read -pr'Begin tar? (y/n) : ' ans
if [[ ${ans} == 'y' ]]
then
echo 'Starting tar...'
echo 'The destination is ${dest_path}'
sleep 2
sudo tar --exclude-caches-all --recursion -zcvpf ${dest_path}   ${files_to_backup}
echo 'tar.gz created...'
echo 'Exiting'
sleep 2
exit 0
else
		echo "Ending tar..."
		exit 0
fi
cd ${dest_path}
