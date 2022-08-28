#!/usr/bin/env bash
soundnotification=$1

# SET SOUNDS
if [ "$soundnotification" == "teampixel" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notification_simple-01.ogg'
elif [ "$soundnotification" == "pixel-keys" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Classical Harmonies/Changing Keys.ogg'
elif [ "$soundnotification" == "pixel-flourish" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Classical Harmonies/Piano Flourish.ogg'
elif [ "$soundnotification" == "pixel-flutter" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Classical Harmonies/Piano Flutter.ogg'
elif [ "$soundnotification" == "pixel-carbonate" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Material Adventures/Carbonate.ogg'
elif [ "$soundnotification" == "pixel-discovery" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Material Adventures/Discovery.ogg'
elif [ "$soundnotification" == "pixel-epiphany" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Material Adventures/Epiphany.ogg'
elif [ "$soundnotification" == "pixel-everblue" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Material Adventures/Everblue.ogg'
elif [ "$soundnotification" == "pixel-gradient" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Material Adventures/Gradient.ogg'
elif [ "$soundnotification" == "pixel-lota" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Material Adventures/Lota.ogg'
elif [ "$soundnotification" == "pixel-moondrop" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Material Adventures/Moondrop.ogg'
elif [ "$soundnotification" == "pixel-plonk" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Material Adventures/Plonk.ogg'
elif [ "$soundnotification" == "pixel-scamper" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Material Adventures/Scamper.ogg'
elif [ "$soundnotification" == "pixel-shuffle" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Material Adventures/Shuffle.ogg'
elif [ "$soundnotification" == "pixel-sunflower" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Material Adventures/Sunflower.ogg'
elif [ "$soundnotification" == "pixel-teapot" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Material Adventures/Teapot.ogg'
elif [ "$soundnotification" == "x11" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/x11/stereo/message-new-instant.ogg'
elif [ "$soundnotification" == "x10" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/x10/notify-system-generic.ogg'
elif [ "$soundnotification" == "xxp" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/xxp/notify.ogg'   
elif [ "$soundnotification" == "macos" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/macos/contact-online.ogg'
elif [ "$soundnotification" == "mint20" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/LinuxMint/stereo/system-ready.ogg'
elif [ "$soundnotification" == "miui" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/miui/stereo/message-sent-instant.ogg'
elif [ "$soundnotification" == "deepin" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/deepin/suspend-resume.ogg'
elif [ "$soundnotification" == "enchanted" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/enchanted/message-sent-instant.ogg'
elif [ "$soundnotification" == "borealis" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/borealis/notification.ogg'
elif [ "$soundnotification" == "harmony" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/harmony/notification-brighter.ogg'
elif [ "$soundnotification" == "ubuntu-original" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/linux-ubuntu/new-mail.ogg'
elif [ "$soundnotification" == "nightlynews" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/nightlynews/chimes.ogg'
elif [ "$soundnotification" == "zorin" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/zorin/stereo/message-new-instant.ogg'
else
    $HOME/.local/share/dermodex/watch_sounds.sh
fi