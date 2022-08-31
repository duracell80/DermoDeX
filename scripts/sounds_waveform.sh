#!/usr/bin/env bash

CONF_FILE="$HOME/.local/share/dermodex/config.ini"

# READ THE UPDATED CONFIG
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

if [ "$coloroverrides" == "true" ]; then
    if [ "$mainshade" = true ]; then
        ACCENT="#${override0}"
        
        if [ "$ACCENT" == "#aN" ] || [ "$ACCENT" == "#none" ]; then
            echo "[i] Fallback Active: #${savehex0}"
            ACCENT="#${savehex0}"
        fi
    else
        ACCENT="#${override1}"
        if [ "$ACCENT" == "#aN" ] || [ "$ACCENT" == "#none" ]; then
            echo "[i] Fallback Active: #${savehex1}"
            ACCENT="#${savehex1}"
        fi
    fi
else
    if [ "$mainshade" = true ]; then
        ACCENT="#${savehex0}"
    else
        ACCENT="#${savehex1}"
    fi
fi

if [ "$ACCENT" == "#aN" ]; then
    exit
fi

if [ "$ACCENT" == "#none" ]; then
    exit
fi


if [ ! -z "$1" ] 
then 
    FILE=$1
else
    FILE=$(gsettings get org.cinnamon.sounds login-file | cut -d "'" -f 2)
fi



echo "[i] Printing Sound File: ${$FILE}"

ffmpeg -y -i "${FILE}" -filter_complex "showwavespic=s=640x320:colors=${ACCENT}" -frames:v 1 $HOME/.local/share/dermodex/soundwaves.png