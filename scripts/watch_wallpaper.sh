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
        notify-send --urgency=normal --category=im.recieved --icon=help-info-symbolic "DermoDeX Color Extractor Active" "DermoDeX reloads Cinnamon with accent colors from the wallpaper image! DermoDeX is active for 15 minutes after launching, press CTRL+Alt+Esc to reload Cinnamon"

    else
        echo ""
        #notify-send --urgency=normal --category=im.recieved --icon=help-info-symbolic "DermoDeX Color Extractor Active" "DermoDeX reloads Cinnamon with accent colors from the wallpaper image! DermoDeX is active for 15 minutes after launching."
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
            TXT=$(cat $HOME/.local/share/dermodex/text_hover.txt)
            
            
            
            if [ "$PAS" != "$CUR" ]; then
                ACT="1"
                
                RES_PRIMARY=$(xrandr | grep -i "primary" | cut --delimiter=" " -f 4 | cut --delimiter="+" -f 1 | cut --delimiter="x" -f 2)
                
                RES_PRIMARY="$((RES_PRIMARY - 120))"
                
                echo $CUR > $HOME/.cache/dermodex/wallpaper_current.txt
                cp $HOME/.local/share/dermodex/cinnamon_base.css $HOME/.cache/dermodex/cinnamon.css
                
                python3 $HOME/.local/share/dermodex/colors.py
                
                COS=$(tail -n 3 $HOME/.cache/dermodex/colors_rgb.txt | head -1 | rev | cut -c2- | rev)
                COE=$(head -n 3 $HOME/.cache/dermodex/colors_rgb.txt | tail -1 | rev | cut -c2- | rev)
                HOS=$(tail -n 3 $HOME/.cache/dermodex/colors_hex.txt | head -1 | rev | cut -c1- | rev)
                HOE=$(head -n 3 $HOME/.cache/dermodex/colors_hex.txt | tail -1 | rev | cut -c1- | rev)
                
                MAINSHADE_RGB=$(head -n 1 $HOME/.cache/dermodex/colors_rgb.txt | tail -1 | rev | cut -c2- | rev)
                MAINSHADE_HEX=$(head -n 1 $HOME/.cache/dermodex/colors_hex.txt | tail -1 | rev | cut -c1- | rev)

                gsettings set org.cinnamon.desktop.background primary-color "${MAINSHADE_HEX}"
                gsettings set org.cinnamon.desktop.background secondary-color "${HOE}"
                gsettings set org.cinnamon.desktop.background color-shading-type "vertical"

                CONF_SLIDESHOW=$(gsettings get org.cinnamon.desktop.background.slideshow slideshow-enabled)
                CONF_SLIDETIME=$(gsettings get org.cinnamon.desktop.background.slideshow delay)
                CONF_ASPECT=$(gsettings get org.cinnamon.desktop.background picture-options)

                cp -f $HOME/.local/share/dermodex/common-assets/switch/switch-on.svg $HOME/.cache/dermodex/
                cp -f $HOME/.local/share/dermodex/common-assets/misc/close.svg $HOME/.cache/dermodex/
                cp -f $HOME/.local/share/dermodex/common-assets/misc/close-hover.svg $HOME/.cache/dermodex/
                cp -f $HOME/.local/share/dermodex/common-assets/misc/close-active.svg $HOME/.cache/dermodex/
                cp -f $HOME/.local/share/dermodex/common-assets/misc/calendar-arrow-left-hover.svg $HOME/.cache/dermodex/
                cp -f $HOME/.local/share/dermodex/common-assets/misc/calendar-arrow-right-hover.svg $HOME/.cache/dermodex/
                cp -f $HOME/.local/share/dermodex/common-assets/misc/corner-ripple.svg $HOME/.cache/dermodex/
                
                sed -i "s|fav-background-gradient-start: rgba(0,0,0|background-gradient-start: rgba${COS}|g" $HOME/.cache/dermodex/cinnamon.css
		        
                if n=$(grep -i "mainshade = true" $HOME/.local/share/dermodex/config.ini); then
                    echo "[i] Main Shade Active: When deactivated a lesser color may be chosen"
                    sed -i "s|#478db2|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/cinnamon.css
                    sed -i "s|#478db2|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/switch-on.svg
                    sed -i "s|#f70505|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/close.svg
                    sed -i "s|#f70505|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/close-hover.svg
                    sed -i "s|#f70505|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/close-active.svg
                    sed -i "s|#478db2|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/calendar-arrow-left-hover.svg
                    sed -i "s|#478db2|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/calendar-arrow-right-hover.svg
                    sed -i "s|#478db2|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/corner-ripple.svg
                    
                    sed -i "s|fav-background-gradient-end: rgba(0,0,0|background-gradient-end: rgba${MAINSHADE_RGB}|g" $HOME/.cache/dermodex/cinnamon.css
                else
                    sed -i "s|#478db2|${HOE}|g" $HOME/.cache/dermodex/cinnamon.css
                    sed -i "s|#478db2|${HOS}|g" $HOME/.cache/dermodex/switch-on.svg
                    sed -i "s|#f70505|${HOS}|g" $HOME/.cache/dermodex/close.svg
                    sed -i "s|#f70505|${HOS}|g" $HOME/.cache/dermodex/close-hover.svg
                    sed -i "s|#f70505|${HOS}|g" $HOME/.cache/dermodex/close-active.svg
                    sed -i "s|#478db2|${HOS}|g" $HOME/.cache/dermodex/calendar-arrow-left-hover.svg
                    sed -i "s|#478db2|${HOS}|g" $HOME/.cache/dermodex/calendar-arrow-right-hover.svg
                    sed -i "s|#478db2|${HOS}|g" $HOME/.cache/dermodex/corner-ripple.svg
                    
                    sed -i "s|fav-background-gradient-end: rgba(0,0,0|background-gradient-end: rgba${COE}|g" $HOME/.cache/dermodex/cinnamon.css

                fi
                
                sed -i "s|--panel-blur-background-position: 0px -0px;|background-position: 0px -${RES_PRIMARY}px;|g" $HOME/.cache/dermodex/cinnamon.css

                # Shake the Cinnamon over the Coffee
                cp $HOME/.cache/dermodex/cinnamon.css $HOME/.themes/DermoDeX/cinnamon
                
                cp -f $HOME/.cache/dermodex/switch-on.svg $HOME/.themes/DermoDeX/cinnamon/common-assets/switch
                cp -f $HOME/.cache/dermodex/close.svg $HOME/.themes/DermoDeX/cinnamon/common-assets/misc
                cp -f $HOME/.cache/dermodex/close-hover.svg $HOME/.themes/DermoDeX/cinnamon/common-assets/misc
                cp -f $HOME/.cache/dermodex/close-active.svg $HOME/.themes/DermoDeX/cinnamon/common-assets/misc
                cp -f $HOME/.cache/dermodex/calendar-arrow-left-hover.svg $HOME/.themes/DermoDeX/cinnamon/common-assets/misc
                cp -f $HOME/.cache/dermodex/calendar-arrow-right-hover.svg $HOME/.themes/DermoDeX/cinnamon/common-assets/misc
                cp -f $HOME/.cache/dermodex/corner-ripple.svg $HOME/.themes/DermoDeX/cinnamon/common-assets/misc
                
                # Give Possibility to change sounds based on wallpaper too
                # gsettings set org.cinnamon.sounds login-file /usr/share/sounds/linux-a11y/stereo/desktop-login.oga
                
                dex-notify.sh --action="Hold DermoDeX":$HOME/.local/bin/dd_hold --urgency=normal --category=transfer.complete --icon=cs-backgrounds-symbolic --hint=string:image-path:$HOME/.cache/dermodex/wallpaper_swatch.png "DermoDeX Recalculating Accent Colors!" "\nWait for Cinnamon to reload or manually reload with CTRL+Alt+Esc.\n\nfile://${HOME}/.cache/dermodex/wallpaper_swatch.png"

                echo "[i] Updating Accent Colors ..."
                if ! type "xdotool" > /dev/null 2>&1; then
                    echo "[i] Hot Keys not installed run sudo apt get install xdotool"
                    dex-notify.sh --action="Open Terminal":gnome-terminal --urgency=normal --category=im.receieved --icon=help-info-symbolic "Hot Keys Tool not installed ..." "Run 'sudo apt install xdotool' to automate reloading Cinnamon"
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
                CUR_WALL=$(gsettings get org.cinnamon.desktop.background picture-uri)
                
                #dex-notify.sh --action="Wake DermoDeX":$HOME/.local/bin/dd_wake --urgency=normal --category=im.receieved --icon=help-info-symbolic "DermoDex is currently resting." "Changing your wallpaper at the moment will take a while or reboot to reflect in your accent colors. Wake up DermoDeX with the dd_wake command. Your current wallpaper is located at: ${CUR_WALL}"

                # No Rush
                sleep 7200
            else
                # Rush Mixtape and Space Invaders
                sleep 2
            fi
        fi
    done
fi
