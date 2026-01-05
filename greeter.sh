#!/bin/bash

greet() {
	local name=$1
	echo "Hello $name (from func)"
}

for name in "$@"; do
	greet "$name" 
done

var=$(greet dave)
echo "var is ${var}"
