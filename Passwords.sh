#!/bin/bash

FILE=~/Desktop/passcodes.txt

while IFS= read -r line; do
    echo "$line"
done < "$FILE"

