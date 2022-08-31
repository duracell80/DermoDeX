#!/usr/bin/env bash
BASE_FILE="$HOME/.local/share/dermodex"
HOLD_FILE="$HOME/.local/share/dermodex/dermodex_hold"
CONF_FILE="$HOME/.local/share/dermodex/config.ini"
CINN_FILE="$HOME/.cache/dermodex/cinnamon.css"

CCA="$HOME/.cache/dermodex/common-assets/cinnamon/assets"
TCD="$HOME/.themes/DermoDeX"

# soundnotification="theme"
#if [ "$soundnotification" == "theme" ]; then
    #$BASE_FILE/watch_sounds.sh
#fi

if [ -f "$HOLD_FILE" ]; then
    ACT="0"
else
    mkdir -p $HOME/.cache/dermodex
    touch $HOME/.cache/dermodex/wallpaper.jpg
    touch $HOME/.cache/dermodex/wallpaper_swatch.png
    touch $HOME/.cache/dermodex/resize_wallpaper.jpg
    touch $HOME/.cache/dermodex/wallpaper_current.txt
    touch $HOME/.cache/dermodex/bg.png

    while true
    do
        if [ -f "$HOLD_FILE" ]; then
            # Hold DermoDeX from acting upon wallpaper changes
            ACT="0"
        else
            # LET DermoDeX DO
            CUR=$(gsettings get org.cinnamon.desktop.background picture-uri)
            PAS=$(cat $HOME/.cache/dermodex/wallpaper_current.txt)
            #TXT=$(cat $HOME/.local/share/dermodex/text_hover.txt)
            
            
            
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
                
                echo $CUR > $HOME/.cache/dermodex/wallpaper_current.txt
                
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
                        
                        #notify-send --urgency=normal --category=transfer.complete --icon=cs-backgrounds-symbolic --hint=string:image-path:$HOME/.cache/dermodex/wallpaper_swatch.png "DermoDeX Recalculating Accent Colors!" "\nWait for Cinnamon to reload or manually reload with CTRL+Alt+Esc.\n\nfile://${HOME}/.cache/dermodex/wallpaper_swatch.png"
                        
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
                        notify-send --urgency=normal --category=transfer.complete --icon=cs-backgrounds-symbolic "DermoDeX Recalculating Accent Colors!" "Using the solor overrides from the configuration settings ... Wait for Cinnamon to reload or manually reload with CTRL+Alt+Esc."
                    
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
                        if [ "$(find $HOME/.cache/dermodex/wallpaper_current.txt -mmin +15)" != "" ]
                            echo "[i] DermoDeX Active"
                        then
                            #sleep 2
                            
                            cinnamon_reload
                            #xdotool key ctrl+alt+"Escape"
                            #xdotool key alt+"F2"
                            #xdotool key r
                            #xdotool key enter
                            #fi
                        fi
                    fi
                fi

                # REFRESH GTK THEME
                #gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y-Dark-Aqua"
                #gsettings set org.cinnamon.desktop.interface gtk-theme "DermoDeX"

                # SET SOUNDS
                if [ "$soundtheme" == "zorin" ]; then
                    # SOUND - Zorin
                    gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/zorin/stereo/button-pressed.ogg'
                    gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/zorin/stereo/device-added.oga'
                    gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/zorin/stereo/device-removed.oga'
                    gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/zorin/stereo/message.ogg'
                    gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/zorin/stereo/message.ogg'
                    gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/zorin/stereo/button-toggle-off.ogg'
                    gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/zorin/stereo/desktop-login.ogg'
                    gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/zorin/stereo/button-toggle-on.ogg'
                    gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/zorin/stereo/window-slide.ogg'
                    if [ "$soundnotification" == "theme" ]; then
                        gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/zorin/stereo/message-new-instant.ogg'
                    fi
                    gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/zorin/stereo/button-toggle-off.ogg'
                    gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/zorin/stereo/desktop-logout.ogg'
                
                elif [ "$soundtheme" == "macos" ]; then
                    # SOUND - MACOS
                    gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/macos/restore-up.ogg'
                    gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/macos/device-connect.ogg'
                    gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/macos/device-disconnect.ogg'
                    gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/macos/open.ogg'
                    gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/macos/close.ogg'
                    gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/macos/minimize.ogg'
                    gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/macos/logoff.ogg'
                    gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/macos/maximize.ogg'
                    gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/macos/close.ogg'
                    if [ "$soundnotification" == "theme" ]; then
                        gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/macos/contact-online.ogg'
                    fi
                    gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/macos/restore-down.ogg'
                    gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/macos/logon.ogg'
                    
                elif [ "$soundtheme" == "mint20" ]; then
                    # SOUND - MINT20
                    gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/LinuxMint/stereo/button-toggle-on.ogg'
                    gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/LinuxMint/stereo/dialog-information.ogg'
                    gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/LinuxMint/stereo/dialog-question.ogg'
                    gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/LinuxMint/stereo/button-toggle-on.ogg'
                    gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/LinuxMint/stereo/button-toggle-on.ogg'
                    gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/LinuxMint/stereo/button-toggle-on.ogg'
                    gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/LinuxMint/stereo/desktop-logout.ogg'
                    gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/LinuxMint/stereo/button-toggle-on.ogg'
                    gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/LinuxMint/stereo/window-slide.ogg'
                    if [ "$soundnotification" == "theme" ]; then
                        gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/LinuxMint/stereo/system-ready.ogg'
                    fi
                    gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/LinuxMint/stereo/button-toggle-on.ogg'
                    gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/LinuxMint/stereo/desktop-login.ogg'
                
                elif [ "$soundtheme" == "x11" ]; then
                    # SOUND - x11
                    gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/x11/stereo/system-ready.ogg'
                    gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/x11/stereo/device-added.ogg'
                    gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/x11/stereo/device-removed.ogg'
                    gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/x11/stereo/camera-shutter.ogg'
                    gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/x11/stereo/camera-shutter.ogg'
                    gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/x11/stereo/camera-shutter.ogg'
                    gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/x11/stereo/desktop-login.ogg'
                    gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/x11/stereo/camera-shutter.ogg'
                    gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/x11/stereo/camera-shutter.ogg'
                    if [ "$soundnotification" == "theme" ]; then
                        gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/x11/stereo/message-new-instant.ogg'
                    fi
                    gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/x11/stereo/camera-shutter.ogg'
                    gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/x11/stereo/complete.ogg'
                    
                elif [ "$soundtheme" == "x10" ]; then
                    # SOUND - x10
                    gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/x10/feed-discovered.ogg'
                    gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/x10/hardware-insert.ogg'
                    gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/x10/hardware-remove.ogg'
                    gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/x10/battery-low.ogg'
                    gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/x10/print-complete.ogg'
                    gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/x10/minimize.ogg'
                    gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/x10/linux-shutdown.ogg'
                    gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/x10/minimize.ogg'
                    gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/x10/navigation -start.ogg'
                    if [ "$soundnotification" == "theme" ]; then
                        gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/x10/notify-system-generic.ogg'
                    fi
                    gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/x10/minimize.ogg'
                    gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/x10/logon.ogg'
                    
                elif [ "$soundtheme" == "xxp" ]; then
                    # SOUND - xxp
                    gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/xxp/ding.ogg'
                    gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/xxp/logon.ogg'
                    gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/xxp/logoff.ogg'
                    gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/xxp/menu-command.ogg'
                    gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/xxp/open-program.ogg'
                    gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/xxp/maximize.ogg'
                    gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/xxp/shutdown.ogg'
                    gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/xxp/maximize.ogg'
                    gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/xxp/menu-popup.ogg'
                    if [ "$soundnotification" == "theme" ]; then
                        gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/xxp/notify.ogg'
                    fi
                    gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/xxp/restore.ogg'
                    gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/xxp/start-linux.ogg'
                
                elif [ "$soundtheme" == "miui" ]; then
                    # SOUND - MiUi
                    gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/miui/stereo/dialog-information.ogg'
                    gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/miui/stereo/power-plug.ogg'
                    gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/miui/stereo/power-unplug.ogg'
                    gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/miui/stereo/window-close.ogg'
                    gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/miui/stereo/window-close.ogg'
                    gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/miui/stereo/window-close.ogg'
                    gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/miui/stereo/device-removed.ogg'
                    gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/miui/stereo/window-close.ogg'
                    gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/miui/stereo/count-down.ogg'
                    if [ "$soundnotification" == "theme" ]; then
                        gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/miui/stereo/message-sent-instant.ogg'
                    fi
                    gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/miui/stereo/window-close.ogg'
                    gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/miui/stereo/device-added.ogg'
                    
                elif [ "$soundtheme" == "deepin" ]; then
                    # SOUND - deepin
                    gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/deepin/dialog-error-critical.ogg'
                    gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/deepin/device-added.ogg'
                    gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/deepin/device-removed.ogg'
                    gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/deepin/power-unplug.ogg'
                    gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/deepin/audio-volume-change.ogg'
                    gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/deepin/dialog-error-serious.ogg'
                    gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/deepin/system-shutdown.ogg'
                    gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/deepin/dialog-error-serious.ogg'
                    gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/deepin/audio-volume-change.ogg'
                    if [ "$soundnotification" == "theme" ]; then
                        gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/deepin/suspend-resume.ogg'
                    fi
                    gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/deepin/dialog-error-serious.ogg'
                    gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/deepin/desktop-login.ogg'
                    
                elif [ "$soundtheme" == "enchanted" ]; then
                    # SOUND - enchanted
                    gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/enchanted/bell.ogg'
                    gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/enchanted/dialog-question.ogg'
                    gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/enchanted/dialog-error.ogg'
                    gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/enchanted/button-released.ogg'
                    gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/enchanted/menu-replace.ogg'
                    gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/enchanted/window-minimized.ogg'
                    gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/enchanted/button-toggle-on.ogg'
                    gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/enchanted/window-maximized.ogg'
                    gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/enchanted/window-switch.ogg'
                    if [ "$soundnotification" == "theme" ]; then
                        gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/enchanted/message-sent-instant.ogg'
                    fi
                    gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/enchanted/window-unmaximized.ogg'
                    gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/enchanted/system-ready.ogg'
                    
                elif [ "$soundtheme" == "borealis" ]; then
                    # SOUND - borealis
                    gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/enchanted/window-unmaximized.ogg'
                    gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/enchanted/dialog-question.ogg'
                    gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/enchanted/dialog-error.ogg'
                    gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/enchanted/button-released.ogg'
                    gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/enchanted/dialog-question.ogg'
                    gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/enchanted/window-minimized.ogg'
                    gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/borealis/exit1_2.ogg'
                    gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/enchanted/window-minimized.ogg'
                    gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/enchanted/notebook-tab-changed.ogg'
                    if [ "$soundnotification" == "theme" ]; then
                        gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/borealis/notification.ogg'
                    fi
                    gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/enchanted/window-unmaximized.ogg'
                    gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/borealis/startup1_2.ogg'
                
                elif [ "$soundtheme" == "harmony" ]; then
                    gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/harmony/restore.ogg'
                    gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/harmony/network-added.ogg'
                    gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/harmony/network-removed.ogg'
                    gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/harmony/dialog-information.oga'
                    gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/harmony/dialog-question.oga'
                    gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/harmony/window-new.oga'
                    gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/harmony/desktop-logout.oga'
                    gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/harmony/window-new.oga'
                    gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/harmony/window-new.oga'
                    if [ "$soundnotification" == "theme" ]; then
                        gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/harmony/notification-brighter.ogg'
                    fi
                    gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/harmony/window-new.oga'
                    gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/harmony/desktop-login.oga'
                
                elif [ "$soundtheme" == "ubuntu-original" ]; then
                    # SOUND - LINUX-UBUNTU
                    gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/linux-ubuntu/question.ogg'
                    gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/linux-ubuntu/disconnect.ogg'
                    gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/linux-ubuntu/connect.ogg'
                    gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/linux-ubuntu/default.ogg'
                    gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/linux-ubuntu/default.ogg'
                    gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/linux-ubuntu/menu-popup.ogg'
                    gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/linux-a11y/stereo/desktop-logout.oga'
                    gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/linux-ubuntu/menu-popup.ogg'
                    gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/linux-ubuntu/default.ogg'
                    if [ "$soundnotification" == "theme" ]; then
                        gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/linux-ubuntu/new-mail.ogg'
                    fi
                    gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/linux-ubuntu/menu-popup.ogg'
                    gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/linux-a11y/stereo/desktop-login.oga'
                
                elif [ "$soundtheme" == "nightlynews" ]; then
                    # SOUND - NIGHTLYNEWS
                    gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/nightlynews/click.ogg'
                    gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/nightlynews/login.ogg'
                    gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/nightlynews/logout.ogg'
                    gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/nightlynews/click.ogg'
                    gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/nightlynews/click.ogg'
                    gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/nightlynews/click.ogg'
                    if [ "$soundnotification" == "theme" ]; then
                        gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/nightlynews/chimes.ogg'
                    fi
                    gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/nightlynews/click.ogg'
                    gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/linux-a11y/stereo/window-new.oga'
                    gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/nightlynews/click.ogg'
                    gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/nightlynews/click.ogg'
                    gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/nightlynews/click.ogg'
                    
                elif [ "$soundtheme" == "teampixel" ]; then
                    # SOUND - TEAM PIXEL - GOOGLE
                    gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/teampixel/navigation_backward-selection.ogg'
                    gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/teampixel/notifications/Classical Harmonies/Spring Strings.ogg'
                    gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/teampixel/Asteroid.ogg'
                    gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/teampixel/ui_loading.ogg'
                    gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/teampixel/navigation-cancel.ogg'
                    gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/teampixel/navigation-cancel.ogg'
                    if [ "$soundnotification" == "theme" ]; then
                        gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notification_simple-01.ogg'
                    fi
                    gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/teampixel/state-change_confirm-up.ogg'
                    gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/teampixel/navigation_transition-right.ogg'
                    gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/teampixel/navigation_unavailable-selection.ogg'
                    gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/teampixel/navigation_transition-left.ogg'
                    gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/teampixel/state-change_confirm-down.ogg'
                else
                
                
                    # SOUND - Linux-A11y
                    gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/linux-a11y/stereo/window-switch.oga'
                    gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/linux-a11y/stereo/message-sent.oga'
                    gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/linux-a11y/stereo/message.oga'
                    gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/linux-a11y/stereo/tooltip-popup.oga'
                    gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/linux-a11y/stereo/tooltip-popup.oga'
                    gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/linux-a11y/stereo/window-minimized.oga'
                    gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/linux-a11y/stereo/desktop-logout.oga'
                    gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/linux-a11y/stereo/window-minimized.oga'
                    gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/linux-a11y/stereo/menu-popup.oga'
                    if [ "$soundnotification" == "theme" ]; then
                        gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/linux-a11y/stereo/window-attention.oga'
                    fi
                    gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/linux-a11y/stereo/window-minimized.oga'
                    gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/linux-a11y/stereo/desktop-login.oga'
                fi
                
                
                

            else
                ACT="0"
            fi

            # Letting The Cables Sleep
            if [ "$(find $HOME/.cache/dermodex/wallpaper_current.txt -mmin +15)" != "" ]
            then
                echo "[i] DermoDex Color Extractor Less Active"
                CUR_WALL=$(gsettings get org.cinnamon.desktop.background picture-uri)
                
                #dex-notify.sh --action="Wake DermoDeX":$HOME/.local/bin/dd_wake --urgency=normal --category=im.receieved --icon=help-info-symbolic "DermoDex is currently resting." "Changing your wallpaper at the moment will take a while or reboot to reflect in your accent colors. Wake up DermoDeX with the dd_wake command. Your current wallpaper is located at: ${CUR_WALL}"

                # No Rush All Bush
                sleep 7200
            else
                # Mixtape and Space Invaders
                sleep 1
            fi
        fi
    done
fi
