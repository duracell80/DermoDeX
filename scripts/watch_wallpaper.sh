#!/usr/bin/env bash
HOLD_FILE="$HOME/.local/share/dermodex/dermodex_hold"
CONF_FILE="$HOME/.local/share/dermodex/config.ini"
CINN_FILE="$HOME/.cache/dermodex/cinnamon.css"

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


echo $savehex1

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
                cp $HOME/.local/share/dermodex/cinnamon_base.css $CINN_FILE
                
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

                cp -f $HOME/.local/share/dermodex/common-assets/switch/*.svg $HOME/.cache/dermodex/
                cp -f $HOME/.local/share/dermodex/common-assets/misc/*.svg $HOME/.cache/dermodex/
                
                cp -f $HOME/.local/share/dermodex/gtk-3.0/assets/*.svg $HOME/.cache/dermodex/gtk-3.0
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
                    
                    sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/checkbox-checked.svg
                    sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/checkbox-checked-dark.svg
                    sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/checkbox-mixed.svg
                    sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/checkbox-mixed-dark.svg
                    sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/grid-selection-checked.svg
                    sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/grid-selection-checked-dark.svg
                    sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/menuitem-checkbox-checked.svg
                    sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/menuitem-checkbox-mixed-selected.svg
                    sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/menuitem-radio-checked.svg
                    sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/menuitem-radio-mixed-selected.svg
                    sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/radio-checked.svg
                    sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/radio-checked-dark.svg
                    sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/radio-mixed.svg
                    sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/radio-mixed-dark.svg
                    sed -i "s|#647891|${MAINSHADE_HEX}|g" $HOME/.cache/dermodex/gtk-3.0/radio-selected.svg
                    
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
                    sed -i "s|#478db2|${HOE}|g" $CINN_FILE
                    sed -i "s|#478db2|${HOS}|g" $HOME/.cache/dermodex/switch-on.svg
                    sed -i "s|#f70505|${HOS}|g" $HOME/.cache/dermodex/close.svg
                    sed -i "s|#f70505|${HOS}|g" $HOME/.cache/dermodex/close-hover.svg
                    sed -i "s|#f70505|${HOS}|g" $HOME/.cache/dermodex/close-active.svg
                    sed -i "s|#478db2|${HOS}|g" $HOME/.cache/dermodex/calendar-arrow-left-hover.svg
                    sed -i "s|#478db2|${HOS}|g" $HOME/.cache/dermodex/calendar-arrow-right-hover.svg
                    sed -i "s|#478db2|${HOS}|g" $HOME/.cache/dermodex/corner-ripple.svg
                    sed -i "s|#478db2|${HOE}|g" $HOME/.cache/dermodex/grouped-window-dot-active.svg
                    sed -i "s|#478db2|${HOE}|g" $HOME/.cache/dermodex/grouped-window-dot-hover.svg
                    
                    sed -i "s|#647891|${HOS}|g" $HOME/.cache/dermodex/gtk-3.0/checkbox-checked.svg
                    sed -i "s|#647891|${HOS}|g" $HOME/.cache/dermodex/gtk-3.0/checkbox-checked-dark.svg
                    sed -i "s|#647891|${HOS}|g" $HOME/.cache/dermodex/gtk-3.0/checkbox-mixed.svg
                    sed -i "s|#647891|${HOS}|g" $HOME/.cache/dermodex/gtk-3.0/checkbox-mixed-dark.svg
                    sed -i "s|#647891|${HOS}|g" $HOME/.cache/dermodex/gtk-3.0/grid-selection-checked.svg
                    sed -i "s|#647891|${HOS}|g" $HOME/.cache/dermodex/gtk-3.0/grid-selection-checked-dark.svg
                    sed -i "s|#647891|${HOS}|g" $HOME/.cache/dermodex/gtk-3.0/menuitem-checkbox-checked.svg
                    sed -i "s|#647891|${HOS}|g" $HOME/.cache/dermodex/gtk-3.0/menuitem-checkbox-mixed-selected.svg
                    sed -i "s|#647891|${HOS}|g" $HOME/.cache/dermodex/gtk-3.0/menuitem-radio-checked.svg
                    sed -i "s|#647891|${HOS}|g" $HOME/.cache/dermodex/gtk-3.0/menuitem-radio-mixed-selected.svg
                    sed -i "s|#647891|${HOS}|g" $HOME/.cache/dermodex/gtk-3.0/radio-checked.svg
                    sed -i "s|#647891|${HOS}|g" $HOME/.cache/dermodex/gtk-3.0/radio-checked-dark.svg
                    sed -i "s|#647891|${HOS}|g" $HOME/.cache/dermodex/gtk-3.0/radio-mixed.svg
                    sed -i "s|#647891|${HOS}|g" $HOME/.cache/dermodex/gtk-3.0/radio-mixed-dark.svg
                    sed -i "s|#647891|${HOS}|g" $HOME/.cache/dermodex/gtk-3.0/radio-selected.svg
                    
                    sed -i "s|fav-background-gradient-end: rgba(0,0,0|background-gradient-end: rgba${COE}|g" $CINN_FILE
                    
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
                
                # SHOW AVATAR ON START MENU OR NOT
                if [ "$menuavatar" = true ]; then
                    sed -i "s|background-image: url(~/.face);|background-image: url(${HOME}/.face);|g" $CINN_FILE
                else
                    sed -i "s|background-image: url(~/.face);|background-image: url(none);|g" $CINN_FILE
                fi
                
                # BLUR COPY OF WALLPAPER ON START MENU OR NOT
                if [ "$menubckgrd" = "true" ]; then
                    sed -i "s|--menu-background-image : url(~/.local/share/dermodex/menu_blur.jpg);|background-image : url($HOME/.local/share/dermodex/menu_blur.jpg);|g" $CINN_FILE
                else 
                    sed -i "s|--menu-background-image : url(~/.local/share/dermodex/menu_blur.jpg);|background-image : url();|g" $CINN_FILE
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
                    sed -i "s|background-image : url(/usr/share/backgrounds/dermodex/panel_blur.jpg);|background-image : url($HOME/.local/share/dermodex/panel_blur.jpg);|g" $CINN_FILE
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
                
                cp -f $HOME/.cache/dermodex/gtk-3.0/*.svg $HOME/.themes/DermoDeX/gtk-3.0/assets
                cp -f $HOME/.cache/dermodex/gtk-3.0/*.svg $HOME/.themes/DermoDeX/assets
                cp -f $HOME/.cache/dermodex/common-assets/icons/emblems/*.svg $HOME/.local/share/icons/White-Icons/scalable/emblems
                cp -f $HOME/.cache/dermodex/common-assets/icons/places/*.svg $HOME/.local/share/icons/White-Icons/scalable/places
                
                
                # GTK CSS
                mkdir -p $HOME/.cache/dermodex/gtk-3.20/dist
                
                cp $HOME/.local/share/dermodex/gtk-3.20/gtk.gresource $HOME/.cache/dermodex/gtk-3.20
                cp $HOME/.local/share/dermodex/gtk-3.20/dist/gtk.css $HOME/.cache/dermodex/gtk-3.20/dist/
                if [ "$flipcolors" = true ]; then
                    sed -i "s|#5e7997|${HOE}|g" $HOME/.cache/dermodex/gtk-3.20/dist/gtk.css
                    sed -i "s|#5e7997|${HOE}|g" $HOME/.cache/dermodex/gtk-3.20/gtk.gresource
                    sed -i "s|#637f9e|${HOS}|g" $HOME/.cache/dermodex/gtk-3.20/gtk.gresource
                else
                    sed -i "s|#5e7997|${HOS}|g" $HOME/.cache/dermodex/gtk-3.20/dist/gtk.css
                    sed -i "s|#5e7997|${HOS}|g" $HOME/.cache/dermodex/gtk-3.20/gtk.gresource
                    sed -i "s|#637f9e|${HOE}|g" $HOME/.cache/dermodex/gtk-3.20/gtk.gresource
                fi
                cp -f $HOME/.cache/dermodex/gtk-3.20/gtk.gresource $HOME/.themes/DermoDeX/gtk-3.20/
                cp -f $HOME/.cache/dermodex/gtk-3.20/dist/gtk.css $HOME/.themes/DermoDeX/gtk-3.20/dist/
                
                # TEXT SCALING
                gsettings set org.cinnamon.desktop.interface text-scaling-factor "$textfactor"
                
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
                gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y-Dark-Aqua"
                gsettings set org.cinnamon.desktop.interface gtk-theme "DermoDeX"



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
                sleep 1
            fi
        fi
    done
fi
