#!/usr/bin/env bash

#
# Powermenu made with Rofi by @git:Carbon-Bl4ck
# adapted from https://raw.githubusercontent.com/Carbon-Bl4ck/Rofi-Beats/main/rofi-beats-linux

LWD="$HOME/.local/share/dermodex/rofi"
MPRIS_PLUGIN_PATH="$HOME/.local/share/dermodex/.mpris.so"

notification(){
# change the icon to whatever you want. Make sure your notification server 
# supports it and already configured.

# Now it will receive argument so the user can rename the radio title
# to whatever they want

	notify-send "Playing now: " "$@" --icon=mpv
}


STATION_N=$(grep -i 'name":' ~/.cinnamon/configs/radio@driglu4it/radio@driglu4it.json | cut -d '"' -f 4)
STATION_U=$(grep -i 'url":' ~/.cinnamon/configs/radio@driglu4it/radio@driglu4it.json | head -n -1 | cut -d '"' -f 4)
set -o noglob; IFS=$'\n' station=($STATION_N); set +o noglob
set -o noglob; IFS=$'\n' url=($STATION_U); set +o noglob


menu(){
	for i in "${station[@]}"
    do
       : 
       printf "$i\n"
    done
}

main() {
	choice=$(menu | rofi -theme ${LWD}/themes/dd_radio.rasi -dmenu -p "Choose something to listen to ..." a| cut -d. -f1)
    
    for i in "${!station[@]}"; do
        if [[ "${station[$i]}" = "${choice}" ]]; then
           STATION_URL="${url[i]}";
           STATION_NAME="${choice}";
        fi
    
    done
    
    #notification "${STATION_NAME}"
    
    # run mpv with args and selected url
    # added title arg to make sure the pkill command kills only this instance of mpv
    # using the mpris plugin for mpv to allow cinnamon sound player to control playback and show meta data
    mpv --title="radio-mpv" --volume=60 --audio-buffer=5 --config=no --no-video --script=${MPRIS_PLUGIN_PATH} $STATION_URL
}

pkill -f radio-mpv || main