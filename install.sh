#!/bin/bash


CINN_VERSION=$(cinnamon --version)

#sudo apt install -y -q python3-pip libsass1 sassc rofi scrot imagemagick
#sudo apt install -y -q xz-utils xdotool ffmpeg


#pip3 install easydev
#pip3 install colormap
#pip3 install pandas
#pip3 install numpy
#pip3 install colorgram.py
#pip3 install extcolors
#pip3 install matplotlib
#pip3 install configparser
#pip3 install xdisplayinfo

#dconf dump /org/cinnamon/ > $HOME/cinnamon_desktop.backup

#dd_sleep
CWD=$(pwd)
LWD=$HOME/.local/share/dermodex/icons/breeze-dark_black

#sed -i "s|file:///~/|file:///$HOME/|g" $CWD/scripts/cinnamon_dd.txt
#mkdir -p ~/.local/share/dermodex
#mkdir -p ~/.local/share/dermodex/wallpapers
#mkdir -p ~/.themes/DermoDeX

# IMPORT FLUENT FROM GIT
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



#cp ~/.cinnamon/configs/menu@cinnamon.org/0.json ~/.cinnamon/configs/menu@cinnamon.org/0.json.bak
#cp -f ./scripts/config_menu.json ~/.cinnamon/configs/menu@cinnamon.org/0.json
#cp ~/.cinnamon/configs/workspace-switcher@cinnamon.org/27.json ~/.cinnamon/configs/workspace-switcher@cinnamon.org/27.json.bak
#cp -f ./scripts/config_workspace.json ~/.cinnamon/configs/workspace-switcher@cinnamon.org/27.json

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
cp -rf $CWD/src/cinnamon/assets/dermodex $HOME/.local/share/dermodex/theme-ext/cinnamon/assets





if [ -d $CWD/deps/Color-Icons ] ; then
    echo "[i] Main Icons Already Installed"
    #cp -r $CWD/deps/Color-Icons/Color-Icons/White-Icons $HOME/.local/share/icons
	#cp -r $CWD/deps/Color-Icons/Color-Icons/Black-Icons $HOME/.local/share/icons
    
    #cp -f $HOME/.local/share/icons/White-Icons/scalable/apps/csd-* $HOME/.local/share/dermodex/icons/breeze-dark_black/apps
    
    #cp -f $HOME/.local/share/icons/White-Icons/scalable/categories/*.svg $HOME/.local/share/dermodex/icons/breeze-dark_black/cats
    
    cp -rf "$CWD/deps/Royal-Z/Royal Z/apps/scalable" $HOME/.local/share/dermodex/icons/breeze-dark_black/
    
    #mv -f $HOME/.local/share/dermodex/icons/breeze-dark_black/apps/scalable/* $HOME/.local/share/dermodex/icons/breeze-dark_black/apps
    
    rm -rf $HOME/.local/share/dermodex/icons/breeze-dark_black/apps/scalable/
    
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
    
    rm -f "$CWD/deps/Royal-Z/Royal Z/apps/scalable/utilities-terminal.svg"
    rm -f "$CWD/deps/Royal-Z/Royal Z/apps/scalable/org.gnome.Terminal.svg"
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
    
    mv -f $HOME/.local/share/dermodex/icons/breeze-dark_black/scalable/apps $HOME/.local/share/dermodex/icons/breeze-dark_black/apps
    
    
    
fi



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

#gsettings set org.cinnamon.desktop.interface icon-theme "White-Icons"
#gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y-Dark-Aqua"
#gsettings set org.cinnamon.desktop.wm.preferences theme "Mint-Y"
#gsettings set org.cinnamon.theme name "Mint-Y-Dark-Aqua"
#gsettings set org.cinnamon.desktop.notifications bottom-notifications "true"
#gsettings set org.cinnamon.desktop.notifications display-notifications "true"

# gsettings set org.cinnamon.desktop.interface text-scaling-factor "1"

echo "[i] Adjusting The Height Of The Panels"
#dconf load /org/cinnamon/ < ./scripts/cinnamon_dd.txt
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

#mkdir -p ~/.cache/dermodex/common-assets/sounds/

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

# SOUND - MACOS
sudo cp -fr $CWD/sounds/macos/ /usr/share/sounds/
sudo chmod -R a+rx /usr/share/sounds/macos/

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
    
    
    # SOUND - LINUX-UBUNTU
    #gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/linux-ubuntu/question.ogg'
    #gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/linux-ubuntu/disconnect.ogg'
    #gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/linux-ubuntu/connect.ogg'
    #gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/linux-ubuntu/default.ogg'
    #gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/linux-ubuntu/default.ogg'
    #gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/linux-ubuntu/menu-popup.ogg'
    #gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/linux-a11y/stereo/desktop-logout.oga'
    #gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/linux-ubuntu/menu-popup.ogg'
    #gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/linux-ubuntu/default.ogg'
    #gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/linux-ubuntu/new-mail.ogg'
    #gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/linux-ubuntu/menu-popup.ogg'
    #gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/linux-a11y/stereo/desktop-login.oga'
    
    # SOUND - MACOS
    #gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/macos/restore-up.ogg'
    #gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/macos/device-connect.ogg'
    #gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/macos/device-disconnect.ogg'
    #gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/macos/open.ogg'
    #gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/macos/close.ogg'
    #gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/macos/minimize.ogg'
    #gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/macos/logoff.ogg'
    #gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/macos/maximize.ogg'
    #gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/macos/close.ogg'
    #gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/macos/contact-online.ogg'
    #gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/macos/restore-down.ogg'
    #gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/macos/logon.ogg'
    
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
    
    # SOUND - x11
    #gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/x11/stereo/system-ready.ogg'
    #gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/x11/stereo/device-added.ogg'
    #gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/x11/stereo/device-removed.ogg'
    #gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/x11/stereo/camera-shutter.ogg'
    #gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/x11/stereo/camera-shutter.ogg'
    #gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/x11/stereo/camera-shutter.ogg'
    #gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/x11/stereo/desktop-login.ogg'
    #gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/x11/stereo/camera-shutter.ogg'
    #gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/x11/stereo/camera-shutter.ogg'
    #gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/x11/stereo/message-new-instant.ogg'
    #gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/x11/stereo/camera-shutter.ogg'
    #gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/x11/stereo/complete.ogg'
    
    # SOUND - x10
    #gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/x10/feed-discovered.ogg'
    #gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/x10/hardware-insert.ogg'
    #gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/x10/hardware-remove.ogg'
    #gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/x10/battery-low.ogg'
    #gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/x10/print-complete.ogg'
    #gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/x10/minimize.ogg'
    #gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/x10/linux-shutdown.ogg'
    #gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/x10/minimize.ogg'
    #gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/x10/navigation -start.ogg'
    #gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/x10/notify-system-generic.ogg'
    #gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/x10/minimize.ogg'
    #gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/x10/logon.ogg'
    
    # SOUND - xxp
    #gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/xxp/ding.ogg'
    #gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/xxp/logon.ogg'
    #gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/xxp/logoff.ogg'
    #gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/xxp/menu-command.ogg'
    #gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/xxp/open-program.ogg'
    #gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/xxp/maximize.ogg'
    #gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/xxp/shutdown.ogg'
    #gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/xxp/maximize.ogg'
    #gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/xxp/menu-popup.ogg'
    #gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/xxp/notify.ogg'
    #gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/xxp/restore.ogg'
    #gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/xxp/start-linux.ogg'

    
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
    
    # SOUND - enchanted
    #gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/enchanted/bell.ogg'
    #gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/enchanted/dialog-question.ogg'
    #gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/enchanted/dialog-error.ogg'
    #gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/enchanted/button-released.ogg'
    #gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/enchanted/menu-replace.ogg'
    #gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/enchanted/window-minimized.ogg'
    #gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/enchanted/button-toggle-on.ogg'
    #gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/enchanted/window-maximized.ogg'
    #gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/enchanted/window-switch.ogg'
    #gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/enchanted/message-sent-instant.ogg'
    #gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/enchanted/window-unmaximized.ogg'
    #gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/enchanted/system-ready.ogg'
    
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
    
    # SOUND - harmony
    #gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/harmony/restore.ogg'
    #gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/harmony/network-added.ogg'
    #gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/harmony/network-removed.ogg'
    #gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/harmony/dialog-information.oga'
    #gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/harmony/dialog-question.oga'
    #gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/harmony/window-new.oga'
    #gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/harmony/desktop-logout.oga'
    #gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/harmony/window-new.oga'
    #gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/harmony/window-new.oga'
    #gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/harmony/notification-brighter.ogg'
    #gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/harmony/window-new.oga'
    #gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/harmony/desktop-login.oga'
    
    # SOUND - NIGHTLY NEWS - J.WILLIAMS
    #gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/nightlynews/click.ogg'
    #gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/nightlynews/login.ogg'
    #gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/nightlynews/logout.ogg'
    #gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/nightlynews/click.ogg'
    #gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/nightlynews/click.ogg'
    #gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/nightlynews/click.ogg'
    #gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/nightlynews/chimes.ogg'
    #gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/nightlynews/click.ogg'
    #gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/linux-a11y/stereo/window-new.oga'
    #gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/nightlynews/click.ogg'
    #gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/nightlynews/click.ogg'
    #gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/nightlynews/click.ogg'
    
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
#rm -rf ~/.cache/dermodex/common-assets/sounds/linux-a11y-sound-theme

cd $CWD
#cd $CWD/deps

#echo ""
#echo "[i] Finally we need to install a theme customizer called themix (oomox), you may need to configure this with dpkg to get all the dependencies met. DermoDeX believes in you!"
#echo ""
#echo ""
#sudo dpkg -i oomox_1.13.3_18.10+.deb
#sudo apt --fix-broken install

#dd_reload
