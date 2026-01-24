#!/bin/bash

array=(foo bar baz)

for ((i=0; i<${#array[@]}; i++)); do
  echo "${array[i]}"
done
