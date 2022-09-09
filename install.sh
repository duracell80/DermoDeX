#!/bin/bash


CINN_VERSION=$(cinnamon --version)

echo "[i] - Installing Deps from APT and PIP"
sudo apt install -y python3-pip libsass1 sassc rofi scrot imagemagick xz-utils xdotool ffmpeg inkscape


pip3 install easydev
pip3 install colormap
pip3 install pandas
pip3 install numpy
pip3 install colorgram.py
pip3 install extcolors
pip3 install matplotlib
pip3 install configparser
pip3 install xdisplayinfo

echo "[i] - Backing Up Current Cinnamon Configuration"
dconf dump /org/cinnamon/ > $HOME/cinnamon_desktop.backup

CWD=$(pwd)
LWD=$HOME/.local/share/dermodex/icons/breeze-dark_black
TWD=$HOME/.themes/DermoDeX

sed -i "s|file:///~/|file:///$HOME/|g" $CWD/scripts/cinnamon_dd.txt
mkdir -p ~/.local/share/dermodex
mkdir -p ~/.local/share/dermodex/wallpapers
mkdir -p ~/.themes/DermoDeX
mkdir -p ~/.local/bin

# IMPORT FLUENT FROM GIT
echo "[i] Installing Base Theme - Fluent"
$CWD/install-theme-base.sh

gsettings set org.cinnamon.sounds notification-enabled "true"

# SYMLINK WALLPAPERS TO PICTURES WITHOUT COPYING WALLPAPERS ACROSS
simlink? () {
  test "$(readlink "${1}")";
}

FILE=~/Pictures/DermoDeX

if simlink? "${FILE}"; then
  echo " "
else
  echo "[i] Creating DermoDex Symlink in Pictures"
  ln -s ~/.local/share/dermodex/wallpapers ~/Pictures/DermoDeX
  echo "$HOME/Pictures/DermoDeX" >> "$HOME/.cinnamon/backgrounds/user-folders.lst"
fi




# GRANULAR CONTROL OVER WHICH SUB THEMES TO COPY OVER
cp -r $CWD/src/cinnamon/cinnamon-ext.css ~/.local/share/dermodex/

cp ~/.cinnamon/configs/menu@cinnamon.org/0.json ~/.cinnamon/configs/menu@cinnamon.org/0.json.bak
cp -f ./scripts/config_menu.json ~/.cinnamon/configs/menu@cinnamon.org/0.json
cp ~/.cinnamon/configs/workspace-switcher@cinnamon.org/27.json ~/.cinnamon/configs/workspace-switcher@cinnamon.org/27.json.bak
cp -f ./scripts/config_workspace.json ~/.cinnamon/configs/workspace-switcher@cinnamon.org/27.json

#cp -f ./scripts/cinnamon_base.css ~/.local/share/dermodex
cp -f ./scripts/remix_sounds.sh ~/.local/share/dermodex
cp -f ./scripts/remix_themes.sh ~/.local/share/dermodex
cp -f ./scripts/remix_icons.sh ~/.local/share/dermodex
cp -f ./scripts/remix_color.py ~/.local/share/dermodex

cp -f ./scripts/sounds_waveform.sh ~/.local/share/dermodex
cp -f ./scripts/display_resolution.sh ~/.local/share/dermodex

cp -f ./scripts/cinnamon_reload ~/.local/bin
cp -f ./scripts/bin/dd_sleep.sh ~/.local/bin/dd_sleep
cp -f ./scripts/bin/dd_wake.sh ~/.local/bin/dd_wake
cp -f ./scripts/bin/dd_hold.sh ~/.local/bin/dd_hold
cp -f ./scripts/bin/dd_release.sh ~/.local/bin/dd_release
cp -f ./scripts/bin/dd_rescue.sh ~/.local/bin/dd_rescue
cp -f ./scripts/bin/dd_reload.sh ~/.local/bin/dd_reload
cp -f ./scripts/bin/dd_refresh.sh ~/.local/bin/dd_refresh
cp -f ./scripts/bin/dd_swatch.sh ~/.local/bin/dd_swatch
cp -f ./scripts/bin/dex-notify.sh ~/.local/bin
cp -f ./scripts/bin/dex-action.sh ~/.local/bin
cp -f ./scripts/bin/.mpris.so ~/.local/share/dermodex


mkdir -p $HOME/.local/share/dermodex/rofi/themes
cp -f ./scripts/rofi/dd_power.sh ~/.local/bin/dd_power
cp -f ./scripts/rofi/dd_radio.sh ~/.local/bin/dd_radio
cp -f ./scripts/rofi/dd_radio.json ~/.local/share/dermodex/rofi
cp -f ./scripts/rofi/themes/*.rasi ~/.local/share/dermodex/rofi/themes



cp -r ./nemo/actions/*.nemo_action ~/.local/share/nemo/actions
cp -r ./nemo/scripts/* ~/.local/share/nemo/scripts
cp -f ./*.desktop ~/.config/autostart

chmod u+x ~/.local/share/dermodex/*.sh
mkdir -p $HOME/.local/share/icons/White-Icons/scalable/apps
mkdir -p $HOME/.local/share/dermodex/icons/breeze-dark_black/apps


cp -f $CWD/scripts/watch_sounds.sh ~/.local/share/dermodex
cp -f $CWD/scripts/watch_wallpaper.sh ~/.local/share/dermodex
cp -f $CWD/scripts/cinnamon_dd.txt ~/.local/share/dermodex
cp -f $CWD/scripts/config_update.py ~/.local/share/dermodex
cp -f $CWD/scripts/*.ini ~/.local/share/dermodex
cp -f $CWD/scripts/colors.py ~/.local/share/dermodex


# COPY OVER WALLPAPERS and ICONS
cp -r $CWD/wallpapers $HOME/.local/share/dermodex
cp -r $CWD/src/icons $HOME/.local/share/dermodex/

# COPY OVER THEME-EXT ASSETS
mkdir -p $HOME/.local/share/dermodex/theme-ext/cinnamon/assets/
mkdir -p $HOME/.local/share/dermodex/theme-ext/gtk/assets/
cp -rf $CWD/src/cinnamon/assets/dermodex $HOME/.local/share/dermodex/theme-ext/cinnamon/assets
cp -f $CWD/scripts/remix_assets.sh $HOME/.local/share/dermodex/theme-ext/gtk
cp -f $CWD/deps/Fluent-gtk-theme/src/gtk/assets.txt $HOME/.local/share/dermodex/theme-ext/gtk
cp -f $CWD/deps/Fluent-gtk-theme/src/gtk/assets.svg $HOME/.local/share/dermodex/theme-ext/gtk
cp -f $CWD/deps/Fluent-gtk-theme/src/gtk/assets.svg $HOME/.local/share/dermodex/theme-ext/gtk/assets.orig




if [ -d $CWD/deps/Color-Icons ] ; then
    echo "[i] Main Icons Already Installed"
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

gsettings set org.cinnamon.desktop.interface icon-theme "White-Icons"
#gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y-Dark-Aqua"
#gsettings set org.cinnamon.desktop.wm.preferences theme "Mint-Y"
#gsettings set org.cinnamon.theme name "Mint-Y-Dark-Aqua"
gsettings set org.cinnamon.desktop.notifications bottom-notifications "true"
gsettings set org.cinnamon.desktop.notifications display-notifications "true"

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


# SOUND - ZORIN
sudo cp -fr $CWD/sounds/zorin/ /usr/share/sounds/
sudo chmod -R a+rx /usr/share/sounds/zorin/

# SOUND - X11
sudo cp -fr $CWD/sounds/x11/ /usr/share/sounds/
sudo chmod -R a+rx /usr/share/sounds/x11/

# SOUND - X10
sudo cp -fr $CWD/sounds/x10/ /usr/share/sounds/
sudo chmod -R a+rx /usr/share/sounds/x10/

# SOUND - XXP
sudo cp -fr $CWD/sounds/xxp/ /usr/share/sounds/
sudo chmod -R a+rx /usr/share/sounds/xxp/

# SOUND - MIUI
sudo cp -fr $CWD/sounds/miui/ /usr/share/sounds/
sudo chmod -R a+rx /usr/share/sounds/miui/

# SOUND - DEEPIN
sudo cp -fr $CWD/sounds/deepin/ /usr/share/sounds/
sudo chmod -R a+rx /usr/share/sounds/deepin/

# SOUND - Enchanted
sudo cp -fr $CWD/sounds/enchanted/ /usr/share/sounds/
sudo chmod -R a+rx /usr/share/sounds/enchanted/

# SOUND - Borealis
sudo cp -fr $CWD/sounds/borealis/ /usr/share/sounds/
sudo chmod -R a+rx /usr/share/sounds/borealis/

# SOUND - HARMONY
sudo cp -fr $CWD/sounds/harmony/ /usr/share/sounds/
sudo chmod -R a+rx /usr/share/sounds/harmony/

# SOUND - Fresh Dream
sudo cp -fr $CWD/sounds/dream/ /usr/share/sounds/
sudo chmod -R a+rx /usr/share/sounds/dream/

# SOUND - LINUX-A11Y
sudo cp -fr $CWD/sounds/linux-a11y/ /usr/share/sounds/
sudo chmod -R a+rx /usr/share/sounds/linux-a11y/

# SOUND - LINUX-UBUNTU
sudo cp -fr $CWD/sounds/linux-ubuntu/ /usr/share/sounds/
sudo chmod -R a+rx /usr/share/sounds/linux-ubuntu/

# SOUND - NIGHTLY NEWS
sudo cp -fr $CWD/sounds/nightlynews/ /usr/share/sounds/
sudo chmod -R a+rx /usr/share/sounds/nightlynews/

# SOUND - Team Pixel
sudo cp -fr $CWD/sounds/teampixel/ /usr/share/sounds/
sudo chmod -R a+rx /usr/share/sounds/teampixel/

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
    
    #cd ~/.cache/dermodex/common-assets/sounds/
    #git clone --quiet https://github.com/coffeeking/linux-a11y-sound-theme.git
    
    sudo mkdir -p /usr/share/backgrounds/dermodex
    sudo chmod a+rw /usr/share/backgrounds/dermodex
    #sudo cp -fr ~/.cache/dermodex/common-assets/sounds/linux-a11y-sound-theme/linux-a11y/ /usr/share/sounds/

    
    # SOUND - LINUX-A11Y
    #gsettings set org.cinnamon.sounds tile-file /usr/share/sounds/linux-a11y/stereo/window-switch.oga
    #gsettings set org.cinnamon.sounds plug-file /usr/share/sounds/linux-a11y/stereo/message-sent.oga
    #gsettings set org.cinnamon.sounds unplug-file /usr/share/sounds/linux-a11y/stereo/message.oga
    #gsettings set org.cinnamon.sounds close-file /usr/share/sounds/linux-a11y/stereo/tooltip-popup.oga
    #gsettings set org.cinnamon.sounds map-file /usr/share/sounds/linux-a11y/stereo/tooltip-popup.oga
    #gsettings set org.cinnamon.sounds minimize-file /usr/share/sounds/linux-a11y/stereo/window-minimized.oga
    #gsettings set org.cinnamon.sounds logout-file /usr/share/sounds/linux-a11y/stereo/desktop-logout.oga
    #gsettings set org.cinnamon.sounds maximize-file /usr/share/sounds/linux-a11y/stereo/window-minimized.oga
    #gsettings set org.cinnamon.sounds switch-file /usr/share/sounds/linux-a11y/stereo/menu-popup.oga
    #gsettings set org.cinnamon.sounds notification-file /usr/share/sounds/linux-a11y/stereo/window-attention.oga
    #gsettings set org.cinnamon.sounds unmaximize-file /usr/share/sounds/linux-a11y/stereo/window-minimized.oga
    #gsettings set org.cinnamon.sounds login-file /usr/share/sounds/linux-a11y/stereo/desktop-login.oga
    
    # SOUND - ZORIN
    #gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/zorin/stereo/button-pressed.ogg'
    #gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/zorin/stereo/device-added.oga'
    #gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/zorin/stereo/device-removed.oga'
    #gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/zorin/stereo/message.ogg'
    #gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/zorin/stereo/message.ogg'
    #gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/zorin/stereo/button-toggle-off.ogg'
    #gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/zorin/stereo/desktop-login.ogg'
    #gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/zorin/stereo/button-toggle-on.ogg'
    #gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/zorin/stereo/window-slide.ogg'
    #gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/zorin/stereo/message-new-instant.ogg'
    #gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/zorin/stereo/button-toggle-off.ogg'
    #gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/zorin/stereo/desktop-logout.ogg'

    # SOUND - miui
    #gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/miui/stereo/dialog-information.ogg'
    #gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/miui/stereo/power-plug.ogg'
    #gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/miui/stereo/power-unplug.ogg'
    #gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/miui/stereo/window-close.ogg'
    #gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/miui/stereo/window-close.ogg'
    #gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/miui/stereo/window-close.ogg'
    #gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/miui/stereo/device-removed.ogg'
    #gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/miui/stereo/window-close.ogg'
    #gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/miui/stereo/count-down.ogg'
    #gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/miui/stereo/message-sent-instant.ogg'
    #gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/miui/stereo/window-close.ogg'
    #gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/miui/stereo/device-added.ogg'
    
    # SOUND - deepin
    #gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/deepin/dialog-error-critical.ogg'
    #gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/deepin/device-added.ogg'
    #gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/deepin/device-removed.ogg'
    #gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/deepin/power-unplug.ogg'
    #gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/deepin/audio-volume-change.ogg'
    #gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/deepin/dialog-error-serious.ogg'
    #gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/deepin/system-shutdown.ogg'
    #gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/deepin/dialog-error-serious.ogg'
    #gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/deepin/audio-volume-change.ogg'
    #gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/deepin/suspend-resume.ogg'
    #gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/deepin/dialog-error-serious.ogg'
    #gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/deepin/desktop-login.ogg'
    
    # SOUND - harmony
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
    
    # SOUND - TEAM PIXEL - GOOGLE
    #gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/teampixel/navigation_backward-selection.ogg'
    #gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/teampixel/notifications/Classical Harmonies/Spring Strings.ogg'
    #gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/teampixel/Asteroid.ogg'
    #gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/teampixel/ui_loading.ogg'
    #gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/teampixel/navigation-cancel.ogg'
    #gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/teampixel/navigation-cancel.ogg'
    #gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notification_simple-01.ogg'
    #gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/teampixel/state-change_confirm-up.ogg'
    #gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/teampixel/navigation_transition-right.ogg'
    #gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/teampixel/navigation_unavailable-selection.ogg'
    #gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/teampixel/navigation_transition-left.ogg'
    #gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/teampixel/state-change_confirm-down.ogg'
    
fi

# COPY OVER THE EXTENSION
mkdir -p ~/.local/share/cinnamon/extensions/dermodex-config@duracell80
cp -rf extension/dermodex-config@duracell80/files/* ~/.local/share/cinnamon/extensions/dermodex-config@duracell80

sed -i "s|~/|$HOME/|g" $HOME/.local/share/cinnamon/extensions/dermodex-config@duracell80/extension.js

#rm -rf $CWD/deps/Color-Icons

cd $CWD

# RELINK GTK4.0
mkdir -p "${HOME}/.config/gtk-4.0"
rm -rf "${HOME}/.config/gtk-4.0/"{assets,gtk.css,gtk-dark.css}
ln -sf "${TWD}/gtk-4.0/assets" "${HOME}/.config/gtk-4.0/assets"
ln -sf "${TWD}/gtk-4.0/gtk.css" "${HOME}/.config/gtk-4.0/gtk.css"
ln -sf "${TWD}/gtk-4.0/gtk-dark.css" "${HOME}/.config/gtk-4.0/gtk-dark.css"

#dd_reload
