#!/usr/bin/env bash

FILE="$HOME/.cache/dermodex/get_sounds.txt"
touch $FILE
chmod u+rw $FILE

SUND="$HOME/.cache/dermodex/set_sounds.txt"
rm -f $SUND
touch $SUND
chmod u+rw $SUND

gsettings list-keys org.cinnamon.sounds > $FILE

while read -r LINE; do
	SOUND=$(gsettings get org.cinnamon.sounds "${LINE}")
	if [[ $SOUND == *".oga"* ]]; then
		SETLINE=$(echo -e "gsettings set org.cinnamon.sounds ${LINE} ${SOUND}\n")
		echo $SETLINE >> $SUND
	fi
done <$FILE
