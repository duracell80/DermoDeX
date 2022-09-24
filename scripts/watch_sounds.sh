#!/usr/bin/env bash
# READ THE UPDATED CONFIG
CONF_FILE="$HOME/.local/share/dermodex/config.ini"
shopt -s extglob

tr -d '\r' < $CONF_FILE | sed 's/[][]//g' > $CONF_FILE.unix
while IFS='= ' read -r lhs rhs
do
    if [[ ! $lhs =~ ^\ *# && -n $lhs ]]; then
        rhs="${rhs%%\#*}"    # Del in line right comments
        rhs="${rhs%%*( )}"   # Del trailing spaces
        rhs="${rhs%\"*}"     # Del opening string quotes 
        rhs="${rhs#\"*}"     # Del closing string quotes 
        declare $lhs="$rhs"
    fi
done < $CONF_FILE.unix
shopt -u extglob # Switching it back off after use

# SET SOUNDS
echo "[i] Sound Theme: ${soundtheme}"
set_sound_theme $soundtheme