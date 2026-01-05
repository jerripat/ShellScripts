#!/bin/bash
 
for thing in "$@"; do
          echo "The thing is: ${thing}"
done

for thing in {a..z};do
	echo "Thing is : ${thing}"
done
