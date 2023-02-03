#!/bin/bash

# bottom: stop-color:#000
# top: stop-color:#666
# tab: fill:#999
LWD=$HOME/.local/share/dermodex/icons/breeze-dark_black
IWD=$HOME/.local/share/icons/DermoDeX/scalable
CWD=$HOME/.cache/dermodex/icons/breeze-dark_black
CCA=$HOME/.cache/dermodex/common-assets/cinnamon/assets
TCD=$HOME/.themes/DermoDeX
FILE="$CWD/list.txt"

TYPE=$2

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

# MAIN OBJECTIVE OTHER THAN BEING COOL ... DONT CRASH CINNAMON!
if [ ! -z $1 ]
then
    # USE HEX PROVIDED IN PARAMETER
    echo "[i] Accent provided via Parameter: ${1}"
    ACCENT=$1
else

    # USE HEX PROVIDED IN CONFIGURATION FILE IN THE OVERRIDES
    if [ "$coloroverrides" == "true" ]; then
        if [ "$override3" == "aN" ] || [ "$override3" == "none" ]; then
            echo "[i] Icon override color not set yet, exiting."
            exit
        else
            if [ "$override4" == "aN" ] || [ "$override4" == "none" ]; then
                echo "[i] Icon Accent provided via Configuration: ${override3}"
                ACCENT="#${override3}"
            else
                echo "[i] Folder Accent provided via Configuration: ${override4}"
                ACCENT="#${override4}"
            fi
            
        fi
    else
        # USE HEX PROVIDED BY DERMODEX WALLPAPER EXTRACTOR
        if [ "$flowicons" == "true" ]; then
            # BUT FIRST FIGURE OUT IF PRIMARY COLOR FROM WALLPAPER WAS CHOSEN
            if [ "$mainshade" = true ]; then
                echo "[i] Icon Accent provided via Primary Wallpaper (Mainshade)"
                ACCENT="#${savehex0}"
            else
                echo "[i] Icon Accent provided via Secondary Wallpaper"
                ACCENT="#${savehex1}"
            fi
        else
            # QUIT IF FLOW IS TURNED OFF
            echo "[i] Color Flow - icons inactive, exiting."
            exit
        fi
    fi
fi


# QUIT IF HEX IS INVALID
if [ "$ACCENT" == "#aN" ]; then
    echo "[i] Invalid Accent Color"
    exit
fi

if [ "$ACCENT" == "#none" ]; then
    echo "[i] Invalid Accent Color"
    exit
fi

mkdir -p $CCA
mkdir -p $CWD/places/outline
mkdir -p $CWD/emblems
mkdir -p $CWD/legacy
mkdir -p $CWD/mimetypes
mkdir -p $CWD/apps
mkdir -p $CWD/controlpanel/cats
mkdir -p $CWD/controlpanel/apps
mkdir -p $HOME/.cache/dermodex/common-assets/cinnamon

cp -f $LWD/mimetypes/*.svg $CWD/mimetypes




CURRENT_WALL=$(gsettings get org.cinnamon.desktop.background picture-uri | sed "s|'file://||" | sed "s|'||")


BRIGHTEST=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 2.2 --mode="hex")
BRIGHTER=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 2 --mode="hex")
BRIGHT=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 1.3 --mode="hex")
DARK=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 0.7 --mode="hex")
DARKER=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 0.3 --mode="hex")
DARKEST=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 0.2 --mode="hex")

RGB_BRIGHTEST=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 2.2 --mode="rgb")
RGB_BRIGHTER=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 2 --mode="rgb")
RGB_BRIGHT=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 1.3 --mode="rgb")
RGB_DARK=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 0.7 --mode="rgb")
RGB_DARKER=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 0.3 --mode="rgb")
RGB_DARKEST=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 0.2 --mode="rgb")

GTK0=$($HOME/.local/share/dermodex/remix_color.py -c "${savegtk0}" -f 1 --mode="hex")
GTK0_BRIGHT=$($HOME/.local/share/dermodex/remix_color.py -c "${savegtk0}" -f 1.3 --mode="hex")
GTK0_DARK=$($HOME/.local/share/dermodex/remix_color.py -c "${savegtk0}" -f 0.7 --mode="hex")



ACCENT_COMP1=$(cat $HOME/.local/share/dermodex/colors_hex.txt | cut -d ',' -f2)
ACCENT_COMP1_BRIGHT=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT_COMP1}" -f 1.3 --mode="hex")
ACCENT_COMP1_DARK=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT_COMP1}" -f 0.7 --mode="hex")

ACCENT_COMP2=$(cat $HOME/.local/share/dermodex/colors_hex.txt | cut -d ',' -f3)
ACCENT_COMP2_BRIGHT=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT_COMP2}" -f 1.3 --mode="hex")
ACCENT_COMP2_DARK=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT_COMP2}" -f 0.7 --mode="hex")

ACCENT_COMP3=$(cat $HOME/.local/share/dermodex/colors_hex.txt | cut -d ',' -f4)
ACCENT_COMP3_BRIGHT=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT_COMP3}" -f 1.3 --mode="hex")
ACCENT_COMP3_DARK=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT_COMP3}" -f 0.7 --mode="hex")

ACCENT_COMP4=$(cat $HOME/.local/share/dermodex/colors_hex.txt | cut -d ',' -f5)
ACCENT_COMP4_BRIGHT=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT_COMP4}" -f 1.3 --mode="hex")
ACCENT_COMP4_DARK=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT_COMP4}" -f 0.7 --mode="hex")


if [ "$TYPE" == "folders" ]; then
    echo "[i] Remixing Icons: Places"
    
    mkdir -p $CWD/places/desktop
    mkdir -p $HOME/.local/share/icons/DermoDeX/scalable/places/desktop
    
    #savehex0_brightest=$($HOME/.local/share/dermodex/remix_color.py -c "#${savehex0}" -f 2.2 --mode="hex")
    #savehex0_brighter=$($HOME/.local/share/dermodex/remix_color.py -c "#${savehex0}" -f 1.8 --mode="hex")
    #savehex0_bright=$($HOME/.local/share/dermodex/remix_color.py -c "#${savehex0}" -f 1.3 --mode="hex")
    #savehex0_dark=$($HOME/.local/share/dermodex/remix_color.py -c "#${savehex0}" -f 0.7 --mode="hex")
    
    savehex1_brighterst=$($HOME/.local/share/dermodex/remix_color.py -c "#${savehex1}" -f 2.2 --mode="hex")
    savehex1_brighter=$($HOME/.local/share/dermodex/remix_color.py -c "#${savehex1}" -f 1.8 --mode="hex")
    savehex1_bright=$($HOME/.local/share/dermodex/remix_color.py -c "#${savehex1}" -f 1.3 --mode="hex")
    savehex1_dark=$($HOME/.local/share/dermodex/remix_color.py -c "#${savehex1}" -f 0.7 --mode="hex")
    
    #savehex2_brightest=$($HOME/.local/share/dermodex/remix_color.py -c "#${savehex2}" -f 2.2 --mode="hex")
    #savehex2_brighter=$($HOME/.local/share/dermodex/remix_color.py -c "#${savehex2}" -f 1.8 --mode="hex")
    #savehex2_bright=$($HOME/.local/share/dermodex/remix_color.py -c "#${savehex2}" -f 1.3 --mode="hex")
    #savehex2_dark=$($HOME/.local/share/dermodex/remix_color.py -c "#${savehex2}" -f 0.7 --mode="hex")
    
    # PLACES
    cp -f $LWD/places/*.svg $CWD/places
    cp -f $LWD/places/user-home.svg $CWD/places/desktop
    cp -f $LWD/places/network-server.svg $CWD/places/desktop
    
    sed -i "s|stop-color:#000|stop-color:#${savehex1}|g" $CWD/places/desktop/user-home.svg
    sed -i "s|stop-color:#666|stop-color:${savehex1_bright}|g" $CWD/places/desktop/user-home.svg
    sed -i "s|fill:#999|fill:${savehex1_dark}|g" $CWD/places/desktop/user-home.svg
    
    sed -i "s|stop-color:#000|stop-color:#${savehex1}|g" $CWD/places/desktop/network-server.svg
    sed -i "s|stop-color:#666|stop-color:${savehex1_bright}|g" $CWD/places/desktop/network-server.svg
    sed -i "s|fill:#999|fill:${savehex1_dark}|g" $CWD/places/desktop/network-server.svg
    
    cp $CWD/places/desktop/*.svg $HOME/.local/share/icons/DermoDeX/scalable/places/desktop
    
    
    ls $CWD/places/*.svg > $FILE
    while read -r LINE; do
        sed -i "s|stop-color:#000|stop-color:${ACCENT}|g" ${LINE}
        sed -i "s|stop-color:#666|stop-color:${BRIGHT}|g" ${LINE}
        sed -i "s|fill:#999|fill:${DARK}|g" ${LINE}
    done < $FILE
    rm -f $FILE
    
    # PLACES - FOLDER COLOR OPTIONS
    cp -f $LWD/places/folder.svg $CWD/places/folder_1.svg
    cp -f $LWD/places/folder.svg $CWD/places/folder_2.svg
    cp -f $LWD/places/folder.svg $CWD/places/folder_3.svg
    cp -f $LWD/places/folder.svg $CWD/places/folder_4.svg
    
    cp -f $LWD/places/folder-drag-accept.svg $CWD/places/folder-drag-accept_1.svg
    cp -f $LWD/places/folder-drag-accept.svg $CWD/places/folder-drag-accept_2.svg
    cp -f $LWD/places/folder-drag-accept.svg $CWD/places/folder-drag-accept_3.svg
    cp -f $LWD/places/folder-drag-accept.svg $CWD/places/folder-drag-accept_4.svg
    
    LINE=$CWD/places/folder_1.svg
    LINE2=$CWD/places/folder-drag-accept_1.svg
    sed -i "s|stop-color:#000|stop-color:${ACCENT_COMP1}|g" ${LINE}
    sed -i "s|stop-color:#666|stop-color:${ACCENT_COMP1_BRIGHT}|g" ${LINE}
    sed -i "s|fill:#999|fill:${ACCENT_COMP1_DARK}|g" ${LINE}
    sed -i "s|stop-color:#000|stop-color:${ACCENT_COMP1}|g" ${LINE2}
    sed -i "s|stop-color:#666|stop-color:${ACCENT_COMP1_BRIGHT}|g" ${LINE2}
    sed -i "s|fill:#999|fill:${ACCENT_COMP1_DARK}|g" ${LINE2}
    
    LINE=$CWD/places/folder_2.svg
    LINE2=$CWD/places/folder-drag-accept_2.svg
    sed -i "s|stop-color:#000|stop-color:${ACCENT_COMP2}|g" ${LINE}
    sed -i "s|stop-color:#666|stop-color:${ACCENT_COMP2_BRIGHT}|g" ${LINE}
    sed -i "s|fill:#999|fill:${ACCENT_COMP2_DARK}|g" ${LINE}
    sed -i "s|stop-color:#000|stop-color:${ACCENT_COMP2}|g" ${LINE2}
    sed -i "s|stop-color:#666|stop-color:${ACCENT_COMP2_BRIGHT}|g" ${LINE2}
    sed -i "s|fill:#999|fill:${ACCENT_COMP2_DARK}|g" ${LINE2}
    
    LINE=$CWD/places/folder_3.svg
    LINE2=$CWD/places/folder-drag-accept_3.svg
    sed -i "s|stop-color:#000|stop-color:${ACCENT_COMP3}|g" ${LINE}
    sed -i "s|stop-color:#666|stop-color:${ACCENT_COMP3_BRIGHT}|g" ${LINE}
    sed -i "s|fill:#999|fill:${ACCENT_COMP3_DARK}|g" ${LINE}
    sed -i "s|stop-color:#000|stop-color:${ACCENT_COMP3}|g" ${LINE2}
    sed -i "s|stop-color:#666|stop-color:${ACCENT_COMP3_BRIGHT}|g" ${LINE2}
    sed -i "s|fill:#999|fill:${ACCENT_COMP3_DARK}|g" ${LINE2}

    LINE=$CWD/places/folder_4.svg
    LINE2=$CWD/places/folder-drag-accept_4.svg
    sed -i "s|stop-color:#000|stop-color:${ACCENT_COMP4}|g" ${LINE}
    sed -i "s|stop-color:#666|stop-color:${ACCENT_COMP4_BRIGHT}|g" ${LINE}
    sed -i "s|fill:#999|fill:${ACCENT_COMP4_DARK}|g" ${LINE}
    sed -i "s|stop-color:#000|stop-color:${ACCENT_COMP4}|g" ${LINE2}
    sed -i "s|stop-color:#666|stop-color:${ACCENT_COMP4_BRIGHT}|g" ${LINE2}
    sed -i "s|fill:#999|fill:${ACCENT_COMP4_DARK}|g" ${LINE2}
    
    
    
    # PLACES - OUTLINED
    cp -f $LWD/places/outline/*.svg $CWD/places/outline
    ls $CWD/places/outline/*.svg > $FILE
    
    echo "[i] Remixing Icons: Places Outlined"
    while read -r LINE; do
        sed -i 's|#000000|'${ACCENT}'|g' ${LINE}
    done < $FILE
    rm -f $FILE
    
    cp -n $CWD/places/outline/*.svg $CWD/places
    mv -f $CWD/places/*.svg $HOME/.local/share/icons/DermoDeX/scalable/places

else
    # EMBLEMS
    cp -f $LWD/emblems/*.svg $CWD/emblems
    ls $CWD/emblems/*.svg > $FILE

    echo "[i] Remixing Icons: Emblems"
    while read -r LINE; do
        sed -i "s|#333333|${DARK}|g" ${LINE}
    done < $FILE
    rm -f $FILE
    
    
    # EMBLEMS -LEGACY
    sleep 1
    cp -f $LWD/emblems/emblem-* $CWD/legacy
    ls $CWD/legacy/emblem-* > $FILE

    echo "[i] Remixing Icons: Emblems - Legacy"
    while read -r LINE; do
        sed -i "s|#333333|${DARK}|g" ${LINE}
    done < $FILE
    rm -f $FILE


    # MIMETYPES
    ls $CWD/mimetypes/*.svg > $FILE

    echo "[i] Remixing Icons: Mimetypes"
    while read -r LINE; do
        sed -i 's|#000000|'${DARK}'|g' ${LINE}
    done < $FILE
    rm -f $FILE

    # SYSTEM CONTROL PANEL
    cp -f $LWD/controlpanel/cats/*.svg $CWD/controlpanel/cats/
    ls $CWD/controlpanel/cats/*.svg > $FILE

    echo "[i] Remixing Icons: Control Panel - Categories"
    while read -r LINE; do
        sed -i 's|#cccccc|'${ACCENT}'|g' ${LINE}
    done < $FILE
    rm -f $FILE

    cp -f $LWD/controlpanel/apps/*.svg $CWD/controlpanel/apps
    ls $CWD/controlpanel/apps/*.svg > $FILE

    echo "[i] Remixing Icons: Control Panel - Applications"
    while read -r LINE; do
        sed -i 's|#cccccc|'${ACCENT}'|g' ${LINE}
    done < $FILE
    rm -f $FILE
    
    mv -f $CWD/emblems/*.svg $HOME/.local/share/icons/DermoDeX/scalable/emblems
    mv -f $CWD/legacy/emblem-* $HOME/.local/share/icons/DermoDeX/scalable/legacy
    mv -f $CWD/mimetypes/*.svg $HOME/.local/share/icons/DermoDeX/scalable/mimetypes

    cp -f $CWD/controlpanel/cats/cs* $HOME/.local/share/icons/DermoDeX/scalable/categories
    cp -f $CWD/controlpanel/apps/csd* $HOME/.local/share/icons/DermoDeX/scalable/apps


    # RECOLOR APP ICON BACKGROUNDS
    cp -f $LWD/apps/scalable/*.svg $CWD/apps
    sed -i "s|#333333|${DARK}|g" $CWD/apps/*.svg

    APP_ICONS="${HOME}/.local/share/icons/DermoDeX/scalable/apps"
    APP_ICONS_AUX="$CWD/apps"


    cp -f "$APP_ICONS_AUX/"org.gnome* $APP_ICONS
    cp -f $APP_ICONS/google-chrome.svg $APP_ICONS/chromium.svg
    cp -f $APP_ICONS/google-chrome.svg $APP_ICONS/chrome.svg
    cp -f $APP_ICONS/google-chrome.svg $APP_ICONS/com.google.Chrome.svg
    cp -f "$APP_ICONS_AUX/"chrom* $APP_ICONS
    cp -f "$APP_ICONS_AUX/"brav* $APP_ICONS
    cp -f "$APP_ICONS_AUX/microsoft-edge.svg" $APP_ICONS/com.microsoft.Edge.svg

    cp -f "$APP_ICONS_AUX/krita.svg" $APP_ICONS/org.kde.krita.svg

    cp -f "$APP_ICONS_AUX/"libreoffice* $APP_ICON
    cp -f $APP_ICONS/spotify.svg $APP_ICONS/spotify-client.svg

    cp -f $APP_ICONS/skype.svg $APP_ICONS/skypeforlinux.svg
    cp -f "$APP_ICONS_AUX/teams.svg" $APP_ICONS
    cp -f "$APP_ICONS_AUX/teams-for-linux.svg" $APP_ICONS
    cp -f $APP_ICONS/firefox-esr.svg $APP_ICONS/firefox.svg
    cp -f $APP_ICONS/terminal.svg $APP_ICONS/putty.svg
    cp -f $APP_ICONS/multimedia.svg $APP_ICONS/io.github.celluloid_player.Celluloid.svg
    cp -f $APP_ICONS/magnatune.svg $APP_ICONS/hdhr.svg
    cp -f $APP_ICONS/mpv.svg $APP_ICONS/hypnotix.svg
    cp -f $APP_ICONS/picasa.svg $APP_ICONS/xviewer.svg
    cp -f $APP_ICONS/acroread.svg $APP_ICONS/xreader.svg
    cp -f $APP_ICONS/gnome-note.svg $APP_ICONS/sticky.svg
    cp -f $APP_ICONS/org.gnome.LightsOff.svg $APP_ICONS/gnome-todo.svg
    cp -f $APP_ICONS/gthumb.svg $APP_ICONS/redshift-gtk.svg
    cp -f $APP_ICONS/gthumb.svg $APP_ICONS/redshift.svg
    cp -f "$APP_ICONS_AUX/kdenlive.svg" $APP_ICONS/bulky.svg
    cp -f "$APP_ICONS_AUX/onboard.svg" $APP_ICONS
    cp -f "$APP_ICONS_AUX/alacarte.svg" $APP_ICONS/thingy.svg

    cp -f "$APP_ICONS_AUX/simplenote.svg" $APP_ICONS/mintinstall.svg
    cp -f "$APP_ICONS_AUX/simplenote.svg" $APP_ICONS/mintsources.svg
    cp -f "$APP_ICONS_AUX/bleachbit.svg" $APP_ICONS/mintreport.svg
    cp -f "$APP_ICONS_AUX/xfburn.svg" $APP_ICONS/mintupdate.svg
    cp -f "$APP_ICONS_AUX/kclock.svg" $APP_ICONS/timeshift.svg
    cp -f $APP_ICONS/distributor-logo-linux-mint.svg $APP_ICONS/mintwelcome.svg
    cp -f $APP_ICONS/synaptic.svg $APP_ICONS/mintstick.svg
    cp -f "$APP_ICONS_AUX/livepatch.svg" $APP_ICONS/mintbackup.svg
    cp -f "$APP_ICONS_AUX/acetoneiso.svg" $APP_ICONS/mintdrivers.svg
    cp -f "$APP_ICONS_AUX/keepass.svg" $APP_ICONS/lightdm-settings.svg
    cp -f $APP_ICONS/preferences-desktop-keyboard.svg $APP_ICONS/mintlocale-im.svg
    cp -f "$APP_ICONS_AUX/warpinator.svg" $APP_ICONS/org.x.Warpinator.svg

    cp -f "$APP_ICONS_AUX/com.github.maoschanz.drawing.svg" $APP_ICONS
    cp -f "$APP_ICONS_AUX/shuffler-control.svg" $APP_ICONS/pix.svg
    cp -f "$APP_ICONS_AUX/budgiewprviews.svg" $APP_ICONS/webapp-manager.svg
    cp -f "$APP_ICONS_AUX/github-desktop.svg" $APP_ICONS/io.github.shiftey.Desktop.svg
    cp -f "$APP_ICONS_AUX/io.atom.Atom.svg" $APP_ICONS/io.brackets.Brackets.svg
    cp -f "$APP_ICONS_AUX/sublime-text.svg" $APP_ICONS
    cp -f $APP_ICONS/gnome-warning.svg $APP_ICONS/gufw.svg

    cp -f "$APP_ICONS_AUX/shotcut.svg" $APP_ICONS/org.shotcut.Shotcut.svg
    cp -f "$APP_ICONS_AUX/hb-icon.svg" $APP_ICONS/fr.handbrake.ghb.svg
    cp -f "$APP_ICONS_AUX/xfburn.svg" $APP_ICONS/com.makemkv.MakeMKV.svg
    cp -f "$APP_ICONS_AUX/kodi.svg" $APP_ICONS



    # COPY CINNAMON ASSETS FOR MANIPULATION
    cp -rf $HOME/.local/share/dermodex/theme-ext/cinnamon/assets/dermodex $HOME/.themes/DermoDeX/cinnamon/assets

    cp -rf $HOME/.local/share/dermodex/theme/cinnamon/assets/*.svg $CCA
    cp -rf $HOME/.local/share/dermodex/theme/cinnamon/assets/calendar-arrow-left.svg $CCA/calendar-arrow-left-hover.svg
    cp -rf $HOME/.local/share/dermodex/theme/cinnamon/assets/calendar-arrow-right.svg $CCA/calendar-arrow-right-hover.svg

    # RECOLOR CINNAMON CLOSE ICONS
    sed -i "s|#f75a61|${ACCENT}|g" $CCA/close.svg
    sed -i "s|#d8354a|${DARK}|g" $CCA/close-active.svg
    sed -i "s|#ff7a80|${BRIGHT}|g" $CCA/close-hover.svg
    sed -i "s|#1a73e8|${BRIGHT}|g" $CCA/corner-ripple.svg
    sed -i "s|#3476cf|${ACCENT}|g" $CCA/toggle-on.svg
    sed -i "s|#0860f2|${ACCENT}|g" $CCA/add-workspace-active.svg
    sed -i "s|#3476cf|${ACCENT}|g" $CCA/checkbox.svg
    sed -i "s|#1a73e8|${ACCENT}|g" $CCA/radiobutton.svg
    sed -i "s|#3281ea|${ACCENT}|g" $CCA/grouped-window-dot-active.svg
    sed -i "s|#e6e6e6|${BRIGHT}|g" $CCA/calendar-arrow-left-hover.svg
    sed -i "s|#e6e6e6|${BRIGHT}|g" $CCA/calendar-arrow-right-hover.svg
    #rm -rf $CCA/*.svg
    cp -f $CCA/*.svg $TCD/cinnamon/assets
fi

cp -f "$HOME/.cache/dermodex/icons/trash/user-trash.svg" $HOME/.local/share/icons/DermoDeX/scalable/places/user-trash.svg
cp -f "$HOME/.cache/dermodex/icons/trash/user-trash-full.svg" $HOME/.local/share/icons/DermoDeX/scalable/places/user-trash-full.svg

#xdotool key ctrl+alt+"Escape"
