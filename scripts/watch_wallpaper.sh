#!/usr/bin/env bash
HOLD_FILE="$HOME/.local/share/dermodex/dermodex_hold"
if [ -f "$HOLD_FILE" ]; then
    ACT="0"
else
    mkdir -p $HOME/.cache/dermodex
    touch $HOME/.cache/dermodex/wallpaper.jpg
    touch $HOME/.cache/dermodex/wallpaper_swatch.png
    touch $HOME/.cache/dermodex/resize_wallpaper.jpg
    touch $HOME/.cache/dermodex/wallpaper_current.txt
    touch $HOME/.cache/dermodex/bg.png
    touch $HOME/.cache/dermodex/colors_hex.txt
    touch $HOME/.cache/dermodex/colors_rgb.txt

    if ! type "xdotool" > /dev/null 2>&1; then
        notify-send --urgency=normal --category=im.recieved --icon=help-info-symbolic "DermoDeX Color Extractor Active" "Looks for changes to the desktop wallpaper infrequently and upon reboot. DermoDeX reloads Cinnamon with accent colors from that image and looks for changes up to 15 miutes after waking! Press CTRL+Alt+Esc to reload the desktop environment."

    else
        notify-send --urgency=normal --category=im.recieved --icon=help-info-symbolic "DermoDeX Color Extractor Active" "Looks for changes to the desktop wallpaper infrequently and upon reboot. DermoDeX reloads Cinnamon with accent colors from that image! DermoDeX monitors the desktop wallpaper for accent colors for 15 minutes after launching."
    fi

    while true
    do
        if [ -f "$HOLD_FILE" ]; then
            # Hold DermoDeX from acting upon wallpaper changes
            ACT="0"
        else
            # Let DermoDeX do
            CUR=$(gsettings get org.cinnamon.desktop.background picture-uri)
            PAS=$(cat $HOME/.cache/dermodex/wallpaper_current.txt)

            if [ "$PAS" != "$CUR" ]; then
                ACT="1"

                echo $CUR > $HOME/.cache/dermodex/wallpaper_current.txt
                python3 $HOME/.local/share/dermodex/colors.py
                cp $HOME/.local/share/dermodex/cinnamon_base.css $HOME/.cache/dermodex/cinnamon.css

                COS=$(tail -n 3 $HOME/.cache/dermodex/colors_rgb.txt | head -1 | rev | cut -c2- | rev)
                COE=$(head -n 3 $HOME/.cache/dermodex/colors_rgb.txt | tail -1 | rev | cut -c2- | rev)
                HOS=$(tail -n 3 $HOME/.cache/dermodex/colors_hex.txt | head -1 | rev | cut -c1- | rev)
                HOE=$(head -n 3 $HOME/.cache/dermodex/colors_hex.txt | tail -1 | rev | cut -c1- | rev)
                
                MAINSHADE_RGB=$(head -n 1 $HOME/.cache/dermodex/colors_rgb.txt | tail -1 | rev | cut -c2- | rev)
                MAINSHADE_HEX=$(head -n 1 $HOME/.cache/dermodex/colors_hex.txt | tail -1 | rev | cut -c1- | rev)

                gsettings set org.cinnamon.desktop.background primary-color "${HOS}"
                gsettings set org.cinnamon.desktop.background secondary-color "${HOE}"
                gsettings set org.cinnamon.desktop.background color-shading-type "vertical"

                CONF_SLIDESHOW=$(gsettings get org.cinnamon.desktop.background.slideshow slideshow-enabled)
                CONF_SLIDETIME=$(gsettings get org.cinnamon.desktop.background.slideshow delay)
                CONF_ASPECT=$(gsettings get org.cinnamon.desktop.background picture-options)

                sed -i "s|fav-background-gradient-end: rgba(0,0,0|background-gradient-end: rgba${COE}|g" $HOME/.cache/dermodex/cinnamon.css
                sed -i "s|fav-background-gradient-start: rgba(0,0,0|background-gradient-start: rgba${COS}|g" $HOME/.cache/dermodex/cinnamon.css
		sed -i "s|#478db2|${HOE}|g" $HOME/.cache/dermodex/cinnamon.css

                # Shake the Cinnamon over the Coffee
                cp $HOME/.cache/dermodex/cinnamon.css $HOME/.themes/DermoDeX/cinnamon

                notify-send.sh --action="Hold DermoDeX":~/.local/bin/dd_hold --urgency=normal --category=transfer.complete --icon=cs-backgrounds-symbolic --hint=string:image-path:$HOME/.cache/dermodex/wallpaper_swatch.png "DermoDeX Recalculating Accent Colors!" "\nWait 15 seconds or manually reload Cinnamon with CTRL+Alt+Esc r.\n\nfile://${HOME}/.cache/dermodex/wallpaper_swatch.png"

                echo "[i] Updating Accent Colors ..."
                if ! type "xdotool" > /dev/null 2>&1; then
                    echo "[i] Hot Keys not installed run sudo apt get install xdotool"
                    notify-send.sh --action="Open Terminal":gnome-terminal --urgency=normal --category=im.receieved --icon=help-info-symbolic "Hot Keys Tool not installed ..." "Run 'sudo apt install xdotool' to automate reloading Cinnamon"
                else
                    if [ "$(find $HOME/.cache/dermodex/wallpaper_current.txt -mmin +15)" != "" ]
                        UPT=$(uptime)
                    then
                        sleep 5
                        xdotool key ctrl+alt+"Escape"
                    fi
                fi

                # Workaround cinnamon 5.3 reloading with multiple monitors and making wallpaper aspect strange
                #sleep 7
                #gsettings set org.cinnamon.desktop.background picture-options "centered"
                #sleep 3
                #gsettings set org.cinnamon.desktop.background picture-options "zoom"



            else
                ACT="0"
            fi

            # Letting The Cables Sleep
            if [ "$(find $HOME/.cache/dermodex/wallpaper_current.txt -mmin +15)" != "" ]
            then
                echo "[i] DermoDex Color Extractor Less Active"

                notify-send.sh --action="Wake DermoDeX":~/.local/bin/dd_wake --urgency=normal --category=im.receieved --icon=help-info-symbolic "DermoDex is currently resting." "Changing your wallpaper at the moment will take a while or reboot to reflect in your accent colors. Wake up DermoDeX with the dd_wake command. You can stop DermoDeX auto loading by searching for Startup Applications in the Cinnamon menu."

                # No Rush
                sleep 7200
            else
                # Rush Mixtape and Space Invaders
                sleep 10
            fi
        fi
    done
fi
