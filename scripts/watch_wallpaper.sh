#!/usr/bin/env bash
BASE_FILE="$HOME/.local/share/dermodex"
CACHE_DIR="$HOME/.cache/dermodex"
HOLD_FILE="$HOME/.cache/dermodex_hold"
CONF_FILE="$HOME/.local/share/dermodex/config.ini"
CINN_FILE="$HOME/.cache/dermodex/cinnamon.css"

CCA="$HOME/.cache/dermodex/common-assets/cinnamon/assets"
TCD="$HOME/.themes/DermoDeX"

check_install() {
    CINN_VERSION=$(cinnamon --version)
    if awk "BEGIN {exit !($CINN_VERSION < 5.2)}"; then
        echo "[i] ERROR: Cinnamon version too low, this script was designed for Cinnamon 5.2 and above"
        exit
    fi
    
    if [ -d "$BASE_FILE" ]; then
        echo ""
    else
        echo "[i] Error: .local Directory Missing for DermoDeX. Please re-install DermoDeX."
        notify-send --urgency=normal --category=transfer.complete --icon=cs-backgrounds-symbolic "DermoDeX Error" ".local Directory Missing for DermoDeX. Please re-install DermoDeX."
        
        rm -f $HOME/.local/share/nemo/actions/dd-*
        
        PID=$(ps aux | grep -i "watch_wallpaper.sh" | head -1 | awk '{print $2}')
        kill $PID >/dev/null 2>&1
    fi

    if [ -d "$CACHE_DIR" ]; then
        echo ""
    else
        echo "[i] Error: .cache Directory Missing for DermoDeX. Please re-install DermoDeX."
        notify-send --urgency=normal --category=transfer.complete --icon=cs-backgrounds-symbolic "DermoDeX Error" ".cache Directory Missing for DermoDeX. Please re-install DermoDeX."
        
        rm -f $HOME/.local/share/nemo/actions/dd-*
        
        PID=$(ps aux | grep -i "watch_wallpaper.sh" | head -1 | awk '{print $2}')
        kill $PID >/dev/null 2>&1
    fi
}


if [ -f "$HOLD_FILE" ]; then
    ACT="0"
    check_install
else
    check_install
    
    mkdir -p $HOME/.cache/dermodex
    touch $HOME/.cache/dermodex/wallpaper.jpg
    touch $HOME/.cache/dermodex/wallpaper_swatch.png
    touch $HOME/.cache/dermodex/resize_wallpaper.jpg
    touch $HOME/.cache/wallpaper_current.txt
    touch $HOME/.cache/dermodex/bg.png

    while true
    do
        if [ -f "$HOLD_FILE" ]; then
            # Hold DermoDeX from acting upon wallpaper changes
            ACT="0"
            check_install
        else
            check_install
            
            # LET DermoDeX DO
            CUR=$(gsettings get org.cinnamon.desktop.background picture-uri)
            PAS=$(cat $HOME/.cache/wallpaper_current.txt)
            
            
            
            if [ "$PAS" != "$CUR" ]; then
                ACT="1"
                
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
                
                
                RES_PRIMARY=$(xrandr | grep -i "primary" | cut --delimiter=" " -f 4 | cut --delimiter="+" -f 1 | cut --delimiter="x" -f 2)
                
                RES_PRIMARY="$((RES_PRIMARY - 120))"
                
                echo $CUR > $HOME/.cache/wallpaper_current.txt
                
                gsettings set org.cinnamon.desktop.background primary-color "${MAINSHADE_HEX}"
                gsettings set org.cinnamon.desktop.background secondary-color "${HEX1}"
                gsettings set org.cinnamon.desktop.background color-shading-type "vertical"

                CONF_SLIDESHOW=$(gsettings get org.cinnamon.desktop.background.slideshow slideshow-enabled)
                CONF_SLIDETIME=$(gsettings get org.cinnamon.desktop.background.slideshow delay)
                CONF_ASPECT=$(gsettings get org.cinnamon.desktop.background picture-options)
                
                
                # GENERATE THE COLORS AND UPDATE THE CONFIG
                if [ "$CONF_SLIDESHOW" = "false" ]; then
                    # DONT EXTRACT WALLPAPER COLORS IF COLORS ARE BEING OVERRIDEN
                    if [ "$coloroverrides" == "false" ]; then
                        
                        notify-send --urgency=normal --category=transfer.complete --icon=cs-backgrounds-symbolic "DermoDeX Recalculating Accent Colors!" "Please standby for your new desktop experience!"
                        
                        python3 $HOME/.local/share/dermodex/colors.py
                        
                        dd_swatch&
                        
                        notify-send --urgency=normal --category=transfer.complete --icon=cs-backgrounds-symbolic "DermoDeX Showing You What It Sees!" "Cinnamon will soon reload with the newly mixed theme ..."
                        
                        sleep 1
                        
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
                    
                    else
                        notify-send --urgency=normal --category=transfer.complete --icon=cs-backgrounds-symbolic "DermoDeX Recalculating Accent Colors!" "Using color overrides from configuration settings ... Wait for Cinnamon to reload or manually reload with CTRL+Alt+Esc."
                    
                    fi
                fi
                
                
                # RECOMBINE STORED DATA FROM CONFIG FILE
                HEX1="#${savehex1}"
                HEX2="#${savehex2}"
                HEX3="#${savehex3}"
                MAINSHADE_HEX="#${savehex0}"
                
                RGB1="(${savergb1}"
                RGB2="(${savergb2}"
                MAINSHADE_RGB="(${savergb0}"
                
                OVR0="#${override0}"
                OVR1="#${override1}"
                OVR2="#${override2}"
                OVR3="#${override3}"
                
                # REMIX THEMES AND ICONS ONLY IF SLIDESHOW NOT ACTIVE
                if [ "$CONF_SLIDESHOW" = "false" ]; then
                    $BASE_FILE/remix_themes.sh "${HEX1}"

                    # RECOLOR NEMO FOLDERS AND EMBLEMS
                    if [ "$flowicons" == "true" ]; then
                        if [ "$coloroverrides" == "true" ]; then
                            $BASE_FILE/remix_icons.sh "${OVR3}"
                        else
                            $BASE_FILE/remix_icons.sh "${HEX1}"
                        fi
                    fi
                fi
                
                # Give Possibility to change sounds based on wallpaper too
                # gsettings set org.cinnamon.sounds login-file /usr/share/sounds/linux-a11y/stereo/desktop-login.oga
                
                
                
                if [ "$CONF_SLIDESHOW" = "false" ]; then
                    echo "[i] Updating Accent Colors ..."
                    if ! type "xdotool" > /dev/null 2>&1; then
                        echo "[i] Hot Keys not installed run sudo apt get install xdotool"
                    else
                        if [ "$(find $HOME/.cache/wallpaper_current.txt -mmin +15)" != "" ]
                            echo "[i] DermoDeX Active"
                        then
                            cinnamon_reload
                        fi
                    fi
                fi
                

                # REFRESH GTK THEME
                #gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y-Dark-Aqua"
                gsettings set org.cinnamon.desktop.interface gtk-theme "DermoDeX"

                # SET SOUNDS
                $BASE_FILE/watch_sounds.sh
                
                rm -f $BASE_FILE/config.ini.unix
                
                # SET GTK ASSETS
                if [ "$flowcolors" = true ]; then
                    if [ "$coloroverrides" == "true" ] && [ "$overridegtk" != "ffffff" ]; then
                        GTK0=$($HOME/.local/share/dermodex/remix_color.py -c "${overridegtk}" -f 1 --mode="hex")
                        GTK0_BRIGHT=$($HOME/.local/share/dermodex/remix_color.py -c "${overridegtk}" -f 1.3 --mode="hex")
                        GTK0_DARK=$($HOME/.local/share/dermodex/remix_color.py -c "${overridegtk}" -f 0.7 --mode="hex")
                    else
                        GTK0=$($HOME/.local/share/dermodex/remix_color.py -c "${savegtk0}" -f 1 --mode="hex")
                        GTK0_BRIGHT=$($HOME/.local/share/dermodex/remix_color.py -c "${savegtk0}" -f 1.3 --mode="hex")
                        GTK0_DARK=$($HOME/.local/share/dermodex/remix_color.py -c "${savegtk0}" -f 0.7 --mode="hex")
                    fi
                    
                    echo "[i] GTK Color: $GTK0"
                    $BASE_FILE/theme-ext/gtk/remix_assets.sh "$GTK0"
                fi
                

            else
                ACT="0"
            fi

            # Letting The Cables Sleep
            if [ "$(find $HOME/.cache/wallpaper_current.txt -mmin +15)" != "" ]
            then
                echo "[i] DermoDex Color Extractor Less Active"
                CUR_WALL=$(gsettings get org.cinnamon.desktop.background picture-uri)
                
                #dex-notify.sh --action="Wake DermoDeX":$HOME/.local/bin/dd_wake --urgency=normal --category=im.receieved --icon=help-info-symbolic "DermoDex is currently resting." "Changing your wallpaper at the moment will take a while or reboot to reflect in your accent colors. Wake up DermoDeX with the dd_wake command. Your current wallpaper is located at: ${CUR_WALL}"

                # No Rush All Bush
                sleep 7200
            else
                # No Bush All Rush - Mixtape and Space Invaders
                sleep 1
            fi
        fi
    done
fi
# Kate Bush