#!/bin/bash

if [ -f "$HOLD_FILE" ]; then
    ACT="0"
    echo "[!] Hold file is currently active, release dermodex hold"
    notify-send --urgency=normal --category=transfer.complete --icon=cs-backgrounds-symbolic "DermoDeX Hold Active!" "Release the hold in order to continue ..."
    exit
else
    ACT="1"
    notify-send --urgency=normal --category=transfer.complete --icon=cs-backgrounds-symbolic "DermoDeX is Installing!" "Answer a few questions in the terminal to configure things just the way you want them."
fi


CINN_VERSION=$(cinnamon --version)
if awk "BEGIN {exit !($CINN_VERSION < 5.2)}"; then
    echo "[i] ERROR: Cinnamon version too low, this script was designed for Cinnamon 5.2 and above"
    exit
fi

echo "[i] Before running the install note the changes documented such as needing to backup your /usr/share/sounds directory."
read -p "[Q] Do you wish to continue (y/n)? " answer
case ${answer:0:1} in
    y|Y )
        echo ""
        echo "[i] - Installing Deps from APT and PIP"
        sudo apt install -y python3-pip libsass1 sassc rofi scrot imagemagick xz-utils xdotool ffmpeg inkscape imagemagick sox


        pip3 install easydev
        pip3 install colormap
        pip3 install pandas
        pip3 install numpy
        pip3 install colorgram.py
        pip3 install extcolors
        pip3 install matplotlib
        pip3 install configparser
        pip3 install xdisplayinfo
    
        dconf dump /org/cinnamon/ > $HOME/cinnamon_desktop_preinstall.backup
    
        gsettings set org.cinnamon.desktop.interface icon-theme "Mint-Y"
        gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y"
        gsettings set org.cinnamon.desktop.wm.preferences theme "cinnamon"
        gsettings set org.cinnamon.theme name "cinnamon"
    ;;
    * )
        exit
    ;;
esac



rm -rf $HOME/.local/share/dermodex
rm -rf $HOME/.cache/dermodex
rm -rf $HOME/.themes/DermoDeX
rm -rf $HOME/.local/share/cinnamon/extensions/dermodex-config@duracell80
rm -f $HOME/.cinnamon/configs/dermodex-config@duracell80


echo "[i] - Backing Up Current Cinnamon Configuration"
dconf dump /org/cinnamon/ > $HOME/cinnamon_desktop.backup

CWD=$(pwd)
SWD=/usr/share/sounds
LWD=$HOME/.local/share/dermodex/icons/breeze-dark_black
TWD=$HOME/.themes/DermoDeX

sed -i "s|file:///~/|file:///$HOME/|g" $CWD/scripts/cinnamon_dd.txt
mkdir -p $HOME/.cache/dermodex
mkdir -p $HOME/.local/share/dermodex
mkdir -p $HOME/.local/share/dermodex/wallpapers
mkdir -p $HOME/.themes/DermoDeX
mkdir -p $HOME/.local/bin

# IMPORT FLUENT FROM GIT
echo "[i] Installing Base Theme - Fluent"
$CWD/install-theme-base.sh

gsettings set org.cinnamon.sounds notification-enabled "true"

# SYMLINK WALLPAPERS TO PICTURES WITHOUT COPYING WALLPAPERS ACROSS
simlink? () {
  test "$(readlink "${1}")";
}

FILE=$HOME/Pictures/DermoDeX

if simlink? "${FILE}"; then
  echo " "
else
  echo "[i] Creating DermoDex Symlink in Pictures"
  ln -s $HOME/.local/share/dermodex/wallpapers $HOME/Pictures/DermoDeX
  echo "$HOME/Pictures/DermoDeX" >> "$HOME/.cinnamon/backgrounds/user-folders.lst"
fi


PS3='Choose a previous wallpaper set to install: '
names=("none" "maya" "nadia" "olivia" "petra" "qiana" "rafaela" "rebecca" "retro" "rosa" "sarah" "serena" "sonya" "sylvia" "tara" "tessa" "tina" "tricia" "ulyana" "ulyssa" "uma" "una" "vanessa" "vera")
select wall in "${names[@]}"; do
    case $wall in
        "maya")
            sudo apt install mint-backgrounds-$wall
            break
            ;;
        "nadia")
            sudo apt install mint-backgrounds-$wall
            break
            ;;
        "olivia")
            sudo apt install mint-backgrounds-$wall
            break
            ;;
        "petra")
            sudo apt install mint-backgrounds-$wall
            break
            ;;
        "qiana")
            sudo apt install mint-backgrounds-$wall
            break
            ;;
        "rafaela")
            sudo apt install mint-backgrounds-$wall
            break
            ;;
        "rebecca")
            sudo apt install mint-backgrounds-$wall
            break
            ;;
        "retro")
            sudo apt install mint-backgrounds-$wall
            break
            ;;
        "rosa")
            sudo apt install mint-backgrounds-$wall
            break
            ;;
        "sarah")
            sudo apt install mint-backgrounds-$wall
            break
            ;;
        "serena")
            sudo apt install mint-backgrounds-$wall
            break
            ;;
        "sonya")
            sudo apt install mint-backgrounds-$wall
            break
            ;;
        "sylvia")
            sudo apt install mint-backgrounds-$wall
            break
            ;;
        "tara")
            sudo apt install mint-backgrounds-$wall
            break
            ;;
        "tessa")
            sudo apt install mint-backgrounds-$wall
            break
            ;;
        "tina")
            sudo apt install mint-backgrounds-$wall
            break
            ;;
        "tricia")
            sudo apt install mint-backgrounds-$wall
            break
            ;;
        "ulyana")
            sudo apt install mint-backgrounds-$wall
            break
            ;;
        "ulyssa")
            sudo apt install mint-backgrounds-$wall
            break
            ;;
        "uma")
            sudo apt install mint-backgrounds-$wall
            break
            ;;
        "una")
            sudo apt install mint-backgrounds-$wall
            break
            ;;
        "vanessa")
            sudo apt install mint-backgrounds-$wall
            break
            ;;
        "vera")
            sudo apt install mint-backgrounds-$wall
            break
            ;;
	"none")
	    echo "[i] No wallpapers selected"
	    ;;
        *) echo "[!] Invalid wallpaper set";;
    esac
done


# GRANULAR CONTROL OVER WHICH SUB THEMES TO COPY OVER
cp -r $CWD/src/cinnamon/cinnamon-ext.css $HOME/.local/share/dermodex/
cp -r $CWD/src/headerbar.css $HOME/.local/share/dermodex/
cp -r $CWD/src/headerbar.css $HOME/.cache/dermodex/
cp -r $CWD/src/sidebar.css $HOME/.local/share/dermodex/
cp -r $CWD/src/sidebar.css $HOME/.cache/dermodex/

cp ~/.config/gtk-3.0/gtk.css ~/.config/gtk-3.0/gtk.css.backup

cp $HOME/.cinnamon/configs/menu@cinnamon.org/0.json $HOME/.cinnamon/configs/menu@cinnamon.org/0.json.bak
cp -f ./scripts/config_menu.json $HOME/.cinnamon/configs/menu@cinnamon.org/0.json
cp $HOME/.cinnamon/configs/workspace-switcher@cinnamon.org/27.json $HOME/.cinnamon/configs/workspace-switcher@cinnamon.org/27.json.bak
cp -f $CWD/scripts/config_workspace.json $HOME/.cinnamon/configs/workspace-switcher@cinnamon.org/27.json

cp -f $CWD/scripts/remix_sounds.sh $HOME/.local/share/dermodex
cp -f $CWD/scripts/remix_themes.sh $HOME/.local/share/dermodex
cp -f $CWD/scripts/remix_icons.sh $HOME/.local/share/dermodex
cp -f $CWD/scripts/remix_color.py $HOME/.local/share/dermodex
cp -f $CWD/scripts/remix_wallpapers.sh $HOME/.local/share/dermodex

cp -f $CWD/scripts/sounds_waveform.sh $HOME/.local/share/dermodex
cp -f $CWD/scripts/display_resolution.sh $HOME/.local/share/dermodex

cp -f $CWD/scripts/cinnamon_reload $HOME/.local/bin
cp -f $CWD/scripts/bin/dd_sleep.sh $HOME/.local/bin/dd_sleep
cp -f $CWD/scripts/bin/dd_wake.sh $HOME/.local/bin/dd_wake
cp -f $CWD/scripts/bin/dd_hold.sh $HOME/.local/bin/dd_hold
cp -f $CWD/scripts/bin/dd_release.sh $HOME/.local/bin/dd_release
cp -f $CWD/scripts/bin/dd_rescue.sh $HOME/.local/bin/dd_rescue
cp -f $CWD/scripts/bin/dd_reload.sh $HOME/.local/bin/dd_reload
cp -f $CWD/scripts/bin/dd_refresh.sh $HOME/.local/bin/dd_refresh
cp -f $CWD/scripts/bin/dd_swatch.sh $HOME/.local/bin/dd_swatch
cp -f $CWD/scripts/bin/dex-notify.sh $HOME/.local/bin
cp -f $CWD/scripts/bin/dex-action.sh $HOME/.local/bin
cp -f $CWD/scripts/bin/.mpris.so $HOME/.local/share/dermodex
cp -f $CWD/scripts/bin/blur_wallpaper.py $HOME/.local/bin

mkdir -p $HOME/.local/share/dermodex/rofi/themes
cp -f $CWD/scripts/rofi/dd_power.sh $HOME/.local/bin/dd_power
cp -f $CWD/scripts/rofi/dd_radio.sh $HOME/.local/bin/dd_radio
cp -f $CWD/scripts/rofi/dd_bluetooth.sh $HOME/.local/bin/dd_bluetooth
cp -f $CWD/scripts/rofi/dd_radio.json $HOME/.local/share/dermodex/rofi
cp -f $CWD/scripts/rofi/themes/*.rasi $HOME/.local/share/dermodex/rofi/themes

sudo cp -f $CWD/fonts/* /usr/share/fonts/ && fc-cache -f


cp -r $CWD/nemo/actions/*.nemo_action $HOME/.local/share/nemo/actions
cp -r $CWD/nemo/scripts/* $HOME/.local/share/nemo/scripts
cp -f $CWD/*.desktop $HOME/.config/autostart

chmod u+x $HOME/.local/bin/dd_*
chmod u+x $HOME/.local/bin/dex-*

chmod u+x $HOME/.local/share/dermodex/*.sh
mkdir -p $HOME/.local/share/icons/White-Icons/scalable/apps
mkdir -p $HOME/.local/share/dermodex/icons/breeze-dark_black/apps


cp -f $CWD/scripts/watch_sounds.sh $HOME/.local/share/dermodex
cp -f $CWD/scripts/watch_wallpaper.sh $HOME/.local/share/dermodex
cp -f $CWD/scripts/cinnamon_dd.txt $HOME/.local/share/dermodex
cp -f $CWD/scripts/config_update.py $HOME/.local/share/dermodex
cp -f $CWD/scripts/*.ini $HOME/.local/share/dermodex
cp -f $CWD/scripts/colors.py $HOME/.local/share/dermodex

# COPY OVER TERMINAL THEME
cp -f $CWD/scripts/gnome-terminal-profiles.dconf $HOME/.local/share/dermodex
cp -f $CWD/scripts/gnome-terminal-profiles.dconf $HOME/.cache/dermodex


# COPY OVER WALLPAPERS and ICONS
cp -r $CWD/wallpapers $HOME/.local/share/dermodex
cp -r $CWD/src/icons $HOME/.local/share/dermodex/

# COPY OVER THEME-EXT ASSETS
mkdir -p $HOME/.local/share/dermodex/theme-ext/cinnamon/assets/
mkdir -p $HOME/.local/share/dermodex/theme-ext/gtk/assets/
mkdir -p $HOME/.local/share/dermodex/theme-ext/gtk-2.0/assets/
cp -rf $CWD/src/cinnamon/assets/dermodex $HOME/.local/share/dermodex/theme-ext/cinnamon/assets
cp -f $CWD/scripts/remix_assets.sh $HOME/.local/share/dermodex/theme-ext/gtk
cp -f $CWD/deps/Fluent-gtk-theme/src/gtk/assets.txt $HOME/.local/share/dermodex/theme-ext/gtk
cp -f $CWD/deps/Fluent-gtk-theme/src/gtk/assets.svg $HOME/.local/share/dermodex/theme-ext/gtk
cp -f $CWD/deps/Fluent-gtk-theme/src/gtk/assets.svg $HOME/.local/share/dermodex/theme-ext/gtk/assets.orig

cp -f $CWD/deps/Fluent-gtk-theme/src/gtk-2.0/assets-folder/assets.txt $HOME/.local/share/dermodex/theme-ext/gtk-2.0
cp -f $CWD/deps/Fluent-gtk-theme/src/gtk-2.0/assets-folder/assets.svg $HOME/.local/share/dermodex/theme-ext/gtk-2.0
cp -f $CWD/deps/Fluent-gtk-theme/src/gtk-2.0/assets-folder/assets.svg $HOME/.local/share/dermodex/theme-ext/gtk-2.0/assets.orig

cp -f $CWD/src/index.theme $HOME/.local/share/dermodex/theme
cp -f $CWD/src/index.theme $HOME/.cache/dermodex
cp -f $CWD/src/cinnamon/thumbnail.png $HOME/.cache/dermodex
cp -f $CWD/src/cinnamon/thumbnail.png $HOME/.local/share/dermodex/theme/cinnamon

chmod u+x $HOME/.local/share/dermodex/theme-ext/gtk/remix_assets.sh

if [ -d $CWD/sounds ] ; then
    echo "[i] Sound Themes Already Installed ... Fetching Updates"
    cd $CWD/deps/Cinnamon-PowerToys
    git fetch
    git pull
    sleep 1
    cp -rf $CWD/deps/Cinnamon-PowerToys/sounds $CWD
    sleep 1
else
    echo "[i] Downloading Sound Themes"
    cd $CWD/deps
    #rm $CWD/sounds
    git clone --quiet https://github.com/duracell80/Cinnamon-PowerToys.git
    cp -rf $CWD/deps/Cinnamon-PowerToys/sounds $CWD
    sleep 1
fi
sudo cp -rf $CWD/sounds /usr/share
sudo chmod a+x /usr/share/sounds/scripts/set_sound_theme.sh

mkdir -p $HOME/.local/share/powertoys

cp -f $CWD/deps/Cinnamon-PowerToys/scripts/watch_trash.sh $HOME/.local/share/powertoys

# SET ANY AUTOSTART SCRIPTS FOR DESKTOP ENVIRONMENT
#for filename in $CWD/deps/Cinnamon-PowerToys/autostart/*.desktop; do
#    [ -e "$filename" ] || continue
#    file=$(echo $filename | sed -e "s|$CWD/deps/Cinnamon-PowerToys/autostart/||g")
#
#    cp -f "$filename" "$file.tmp"
#    sed -i "s|Exec=~/|Exec=$HOME/|g" "$file.tmp"
    #mv "$file.tmp" "$HOME/.config/autostart/$file"
#done
#cp -f "$CWD/deps/Cinnamon-PowerToys/Power Toys - Trash Monitor.desktop.tmp" "$HOME/.config/autostart/Power Toys - Trash Monitor.desktop"
#rm -f $CWD/deps/Cinnamon-PowerToys/*.tmp

if [ -d $CWD/deps/Color-Icons ] ; then
    echo "[i] Main Icons Already Installed ... Fetching Updates"
    cd $CWD/deps/Color-Icons
    git fetch
    git pull
    
    tar -xzf Color-Icons.tar.gz
    
    cd $CWD/deps/Royal-Z
    git fetch
    git pull
    tar -xf "Royal Z.tar.xz"
    sleep 2
else
    echo "[i] Downloading Color Icons"

    cd $CWD/deps
    git clone --quiet https://github.com/wmk69/Color-Icons
    cd $CWD/deps/Color-Icons
    tar -xzf Color-Icons.tar.gz
    sleep 5

    echo "[i] Downloading Royal Icons"
    cd $CWD/deps
    git clone --quiet https://github.com/SethStormR/Royal-Z.git
    cd $CWD/deps/Royal-Z
    tar -xf "Royal Z.tar.xz"
fi

rm -f "$CWD/deps/Royal-Z/Royal Z/apps/scalable/utilities-terminal.svg"
rm -f "$CWD/deps/Royal-Z/Royal Z/apps/scalable/org.gnome.Terminal.svg"

cp -rf "$CWD/deps/Royal-Z/Royal Z/apps/scalable" $HOME/.local/share/dermodex/icons/breeze-dark_black/
cd $CWD

cp -r $CWD/deps/Color-Icons/Color-Icons/White-Icons $HOME/.local/share/icons
cp -r $CWD/deps/Color-Icons/Color-Icons/Black-Icons $HOME/.local/share/icons

sleep 5

mkdir -p $LWD/controlpanel/cats
mkdir -p $LWD/controlpanel/apps
cp -f $CWD/deps/Color-Icons/Color-Icons/Black-Icons/scalable/mimetypes/* $CWD/deps/Color-Icons/Color-Icons/White-Icons/scalable/mimetypes

mkdir -p $HOME/.local/share/dermodex/icons/breeze-dark_black/places/outline

cp -f $CWD/deps/Color-Icons/Color-Icons/Black-Icons/scalable/places/*.svg $HOME/.local/share/dermodex/icons/breeze-dark_black/places/outline

cp -f $CWD/deps/Color-Icons/Color-Icons/White-Icons/scalable/apps/*.svg $LWD/controlpanel/apps
cp -f $CWD/deps/Color-Icons/Color-Icons/White-Icons/scalable/categories/*.svg $LWD/controlpanel/cats
cp -f $CWD/deps/Color-Icons/Color-Icons/Black-Icons/scalable/places/* $CWD/deps/Color-Icons/Color-Icons/White-Icons/scalable/places

cp -r $CWD/deps/Color-Icons/Color-Icons/White-Icons $HOME/.local/share/icons
cp -r $CWD/deps/Color-Icons/Color-Icons/Black-Icons $HOME/.local/share/icons

mkdir -p $HOME/.local/share/dermodex/icons/breeze-dark_black/mimetypes

cp -f $HOME/.local/share/icons/White-Icons/scalable/mimetypes/*.svg $HOME/.local/share/dermodex/icons/breeze-dark_black/mimetypes

cp -f $CWD/deps/Color-Icons/Color-Icons/White-Icons/scalable/apps/org.gnome.Terminal.svg "$CWD/deps/Royal-Z/Royal Z/apps/scalable"

cp -rf "$CWD/deps/Royal-Z/Royal Z/apps/scalable" $HOME/.local/share/dermodex/icons/breeze-dark_black/

mv -f $HOME/.local/share/dermodex/icons/breeze-dark_black/scalable $HOME/.local/share/dermodex/icons/breeze-dark_black/apps



if [ -d $CWD/deps/Royal-Z ] ; then
    echo "[i] Improving a few icons ..."

    APP_ICONS="${HOME}/.local/share/icons/White-Icons/scalable/apps"
    ACT_ICONS="${HOME}/.local/share/icons/White-Icons/scalable/actions"
    APP_ICONS_AUX="${CWD}/deps/Royal-Z/Royal Z/apps/scalable"
    ACT_ICONS_AUX="${CWD}/deps/Royal-Z/Royal Z/actions/scalable"

    # MEDIA CONTROLS
    cp -f "$ACT_ICONS_AUX/media-playback-pause.svg" $ACT_ICONS/media-playback-pause-symbolic.svg
fi


cp -rf $CWD/src/icons/breeze-dark_black/places $HOME/.local/share/icons/White-Icons/scalable
#cp -rf $CWD/deps/Royal-Z/Royal-Z $HOME/.local/share/icons/

cp -f "$CWD/src/icons/trash/user-trash.svg" $LWD
cp -f "$CWD/src/icons/trash/user-trash-full.svg" $LWD

mkdir -p $HOME/.cache/dermodex/icons/trash
cp -f "$CWD/src/icons/trash/user-trash.svg" $HOME/.cache/dermodex/icons/trash/user-trash.svg
cp -f "$CWD/src/icons/trash/user-trash-full.svg" $HOME/.cache/dermodex/icons/trash/user-trash-full.svg

gsettings set org.cinnamon.desktop.interface text-scaling-factor "1"

echo "[i] Adjusting The Height Of The Panels"
dconf load /org/cinnamon/ < ./scripts/cinnamon_dd.txt
dconf write /org/cinnamon/panels-height "['1:60']"

# Enhance user privacy
gsettings set org.cinnamon.desktop.privacy remember-recent-files "false"
gsettings set org.cinnamon.desktop.screensaver lock-enabled "true"
gsettings set org.cinnamon.desktop.screensaver lock-delay 0

#dd_release&
#dd_wake&

if ! type "xdotool" > /dev/null 2>&1; then
    echo "[i] Hot Keys not installed"
    notify-send --urgency=normal --category=im.receieved --icon=help-info-symbolic "Hot Keys Tool not installed ..." "Run 'sudo apt install xdotool' to automate shortcuts such as CTRL+Alt+Esc"

    echo "[i] Press Ctrl+Alt+Esc to Refresh Your Desktop ..."
    sudo apt-get install -y -q xdotool
else
    #xdotool key ctrl+alt+"Escape"
    echo "[i] Cinnamon is Ready to be reloaded by pressing CTRL+Alt+Esc!"
fi

echo ""
echo ""
echo "[i] Cinnamon Version ${CINN_VERSION}"
echo ""
echo "[i] Install Complete"
echo ""
echo "Run dd-wake to wake DermoDeX before changing the wallpaper."
echo "Run dd-hold to keep your accent colors static when changing the wallpaper"
echo "Run dd-sleep to turn DermoDeX off for this session"
echo
echo "Check the Startup Applications to toggle DermoDeX Monitor on/off at startup"
echo ""
echo "Login screen can be 'blured' using the login_blur.png file in ~/.local/share/dermodex. To do this search for Login Window in the Control Panel."
echo ""


sudo cp $CWD/fonts/* /usr/share/fonts/ && fc-cache -f

sudo mkdir -p /usr/share/backgrounds/dermodex
sudo chmod a+rw /usr/share/backgrounds/dermodex

if simlink? "${FILE}"; then
    echo "[i] DermoDeX Background Location and Sound Location Already Set"
else
    echo ""
    echo "[i] A directory in /usr/share/backgrounds needs to be writeable to allow for blured login backgrounds. A soft set of sounds from the linux-a11y sound theme project will also be dropped into the /usr/share/sounds directory. This too would need sudo to complete."
    echo ""
    echo ""
    
    sudo mkdir -p /usr/share/backgrounds/dermodex
    sudo chmod a+rw /usr/share/backgrounds/dermodex
       
fi

# COPY OVER THE EXTENSION
mkdir -p $HOME/.local/share/cinnamon/extensions/dermodex-config@duracell80
cp -rf extension/dermodex-config@duracell80/files/* $HOME/.local/share/cinnamon/extensions/dermodex-config@duracell80

sed -i "s|~/|$HOME/|g" $HOME/.local/share/cinnamon/extensions/dermodex-config@duracell80/extension.js

cd $CWD

# RELINK GTK4.0
mkdir -p "${HOME}/.config/gtk-4.0"
rm -rf "${HOME}/.config/gtk-4.0/"{assets,gtk.css,gtk-dark.css}
ln -sf "${TWD}/gtk-4.0/assets" "${HOME}/.config/gtk-4.0/assets"
ln -sf "${TWD}/gtk-4.0/gtk.css" "${HOME}/.config/gtk-4.0/gtk.css"
ln -sf "${TWD}/gtk-4.0/gtk-dark.css" "${HOME}/.config/gtk-4.0/gtk-dark.css"


# RENAME WHITE ICONS AS DERMODEX
rm -rf $HOME/.local/share/icons/DermoDeX
mv -f $HOME/.local/share/icons/White-Icons $HOME/.local/share/icons/DermoDeX 
sed -i "s|White-Icons|DermoDeX|g" $HOME/.local/share/icons/DermoDeX/index.theme

gsettings set org.gnome.Terminal.Legacy.Settings theme-variant "dark"
gsettings set org.cinnamon.desktop.interface icon-theme "DermoDeX"
gsettings set org.cinnamon.desktop.interface gtk-theme "DermoDeX"
gsettings set org.cinnamon.desktop.wm.preferences theme "DermoDeX"
gsettings set org.cinnamon.theme name "DermoDeX"
gsettings set org.cinnamon.desktop.notifications bottom-notifications "true"
gsettings set org.cinnamon.desktop.notifications display-notifications "true"


# SOUND - FRESH DREAM
/usr/share/sounds/scripts/set_sound_theme.sh harmony


dd_refresh
