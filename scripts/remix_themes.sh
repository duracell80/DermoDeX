#!/bin/bash



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



if [ "$mainshade" = true ]; then
    echo "[i] Main Shade Active: When deactivated a lesser color may be chosen"
    ACCENT="#${savehex0}"
else
    echo "[i] Mainshade Not Chosen"
    ACCENT="#${savehex1}"
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
    sed -i "s|dd-menu-background-color : rgba(1,16,36,0.9);|background-color : rgba(1,16,36,${menutrans});|g" $CINN_FILE
else 
    echo "[i] Menu Background Image Inactive"
    sed -i "s|dd-menu-background-color : rgba(1,16,36,0.9);|background-color : rgba(1,16,36,${menutrans});|g" $CINN_FILE
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
    sed -i "s|dd-menu-button-hover : #ffffff;|color : #3281ea;|g" $CINN_FILE
else 
    sed -i "s|dd-menu-button-hover : #ffffff;|color : #ffffff;|g" $CINN_FILE
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
else
    # MODERN STYLE
    echo "[i] Panel Style: Modern"
    sed -i "s|dd-panel-inner-background-color : rgba(1,16,36,0.9);|background-color : rgba(1,16,36,${paneltrans});|g" $CINN_FILE
    
    sed -i "s|dd-panel-background-color : rgba(1,16,36,0.9);|background-color : rgba(1,16,36,0);|g" $CINN_FILE
fi







echo "[i] Colors to Apply - Accent: $ACCENT | Bright: $BRIGHT | Brightest: $BRIGHTEST | Dark: $DARKER | Darkest: $DARKEST"

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









# COMBINE THE MODS
cat $CINN_FILE >> $CCD/cinnamon-base.css
cp -f $CCD/cinnamon-base.css $LWD/theme/cinnamon/cinnamon.css


# COPY HYBRID AS DERMODEX
cp -rf $LWD/theme/* $HOME/.themes/DermoDeX

# IMPORTANT: RESTORE CINNAMON IN LOCAL BACK TO BASE WITHOUT MODS READY FOR NEXT RUN
cp -f $LWD/theme/cinnamon/cinnamon.orig $LWD/theme/cinnamon/cinnamon.css


xdotool key ctrl+alt+"Escape"
