#!/usr/bin/env bash
CWD=$(pwd)
FILE="$CWD/list.txt"

ls *.svg > $FILE

while read -r LINE; do
	if [[ $LINE == *".svg"* ]]; then
        sed -i "s|#ffaa00|#333333|g" ${LINE}
	fi
done < $FILE
