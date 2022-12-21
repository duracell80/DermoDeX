#!/bin/bash


CINN_VERSION=$(cinnamon --version)
if awk "BEGIN {exit !($CINN_VERSION < 5.2)}"; then
    echo "[i] ERROR: Cinnamon version too low, this script was designed for Cinnamon 5.2 and above"
    exit
fi


if [ ! -z $1 ] 
then 
    ACCENT=$1 # $1 was given
else
    ACCENT="#ff0000" # $1 was not given
fi




# SET THE STAGE
CINN_VERSION=$(cinnamon --version)
CWD=$(pwd)
LWD=$HOME/.local/share/dermodex
CCD=$HOME/.cache/dermodex
CINN_FILE=$CCD/cinnamon-ext.css
GTK2_FILE=$CCD/gtk-2.0/gtkrc
GTK3_FILE=$CCD/gtk-3.0/gtk.css
GTK3_DARK=$CCD/gtk-3.0/gtk-dark.css
GTK4_FILE=$CCD/gtk-4.0/gtk.css
GTK4_DARK=$CCD/gtk-4.0/gtk-dark.css

CONF_FILE="$HOME/.local/share/dermodex/config.ini"

mkdir -p $CCD/gtk-2.0
mkdir -p $CCD/gtk-3.0
mkdir -p $CCD/gtk-4.0

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
        echo "[i] Main Shade Active: From Overrides"
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
        echo "[i] Main Shade Active: When deactivated a lesser color may be chosen"
        ACCENT="#${savehex0}"
    else
        echo "[i] Mainshade Not Chosen"
        ACCENT="#${savehex1}"
    fi
fi

if [ "$ACCENT" == "#aN" ]; then
    echo "[i] Invalid Accent Color: ${ACCENT}"
    exit
fi

if [ "$ACCENT" == "#none" ]; then
    echo "[i] Invalid Accent Color: ${ACCENT}"
    exit
fi







BRIGHTEST=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 2.2 --mode="hex")
BRIGHTER=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 2 --mode="hex")
BRIGHT=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 1.3 --mode="hex")
DARK=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 0.7 --mode="hex")
DARKER=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 0.3 --mode="hex")
DARKEST=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 0.2 --mode="hex")

RGB_ACCENT=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 1 --mode="rgb")
RGB_BRIGHTEST=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 2.2 --mode="rgb")
RGB_BRIGHTER=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 2 --mode="rgb")
RGB_BRIGHT=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 1.3 --mode="rgb")
RGB_DARK=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 0.7 --mode="rgb")
RGB_DARKER=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 0.3 --mode="rgb")
RGB_DARKEST=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 0.2 --mode="rgb")

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
fi



# APPEND CINNAMON-EXT TO CINNAMON
cp -f $LWD/theme/cinnamon/cinnamon.css $LWD/theme/cinnamon/cinnamon.orig
cp $LWD/theme/cinnamon/cinnamon.css $CCD/cinnamon-base.css
cp $LWD/cinnamon-ext.css $CINN_FILE
chmod u+rw $CCD/cinnamon-base.css
chmod u+rw $CCD/cinnamon-ext.css



# SHOW AVATAR ON START MENU OR NOT
if [ "$menuavatar" = true ]; then
    sed -i "s|background-image: url(~/.face);|background-image: url(${HOME}/.face);|g" $CINN_FILE
else
    sed -i "s|background-image: url(~/.face);|background-image: url(none);|g" $CINN_FILE
fi
if [ "$menubckgrd" = "true" ]; then
    echo "[i] Menu Background Image Active"
    sed -i "s|dd-menu-background-image : url(~/|background-image : url(${HOME}/|g" $CINN_FILE
    sed -i "s|dd-menu-background-color : rgba(1,16,36,0.9)|background-color : rgba(1,16,36,${menutrans})|g" $CINN_FILE
else 
    echo "[i] Menu Background Image Inactive"
    sed -i "s|dd-menu-background-color : rgba(1,16,36,0.9)|background-color : rgba(1,16,36,${menutrans})|g" $CINN_FILE
fi

# USE ACCENT COLORS ON FAV SIDEBAR AND NEMO SIDEBAR
if [ "$flowsidebar" = "true" ]; then
    echo "[i] Accent - Sidebars: Enabled"
    sed -i "s|dd-fav-background-gradient-end|background-gradient-end|g" $CINN_FILE
    sed -i "s|dd-fav-background-gradient-start|background-gradient-start|g" $CINN_FILE
else 
    echo "[i] Accent - Sidebars: Not Enabled"
fi

# USE ACCENT COLOR ON START MENU BUTTON
if [ "$flowcolorsmenu" = "true" ]; then
    echo "[i] Accent - Start Menu Button: Enabled"
    sed -i "s|dd-menu-button-hover : #ffffff;|color : #011a3b;|g" $CINN_FILE
else 
    sed -i "s|dd-menu-button-hover : #ffffff;|color : #ffffff;|g" $CINN_FILE
fi

# SOUND PLAYER ENHANCEMENT - REGENERATE THE SOUNDWAVE
if [ "$flowsoundwaves" == "true" ]; then
    $LWD/sounds_waveform.sh
    sed -i "s|dd-soundwaves-background-image|background-image|g" $CINN_FILE
fi

# PANEL MAIN STYLE
if [ "$panelstyle" = "flat" ]; then
    
    # TRADITIONAL STYLE
    echo "[i] Panel Style: Flat"
    sed -i "s|dd-panel-inner-background-color : rgba(1,16,36,0.9);|background-color : rgba(1,16,36,0);|g" $CINN_FILE
    
    # PANEL IMAGE ON OR OFF
    if [ "$panelblur" = "true" ]; then
        echo "[i] Panel Image: On"
        sed -i "s|dd-panel-background-image : url(~/|background-image : url(${HOME}/|g" $CINN_FILE
        sed -i "s|dd-panel-background-color : rgba(1,16,36,0.9);|background-color : transparent;|g" $CINN_FILE
        
        # PANEL LOCATION CALCULATION
        if [ "$panellocat" = "bottom" ]; then
            echo "[i] Panel Location: bottom"
            sed -i "s|dd-panel-background-position : 0px -700px;|background-position : 0px -700px;|g" $CINN_FILE
        else
            echo "[i] Panel Location: ${panellocat}"
            sed -i "s|dd-panel-background-position : 0px -0px;|background-position : 0px -700px;|g" $CINN_FILE
        fi
        
    else
        echo "[i] Panel Image: off"
        # PANEL SHADE
        if [ "$panelshade" = "light" ]; then
            sed -i "s|dd-panel-background-color : rgba(1,16,36,0.9);|background-color : rgba(91,147,222,${paneltrans});|g" $CINN_FILE
        elif [ "$panelshade" = "medium" ]; then
            sed -i "s|dd-panel-background-color : rgba(1,16,36,0.9);|background-color : rgba(50,129,234,${paneltrans});|g" $CINN_FILE
        elif [ "$panelshade" = "dark" ]; then
            sed -i "s|dd-panel-background-color : rgba(1,16,36,0.9);|background-color : rgba(17,56,107,${paneltrans});|g" $CINN_FILE
        elif [ "$panelshade" = "darkest" ]; then
            sed -i "s|dd-panel-background-color : rgba(1,16,36,0.9);|background-color : rgba(1,16,36,${paneltrans});|g" $CINN_FILE
        else
            sed -i "s|dd-panel-background-color : rgba(1,16,36,0.9);|background-color : rgba(1,16,36,${paneltrans});|g" $CINN_FILE
        fi
    fi
    sed -i "s|dd-panel-window-border-radius : 64px;|border-radius : 0px;|g" $CINN_FILE
else
    # MODERN STYLE
    echo "[i] Panel Style: Modern"
    sed -i "s|dd-panel-inner-background-color : rgba(1,16,36,0.9);|background-color : rgba(1,16,36,${paneltrans});|g" $CINN_FILE
    
    sed -i "s|dd-panel-background-color : rgba(1,16,36,0.9);|background-color : rgba(1,16,36,0);|g" $CINN_FILE
    sed -i "s|dd-panel-window-border-radius : 64px;|border-radius : 64px;|g" $CINN_FILE
    
fi







echo "[i] Colors to Apply - Accent: $ACCENT | Bright: $BRIGHT | Brightest: $BRIGHTEST | Dark: $DARKER | Darkest: $DARKEST"


# IF ICON COLOR WAS OVERRIDEN AND DOESN'T MATCH ACCENT FROM WALLPAPER
if [ "$override3" == "aN" ] || [ "$override3" == "none" ]; then
    sed -i "s|workspace-dot-color : #3281ea;|color : #3281ea;|g" $CINN_FILE
else
    sed -i "s|workspace-dot-color : #3281ea;|color : #${override3};|g" $CINN_FILE
fi

# SED - BRIGHTEST - #a0bfe8 rgb(160,191,232)
sed -i "s|#a0bfe8|${BRIGHTEST}|g" $CINN_FILE
sed -i "s|rgba(160,191,232|rgba(${RGB_BRIGHTEST}|g" $CINN_FILE

# SED - BRIGHT - #5b93de rgb(91,147,222)
sed -i "s|#3281ea|${BRIGHT}|g" $CINN_FILE
sed -i "s|rgba(91,147,222|rgba(${RGB_BRIGHT}|g" $CINN_FILE

# SED - ACCENT - #3281ea rgb(50,129,234)
sed -i "s|#3281ea|${ACCENT}|g" $CINN_FILE
sed -i "s|rgba(50,129,234|rgba(${RGB_ACCENT}|g" $CINN_FILE

# SED - DARK - #11386b rgb(17,56,107)
sed -i "s|#011a3b|${DARK}|g" $CINN_FILE
sed -i "s|rgba(17,56,107|rgba(${RGB_DARKER}|g" $CINN_FILE

# SED - DARKER - #011a3b rgb(1,26,59)
sed -i "s|#011a3b|${DARKER}|g" $CINN_FILE
sed -i "s|rgba(1,26,59|rgba(${RGB_DARKER}|g" $CINN_FILE

# SED - DARKEST - #011024 rgb(1,16,36)
sed -i "s|#011024|${DARKEST}|g" $CINN_FILE
sed -i "s|rgba(1,16,36|rgba(${RGB_DARKEST}|g" $CINN_FILE

# SED - FIND THE REMAINING ~/
sed -i "s|~/|$HOME/|g" $CINN_FILE


# PROTECT CINAMON MENU HOVER FROM TOO LIGHT OF A HOVER SELECT
#HOVER_SHADE=$($HOME/.local/share/dermodex/remix_color.py -c "#EAFFC9" --mode="balance")
#if [ "$HOVER_SHADE" == "light" ]; then
    #sed -i "s|dd-menu-selected-color: #ffffff;|color: ${DARKEST};|g" $CINN_FILE
#else
sed -i "s|dd-menu-selected-color: #ffffff;|color: #ffffff;|g" $CINN_FILE
#fi


# COMBINE THE MODS
cat $CINN_FILE >> $CCD/cinnamon-base.css
cp -f $CCD/cinnamon-base.css $LWD/theme/cinnamon/cinnamon.css


if [ "$flowcolors" == true ]; then
    # COPY OVER GTK2 CSS TO THE CACHE
    cp -f $LWD/theme/gtk-2.0/gtkrc $LWD/theme/gtk-2.0/gtkrc.orig
    cp -f $LWD/theme/gtk-2.0/gtkrc $CCD/gtk-2.0
    
    
    # COPY OVER GTK3 CSS TO THE CACHE
    cp -f $LWD/theme/gtk-3.0/gtk.css $LWD/theme/gtk-3.0/gtk.orig
    cp -f $LWD/theme/gtk-3.0/gtk.css $CCD/gtk-3.0
    
    cp -f $LWD/theme/gtk-3.0/gtk-dark.css $LWD/theme/gtk-3.0/gtk-dark.orig
    cp -f $LWD/theme/gtk-3.0/gtk-dark.css $CCD/gtk-3.0
    
    # COPY OVER GTK4 CSS TO THE CACHE
    cp -f $LWD/theme/gtk-4.0/gtk.css $LWD/theme/gtk-4.0/gtk.orig
    cp -f $LWD/theme/gtk-4.0/gtk.css $CCD/gtk-4.0
    
    cp -f $LWD/theme/gtk-4.0/gtk-dark.css $LWD/theme/gtk-4.0/gtk-dark.orig
    cp -f $LWD/theme/gtk-4.0/gtk-dark.css $CCD/gtk-4.0

    # WORK THROUGH SOME GTK2 STUFF WITH SED
    # MAIN SED
    sed -i "s|#0078D4|${GTK0}|g" $GTK2_FILE
    sed -i "s|#1A73E8|${GTK0}|g" $GTK2_FILE
    sed -i "s|#9C27B0|${DARK}|g" $GTK2_FILE
    sed -i "s|#3281ea|${GTK0_BRIGHT}|g" $GTK2_FILE
    sed -i "s|#8ebaf4|${GTK0_BRIGHT}|g" $GTK2_FILE
    
    # WM AND CLOSE BUTTONS
    sed -i "s|#E53935|${GTK0}|g" $GTK2_FILE
    sed -i "s|#E57373|${GTK0_BRIGHT}|g" $GTK2_FILE
    
    # WORK THROUGH SOME GTK3 STUFF WITH SED
    # MAIN SED
    sed -i "s|#8ebaf4|${BRIGHTEST}|g" $GTK3_FILE
    sed -i "s|#8ebaf4|${BRIGHTEST}|g" $GTK3_DARK
    sed -i "s|#1A73E8|${GTK0_BRIGHT}|g" $GTK3_FILE
    sed -i "s|#1A73E8|${GTK0_BRIGHT}|g" $GTK3_DARK
    sed -i "s|#3181ea|${GTK0_BRIGHT}|g" $GTK3_FILE
    sed -i "s|#3281ea|${GTK0_BRIGHT}|g" $GTK3_DARK
    sed -i "s|#135cbc|${GTK0}|g" $GTK3_FILE
    sed -i "s|#135cbc|${GTK0}|g" $GTK3_DARK
    sed -i "s|#1567d3|${GTK0}|g" $GTK3_FILE
    sed -i "s|#1567d3|${GTK0}|g" $GTK3_DARK

    sed -i "s|rgba(15, 65, 131|rgba(${RGB_ACCENT}|g" $GTK3_FILE
    sed -i "s|rgba(15, 65, 131|rgba(${RGB_ACCENT}|g" $GTK3_DARK

    # FILE SELECTION BACKGROUND
    sed -i "s|rgba(26, 115, 232|rgba(${RGB_DARK}|g" $GTK3_FILE
    sed -i "s|rgba(26, 115, 232|rgba(${RGB_DARK}|g" $GTK3_DARK

    # WM AND CLOSE BUTTONS
    sed -i "s|#E53935|${GTK0}|g" $GTK3_FILE
    sed -i "s|#1d9bff|${GTK0}|g" $GTK3_DARK
    sed -i "s|#E57373|${GTK0_BRIGHT}|g" $GTK3_FILE
    sed -i "s|#25c9ff|${GTK0_BRIGHT}|g" $GTK3_DARK
    sed -i "s|#E53935|${GTK0}|g" $GTK3_DARK
    sed -i "s|#E57373|${GTK0_BRIGHT}|g" $GTK3_DARK
    

    # WARNING ERROR SUCCESS
    # WARNING
    sed -i "s|#F4B400|${DARKEST}|g" $GTK3_FILE
    sed -i "s|#F4B400|${DARKEST}|g" $GTK3_DARK
    # ERROR
    sed -i "s|#D93025|${DARKER}|g" $GTK3_FILE
    sed -i "s|#D93025|${DARKER}|g" $GTK3_DARK
    # SUCCESS
    sed -i "s|#0F9D58|${ACCENT}|g" $GTK3_FILE
    sed -i "s|#0F9D58|${ACCENT}|g" $GTK3_DARK
    
    
    
    
    
    
    
    # WORK THROUGH SOME GTK4 STUFF WITH SED
    # MAIN SED
    sed -i "s|#8ebaf4|${BRIGHTEST}|g" $GTK4_FILE
    sed -i "s|#8ebaf4|${BRIGHTEST}|g" $GTK4_DARK
    sed -i "s|#1A73E8|${GTK0_BRIGHT}|g" $GTK4_FILE
    sed -i "s|#1A73E8|${GTK0_BRIGHT}|g" $GTK4_DARK
    sed -i "s|#3181ea|${GTK0_BRIGHT}|g" $GTK4_FILE
    sed -i "s|#3281ea|${GTK0_BRIGHT}|g" $GTK4_DARK
    sed -i "s|#135cbc|${GTK0}|g" $GTK4_FILE
    sed -i "s|#135cbc|${GTK0}|g" $GTK4_DARK
    sed -i "s|#1567d3|${GTK0}|g" $GTK4_FILE
    sed -i "s|#1567d3|${GTK0}|g" $GTK4_DARK

    sed -i "s|rgba(15, 65, 131|rgba(${RGB_ACCENT}|g" $GTK4_FILE
    sed -i "s|rgba(15, 65, 131|rgba(${RGB_ACCENT}|g" $GTK4_DARK


    # WM AND CLOSE BUTTONS
    sed -i "s|#E53935|${GTK0}|g" $GTK4_FILE
    sed -i "s|#E53935|${GTK0}|g" $GTK4_DARK
    sed -i "s|#E57373|${GTK0_BRIGHT}|g" $GTK3_FILE
    sed -i "s|#25c9ff|${GTK0_BRIGHT}|g" $GTK3_DARK
    sed -i "s|#E53935|${GTK0}|g" $GTK4_DARK
    sed -i "s|#E57373|${GTK0_BRIGHT}|g" $GTK4_DARK

    # WARNING ERROR SUCCESS
    # WARNING
    sed -i "s|#F4B400|${DARKEST}|g" $GTK4_FILE
    sed -i "s|#FDD633|${DARKEST}|g" $GTK4_DARK
    # ERROR
    sed -i "s|#D93025|${DARKER}|g" $GTK4_FILE
    sed -i "s|#F28B82|${DARKER}|g" $GTK4_DARK
    # SUCCESS
    sed -i "s|#0F9D58|${ACCENT}|g" $GTK4_FILE
    sed -i "s|#81C995|${ACCENT}|g" $GTK4_DARK


    # COMBINE GTK2 MODS
    cp -f $GTK2_FILE $LWD/theme/gtk-2.0/
    
    # COMBINE GTK3 MODS
    cp -f $GTK3_FILE $LWD/theme/gtk-3.0/
    cp -f $GTK3_DARK $LWD/theme/gtk-3.0/
    
    # COMBINE GTK4 MODS
    cp -f $GTK4_FILE $LWD/theme/gtk-4.0/
    cp -f $GTK4_DARK $LWD/theme/gtk-4.0/
fi


# COPY HYBRID AS DERMODEX
cp -rf $LWD/theme/* $HOME/.themes/DermoDeX

# IMPORTANT: RESTORE CSS IN LOCAL BACK TO BASE WITHOUT MODS READY FOR NEXT RUN
cp -f $LWD/theme/cinnamon/cinnamon.orig $LWD/theme/cinnamon/cinnamon.css
cp -f $LWD/theme/gtk-3.0/gtk.orig $LWD/theme/gtk-3.0/gtk.css


#xdotool key ctrl+alt+"Escape"
