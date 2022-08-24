#!/usr/bin/env bash
BASE_FILE="$HOME/.local/share/dermodex"
HOLD_FILE="$HOME/.local/share/dermodex/dermodex_hold"
CONF_FILE="$HOME/.local/share/dermodex/config.ini"
CINN_FILE="$HOME/.cache/dermodex/cinnamon.css"


$BASE_FILE/watch_sounds.sh

mkdir -p $HOME/.cache/dermodex/common-assets/icons/emblems
mkdir -p $HOME/.cache/dermodex/common-assets/icons/places

if [ -f "$HOLD_FILE" ]; then
    ACT="0"
else
    mkdir -p $HOME/.cache/dermodex
    touch $HOME/.cache/dermodex/wallpaper.jpg
    touch $HOME/.cache/dermodex/wallpaper_swatch.png
    touch $HOME/.cache/dermodex/resize_wallpaper.jpg
    touch $HOME/.cache/dermodex/wallpaper_current.txt
    touch $HOME/.cache/dermodex/bg.png
    #touch $HOME/.cache/dermodex/colors_hex.txt
    #touch $HOME/.cache/dermodex/colors_rgb.txt
    

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
            # LET DermoDeX DO
            CUR=$(gsettings get org.cinnamon.desktop.background picture-uri)
            PAS=$(cat $HOME/.cache/dermodex/wallpaper_current.txt)
            TXT=$(cat $HOME/.local/share/dermodex/text_hover.txt)
            
            
            
            if [ "$PAS" != "$CUR" ]; then
                ACT="1"
                
                RES_PRIMARY=$(xrandr | grep -i "primary" | cut --delimiter=" " -f 4 | cut --delimiter="+" -f 1 | cut --delimiter="x" -f 2)
                
                RES_PRIMARY="$((RES_PRIMARY - 120))"
                
                echo $CUR > $HOME/.cache/dermodex/wallpaper_current.txt
                cp $HOME/.local/share/dermodex/cinnamon_base.css $CINN_FILE
                
                #mkdir -p $HOME/.cache/dermodex/gtk-3.0
                #mkdir -p $HOME/.cache/dermodex/gtk-3.20/dist
                
                #cp $HOME/.local/share/dermodex/gtk-3.0/colors.css $HOME/.cache/dermodex/gtk-3.0
                #cp $HOME/.local/share/dermodex/gtk-3.20/gtk.gresource $HOME/.cache/dermodex/gtk-3.20
                #cp $HOME/.local/share/dermodex/gtk-3.20/dist/gtk.css $HOME/.cache/dermodex/gtk-3.20/dist/
                
                # GENERATE THE COLORS AND UPDATE THE CONFIG
                python3 $HOME/.local/share/dermodex/colors.py
                
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

                echo "[i] Sound Theme: ${soundtheme}"
                
                #COS=$(tail -n 3 $HOME/.cache/dermodex/colors_rgb.txt | head -1 | rev | cut -c2- | rev)
                #COE=$(head -n 3 $HOME/.cache/dermodex/colors_rgb.txt | tail -1 | rev | cut -c2- | rev)
                #HOS=$(tail -n 3 $HOME/.cache/dermodex/colors_hex.txt | head -1 | rev | cut -c1- | rev)
                #HOE=$(head -n 3 $HOME/.cache/dermodex/colors_hex.txt | tail -1 | rev | cut -c1- | rev)

                
                # RECOMBINE STORED DATA FROM CONFIG FILE
                HOS="#${savehex2}"
                HOE="#${savehex1}"
                MAINSHADE_HEX="#${savehex0}"
                
                COS="(${savergb2}"
                COE="(${savergb1}"
                MAINSHADE_RGB="(${savergb0}"
                
                
                #MAINSHADE_RGB=$(head -n 1 $HOME/.cache/dermodex/colors_rgb.txt | tail -1 | rev | cut -c2- | rev)
                #MAINSHADE_HEX=$(head -n 1 $HOME/.cache/dermodex/colors_hex.txt | tail -1 | rev | cut -c1- | rev)


                gsettings set org.cinnamon.desktop.background primary-color "${MAINSHADE_HEX}"
                gsettings set org.cinnamon.desktop.background secondary-color "${HOE}"
                gsettings set org.cinnamon.desktop.background color-shading-type "vertical"

                CONF_SLIDESHOW=$(gsettings get org.cinnamon.desktop.background.slideshow slideshow-enabled)
                CONF_SLIDETIME=$(gsettings get org.cinnamon.desktop.background.slideshow delay)
                CONF_ASPECT=$(gsettings get org.cinnamon.desktop.background picture-options)

                cp -f $HOME/.local/share/dermodex/common-assets/switch/*.svg $HOME/.cache/dermodex/
                cp -f $HOME/.local/share/dermodex/common-assets/misc/*.svg $HOME/.cache/dermodex/
                
                #cp -f $HOME/.local/share/dermodex/gtk-3.0/assets/*.svg $HOME/.cache/dermodex/gtk-3.0
                cp -f $HOME/.local/share/dermodex/icons/breeze-dark_white/emblems/*.svg $HOME/.cache/dermodex/common-assets/icons/emblems
                
                cp -f $HOME/.local/share/dermodex/icons/breeze-dark_white/places/*.svg $HOME/.cache/dermodex/common-assets/icons/places
                
                

                if [ "$mainshade" = true ]; then
                    echo "[i] Main Shade Active: When deactivated a lesser color may be chosen"
                    sed -i "s|#478db2|${MAINSHADE_HEX}|g" $CINN_FILE
                    sed -i "s|#478db2|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/switch-on.svg
                    sed -i "s|#f70505|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/close.svg
                    sed -i "s|#f70505|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/close-hover.svg
                    sed -i "s|#f70505|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/close-active.svg
                    sed -i "s|#478db2|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/calendar-arrow-left-hover.svg
                    sed -i "s|#478db2|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/calendar-arrow-right-hover.svg
                    sed -i "s|#478db2|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/corner-ripple.svg
                    sed -i "s|#478db2|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/grouped-window-dot-active.svg
                    sed -i "s|#478db2|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/grouped-window-dot-hover.svg
                    
                    #sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/checkbox-checked.svg
                    #sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/checkbox-checked-dark.svg
                    #sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/checkbox-mixed.svg
                    #sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/checkbox-mixed-dark.svg
                    #sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/grid-selection-checked.svg
                    #sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/grid-selection-checked-dark.svg
                    #sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/menuitem-checkbox-checked.svg
                    #sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/menuitem-checkbox-mixed-selected.svg
                    #sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/menuitem-radio-checked.svg
                    #sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/menuitem-radio-mixed-selected.svg
                    #sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/radio-checked.svg
                    #sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/radio-checked-dark.svg
                    #sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/radio-mixed.svg
                    #sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/radio-mixed-dark.svg
                    #sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/radio-selected.svg
                    
                    sed -i "s|fav-background-gradient-end: rgba(0,0,0|background-gradient-end: rgba${MAINSHADE_RGB}|g" $CINN_FILE
                    
                    for filename in $HOME/.cache/dermodex/common-assets/icons/emblems/*.svg; do
                        [ -e "$filename" ] || continue
                        sed -i "s|#ffaa00|${HOS}|g" $filename
                    done
                    
                    
                    for filename in $HOME/.cache/dermodex/common-assets/icons/places/*.svg; do
                        [ -e "$filename" ] || continue
                        #sed -i "s|#ffffff|${HOE}|g" $filename
                        #sed -i "s|#fff|${HOS}|g" $filename
                        sed -i "s|#707073|${MAINSHADE_HEX}|g" $filename
                    done
                else
                    if [ "$flowcolors" = true ]; then
                        sed -i "s|#478db2|${HOS}|g" $CINN_FILE
                    else
                        sed -i "s|#478db2|${HOE}|g" $CINN_FILE
                    fi
                    
                    sed -i "s|#478db2|${HOS}|g" $HOME/.cache/dermodex/switch-on.svg
                    sed -i "s|#f70505|${HOS}|g" $HOME/.cache/dermodex/close.svg
                    sed -i "s|#f70505|${HOS}|g" $HOME/.cache/dermodex/close-hover.svg
                    sed -i "s|#f70505|${HOS}|g" $HOME/.cache/dermodex/close-active.svg
                    sed -i "s|#478db2|${HOS}|g" $HOME/.cache/dermodex/calendar-arrow-left-hover.svg
                    sed -i "s|#478db2|${HOS}|g" $HOME/.cache/dermodex/calendar-arrow-right-hover.svg
                    sed -i "s|#478db2|${HOS}|g" $HOME/.cache/dermodex/corner-ripple.svg
                    sed -i "s|#478db2|${HOE}|g" $HOME/.cache/dermodex/grouped-window-dot-active.svg
                    sed -i "s|#478db2|${HOE}|g" $HOME/.cache/dermodex/grouped-window-dot-hover.svg
                    
                    
                    # RECOLOR GTK ICONS
                    #for filename in $HOME/.cache/dermodex/gtk-3.0/*.svg; do
                        #[ -e "$filename" ] || continue
                        #sed -i "s|#647891|${HOS}|g" $filename
                    #done
                    
                    
                    # RECOLOR NEMO EMBLEMS
                    for filename in $HOME/.cache/dermodex/common-assets/icons/emblems/*.svg; do
                        [ -e "$filename" ] || continue
                        sed -i "s|#ffaa00|${HOS}|g" $filename
                    done
                    
                    # RECOLOR NEMO PLACES ICONS
                    for filename in $HOME/.cache/dermodex/common-assets/icons/places/*.svg; do
                        [ -e "$filename" ] || continue
                        #sed -i "s|#ffffff|${HOE}|g" $filename
                        #sed -i "s|#fff|${HOS}|g" $filename
                        sed -i "s|#707073|${HOE}|g" $filename
                    done
              

                fi
                
                # SET FAVORTIES BAR GRADIENT
                sed -i "s|fav-background-gradient-start: rgba(0,0,0|background-gradient-start: rgba${COS}|g" $CINN_FILE
                sed -i "s|fav-background-gradient-end: rgba(0,0,0|background-gradient-end: rgba${COE}|g" $CINN_FILE
                
                # SHOW AVATAR ON START MENU OR NOT
                if [ "$menuavatar" = true ]; then
                    sed -i "s|background-image: url(~/.face);|background-image: url(${HOME}/.face);|g" $CINN_FILE
                else
                    sed -i "s|background-image: url(~/.face);|background-image: url(none);|g" $CINN_FILE
                fi
                
                # BLUR COPY OF WALLPAPER ON START MENU OR NOT
                if [ "$menubckgrd" = "true" ]; then
                    sed -i "s|--menu-background-image : url(~/.local/share/dermodex/menu_blur.jpg);|background-image : url($HOME/.local/share/dermodex/menu_blur.jpg);|g" $CINN_FILE
                    
                    sed -i "s|--menu-background-color: rgba(64, 64, 64, 0.95);|background-color: rgba(64, 64, 64, 0.95);|g" $CINN_FILE
                else 
                    sed -i "s|--menu-background-image : url(~/.local/share/dermodex/menu_blur.jpg);|background-image : url();|g" $CINN_FILE
                    
                    sed -i "s|--menu-background-color: rgba(64, 64, 64, 0.95);|background-color: rgba(64, 64, 64, ${menutrans});|g" $CINN_FILE

                fi
                
                
                # INNER PANEL STYLE
                if [ "$panelstyle" = "flat" ]; then
                    echo "[i] Panel Style: Flat"
                    sed -i "s|--panel-border-radius : 32px;|border-radius : 0px;|g" $CINN_FILE
                    sed -i "s|--panel-background-color : transparent;|background-color : rgba(64, 64, 64, $paneltrans);|g" $CINN_FILE
                    sed -i "s|--panel-inner-background-color : rgba(64, 64, 64, 0.9);|background-color : transparent;|g" $CINN_FILE
                    sed -i "s|--panel-blur-background-color : rgba(64, 64, 64, 0.6);|background-color : rgba(64, 64, 64, 0);|g" $CINN_FILE
                    sed -i "s|--panel-border-top : 10px solid transparent;|border-top : 0px solid transparent;|g" $CINN_FILE
                    sed -i "s|--panel-border-bottom : 10px solid transparent;|border-bottom : 0px solid transparent;|g" $CINN_FILE  

                else
                    echo "[i] Panel Style: Modern"
                    
                    sed -i "s|--panel-border-radius : 32px;|border-radius : 32px;|g" $CINN_FILE
                    sed -i "s|--panel-background-color : transparent;|background-color : transparent;|g" $CINN_FILE
                    sed -i "s|--panel-inner-background-color : rgba(64, 64, 64, 0.9);|background-color : rgba(64, 64, 64, $paneltrans);|g" $CINN_FILE
                    sed -i "s|--panel-border-top : 10px solid transparent;|border-top : 10px solid transparent;|g" $CINN_FILE
                    sed -i "s|--panel-border-bottom : 10px solid transparent;|border-bottom : 10px solid transparent;|g" $CINN_FILE
                fi
                
                # PANEL BLUR NOT INNER PANEL
                if [ "$panelblur" = "true" ]; then
                    sed -i "s|background-image : url(/usr/share/backgrounds/dermodex/panel_blur.jpg);|background-image : url($HOME/.local/share/dermodex/panel_blur.png);|g" $CINN_FILE
                    sed -i "s|--panel-blur-background-color : rgba(64, 64, 64, 0.6);|background-color : rgba(64, 64, 64, 0.6);|g" $CINN_FILE
                    
                    if [[ "$panellocat" == "top" || "$panellocat" == "left" || "$panellocat" == "right" ]]; then
                        sed -i "s|--panel-blur-background-position: 0px -700px;|background-position: 0px 0px;|g" $CINN_FILE
                    else
                        sed -i "s|--panel-blur-background-position: 0px -700px;|--panel-blur-background-position: 0px -0px;|g" $CINN_FILE
                    fi

                else
                    if [ "$paneltrans" == "0" ]; then
                        sed -i "s|--panel-blur-background-color : rgba(64, 64, 64, 0.6);|background-color : rgba(64, 64, 64, 0);|g" $CINN_FILE
                    else
                        sed -i "s|--panel-blur-background-color : rgba(64, 64, 64, 0.6);|background-color : rgba(64, 64, 64, $paneltrans);|g" $CINN_FILE
                    fi
                    
                    sed -i "s|--panel-blur-background-position: 0px -700px;|background-position: 0px -1080px;|g" $CINN_FILE
                
                fi
                
                # PANEL BLUR - IMPORTANT KEEP THIS BELOW PANEL TRANS
                sed -i "s|--panel-blur-background-position: 0px -0px;|background-position: 0px -${RES_PRIMARY}px;|g" $CINN_FILE
                sed -i "s|background-image: url(~/.themes/|background-image: url(${HOME}/.themes/|g" $CINN_FILE
                
                # DESKLET CONFIGURATION BACKGROUND
                sed -i "s|--desklet-highlight-background-color: #999999;|background-color: ${HOE};|g" $CINN_FILE
                # DESKLET DRAG BACKGROUND
                sed -i "s|--desklet-drag-background-color: rgba(44, 44, 44, 0.3);|background-color: rgba${COE}, 0.3);|g" $CINN_FILE
                
                
                
                # Shake the Cinnamon - Cinnamon SEDs go above this line, at this point customizations are sent to .themes
                cp $CINN_FILE $HOME/.themes/DermoDeX/cinnamon
                
                
                # ICONS and GTK COPY OVER
                mkdir -p $HOME/.local/share/icons/White-Icons/scalable/emblems
                mkdir -p $HOME/.local/share/icons/White-Icons/scalable/places
                
                cp -f $HOME/.cache/dermodex/switch-on.svg $HOME/.themes/DermoDeX/cinnamon/common-assets/switch
                cp -f $HOME/.cache/dermodex/close.svg $HOME/.themes/DermoDeX/cinnamon/common-assets/misc
                cp -f $HOME/.cache/dermodex/close-hover.svg $HOME/.themes/DermoDeX/cinnamon/common-assets/misc
                cp -f $HOME/.cache/dermodex/close-active.svg $HOME/.themes/DermoDeX/cinnamon/common-assets/misc
                cp -f $HOME/.cache/dermodex/calendar-arrow-left-hover.svg $HOME/.themes/DermoDeX/cinnamon/common-assets/misc
                cp -f $HOME/.cache/dermodex/calendar-arrow-right-hover.svg $HOME/.themes/DermoDeX/cinnamon/common-assets/misc
                cp -f $HOME/.cache/dermodex/corner-ripple.svg $HOME/.themes/DermoDeX/cinnamon/common-assets/misc
                cp -f $HOME/.cache/dermodex/grouped-window-dot-active.svg $HOME/.themes/DermoDeX/cinnamon/common-assets/misc
                cp -f $HOME/.cache/dermodex/grouped-window-dot-hover.svg $HOME/.themes/DermoDeX/cinnamon/common-assets/misc
                
                #cp -f $HOME/.cache/dermodex/gtk-3.0/*.svg $HOME/.themes/DermoDeX/gtk-3.0/assets
                #cp -f $HOME/.cache/dermodex/gtk-3.0/*.svg $HOME/.themes/DermoDeX/assets
                cp -f $HOME/.cache/dermodex/common-assets/icons/emblems/*.svg $HOME/.local/share/icons/White-Icons/scalable/emblems
                cp -f $HOME/.cache/dermodex/common-assets/icons/places/*.svg $HOME/.local/share/icons/White-Icons/scalable/places
                
                
                # GTK CSS 
                #sed -i "s|#ff630d|#5e7997|g" $HOME/.cache/dermodex/gtk-3.20/gtk.gresource
                #sed -i "s|#ff5b00|#5e7997|g" $HOME/.cache/dermodex/gtk-3.20/gtk.gresource
                #sed -i "s|#ff6b1a|#5e7997|g" $HOME/.cache/dermodex/gtk-3.20/gtk.gresource
                #sed -i "s|#ffc101|#5e7997|g" $HOME/.cache/dermodex/gtk-3.20/gtk.gresource
                #sed -i "s|#ffc100|#5e7997|g" $HOME/.cache/dermodex/gtk-3.20/gtk.gresource
                #sed -i "s|#fff44f|#5e7997|g" $HOME/.cache/dermodex/gtk-3.20/gtk.gresource
                #sed -i "s|#ffc40d|#5e7997|g" $HOME/.cache/dermodex/gtk-3.20/gtk.gresource
                #sed -i "s|#ffc71a|#5e7997|g" $HOME/.cache/dermodex/gtk-3.20/gtk.gresource
                
                
                #if [ "$flowcolors" = true ]; then
                    #sed -i "s|#5e7997|${HOE}|g" $HOME/.cache/dermodex/gtk-3.0/colors.css
                    #sed -i "s|#5e7997|${HOE}|g" $HOME/.cache/dermodex/gtk-3.20/dist/gtk.css
                    #sed -i "s|#5e7997|${HOE}|g" $HOME/.cache/dermodex/gtk-3.20/gtk.gresource
                    #sed -i "s|#637f9e|${HOS}|g" $HOME/.cache/dermodex/gtk-3.20/gtk.gresource
                    
                    #if [ "$flowsidebar" = true ]; then
                        #sed -i "s|background-color: mix(#4d4d4d,#444444,0.5);|background-color: mix(${HOE},#000000,0.6);|g" $HOME/.cache/dermodex/gtk-3.20/gtk.gresource
                    #fi
                    
                #else
                    #sed -i "s|#5e7997|${HOS}|g" $HOME/.cache/dermodex/gtk-3.0/colors.css
                    #sed -i "s|#5e7997|${HOS}|g" $HOME/.cache/dermodex/gtk-3.20/dist/gtk.css
                    #sed -i "s|#5e7997|${HOS}|g" $HOME/.cache/dermodex/gtk-3.20/gtk.gresource
                    #sed -i "s|#637f9e|${HOE}|g" $HOME/.cache/dermodex/gtk-3.20/gtk.gresource
                    
                    #if [ "$flowsidebar" = true ]; then
                        #sed -i "s|background-color: mix(#4d4d4d,#444444,0.5);|background-color: mix(${HOS},#000000,0.6);|g" $HOME/.cache/dermodex/gtk-3.20/gtk.gresource
                    #fi
                    
                #fi
                
                
                
                #cp -f $HOME/.cache/dermodex/gtk-3.0/colors.css $HOME/.themes/DermoDeX/gtk-3.0/
                #cp -f $HOME/.cache/dermodex/gtk-3.20/gtk.gresource $HOME/.themes/DermoDeX/gtk-3.20/
                #cp -f $HOME/.cache/dermodex/gtk-3.20/dist/gtk.css $HOME/.themes/DermoDeX/gtk-3.20/dist/
                
                
                # Give Possibility to change sounds based on wallpaper too
                # gsettings set org.cinnamon.sounds login-file /usr/share/sounds/linux-a11y/stereo/desktop-login.oga
                
                notify-send --urgency=normal --category=transfer.complete --icon=cs-backgrounds-symbolic --hint=string:image-path:$HOME/.cache/dermodex/wallpaper_swatch.png "DermoDeX Recalculating Accent Colors!" "\nWait for Cinnamon to reload or manually reload with CTRL+Alt+Esc.\n\nfile://${HOME}/.cache/dermodex/wallpaper_swatch.png"

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
                    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/zorin/stereo/message-new-instant.ogg'
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
                    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/macos/contact-online.ogg'
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
                    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/LinuxMint/stereo/system-ready.ogg'
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
                    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/x11/stereo/message-new-instant.ogg'
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
                    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/x10/notify-system-generic.ogg'
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
                    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/xxp/notify.ogg'
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
                    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/miui/stereo/message-sent-instant.ogg'
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
                    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/deepin/suspend-resume.ogg'
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
                    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/enchanted/message-sent-instant.ogg'
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
                    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/borealis/notification.ogg'
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
                    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/harmony/notification-brighter.ogg'
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
                    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/linux-ubuntu/new-mail.ogg'
                    gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/linux-ubuntu/menu-popup.ogg'
                    gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/linux-a11y/stereo/desktop-login.oga'
                
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
                    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/linux-a11y/stereo/window-attention.oga'
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

                # No Rush
                sleep 7200
            else
                # Mixtape and Space Invaders
                sleep 1
            fi
        fi
    done
fi
