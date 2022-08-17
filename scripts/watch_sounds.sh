#!/usr/bin/env bash
# READ THE UPDATED CONFIG
CONF_FILE="$HOME/.local/share/dermodex/config.ini"
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

elif [ "$soundtheme" == "x11" ]; then
    # SOUND - Windows 11
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