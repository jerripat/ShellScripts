#!/bin/bash 

listFiles()
    echo "Printing the files and folders of the current Directory.."
    read -p "Enter directory name" dir
    echo ${dir}
    exit 0
        for filename in *. ; do
            echo ${filename};
        done

listFiles
