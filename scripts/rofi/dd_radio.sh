#!/usr/bin/env bash

#
# Powermenu made with Rofi by @git:Carbon-Bl4ck
# adapted from https://raw.githubusercontent.com/Carbon-Bl4ck/Rofi-Beats/main/rofi-beats-linux

LWD="$HOME/.local/share/dermodex/rofi"
MPRIS_PLUGIN_PATH="$HOME/.local/share/dermodex/.mpris.so"
CINN_RADIO_CONFIG="$HOME/.cinnamon/configs/radio@driglu4it/radio@driglu4it.json"

notification(){
# change the icon to whatever you want. Make sure your notification server 
# supports it and already configured.

# Now it will receive argument so the user can rename the radio title
# to whatever they want

	notify-send "Playing now: " "$@" --icon=mpv
}


STATION_N=$(grep -i 'name":' $CINN_RADIO_CONFIG | cut -d '"' -f 4)
STATION_U=$(grep -i 'url":' $CINN_RADIO_CONFIG | head -n -1 | cut -d '"' -f 4)
STATION_I=$(grep -i 'inc":' $CINN_RADIO_CONFIG | cut -d ':' -f 2 | cut -c2- | xargs)


set -o noglob; IFS=$'\n' station=($STATION_N); set +o noglob
set -o noglob; IFS=$'\n' url=($STATION_U); set +o noglob
set -o noglob; IFS=$' ' inc=($STATION_I); set +o noglob


menu(){
	i=0
    for s in "${station[@]}"
    do
       : 
       if [[ "${inc[$i]}" = "true," ]]; then
        printf "${station[$i]}\n"
       fi
       i=$(( i + 1 ))
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