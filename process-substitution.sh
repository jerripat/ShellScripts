#!/bin/bash

while read -r word; do
echo "$word"
((i++))
done < <(grep di /usr/share/dict/words) 

echo "found $i words"
