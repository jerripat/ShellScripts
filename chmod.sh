#!/usr/bin/env bash
read -p 'Enter directory: ' dir
echo ${dir}
echo 'Sleeping...'
sleep 5

for file in ${dir} ;
do

echo 'sleeping...' 
sleep 3
    sudo chown 755 $file ;
done

echo 'Done'
