#!/bin/bash

array=( foo bar biz )
for item in "${array[@]}"; do
	echo "Item is :  $item"
done
