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
elif [ "$soundnotification" == "pixel-birdsong" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Pixel Sounds/Birdsong.ogg'
elif [ "$soundnotification" == "pixel-absurdbird" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Play It Loud/Absurd Bird.ogg'
elif [ "$soundnotification" == "pixel-chefsspecial" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Play It Loud/Chef_s Special.ogg'
elif [ "$soundnotification" == "pixel-crosswalk" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Play It Loud/Crosswalk.ogg'
elif [ "$soundnotification" == "pixel-cyclist" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Play It Loud/Cyclist.ogg'
elif [ "$soundnotification" == "pixel-dj" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Play It Loud/DJ.ogg'
elif [ "$soundnotification" == "pixel-doorbell" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Play It Loud/Doorbell.ogg'
elif [ "$soundnotification" == "pixel-grandopening" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Play It Loud/Grand Opening.ogg'
elif [ "$soundnotification" == "pixel-honkhonk" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Play It Loud/Honk Honk.ogg'
elif [ "$soundnotification" == "pixel-nightlife" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Play It Loud/Nightlife.ogg'
elif [ "$soundnotification" == "pixel-nightsky" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Play It Loud/Night Sky.ogg'
elif [ "$soundnotification" == "pixel-rockconcert" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Play It Loud/Rock Concert.ogg'
elif [ "$soundnotification" == "pixel-welcome" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Play It Loud/Welcome.ogg'
elif [ "$soundnotification" == "pixel-bellhop" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Reality Bytes/Bellhop.ogg'
elif [ "$soundnotification" == "pixel-bikeride" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Reality Bytes/Bike Ride.ogg'
elif [ "$soundnotification" == "pixel-blacksmith" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Reality Bytes/Blacksmith.ogg'
elif [ "$soundnotification" == "pixel-cowbell" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Reality Bytes/Cowbell.ogg'
elif [ "$soundnotification" == "pixel-cointoss" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Reality Bytes/Coin Toss.ogg'
elif [ "$soundnotification" == "pixel-fraidycat" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Reality Bytes/Fraidy Cat.ogg'
elif [ "$soundnotification" == "pixel-gibboncall" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Reality Bytes/Gibbon Call.ogg'
elif [ "$soundnotification" == "pixel-guardianangel" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Reality Bytes/Guardian Angel.ogg'
elif [ "$soundnotification" == "pixel-magictrick" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Reality Bytes/Magic Trick.ogg'
elif [ "$soundnotification" == "pixel-paperclip" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Reality Bytes/Paper Clip.ogg'
elif [ "$soundnotification" == "pixel-pingpong" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Reality Bytes/Ping-Pong.ogg'
elif [ "$soundnotification" == "pixel-sadtrombone" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Reality Bytes/Sad Trombone.ogg'
elif [ "$soundnotification" == "pixel-swansong" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Reality Bytes/Swan Song.ogg'
elif [ "$soundnotification" == "pixel-tropicalfrog" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Reality Bytes/Tropical Frog.ogg'
elif [ "$soundnotification" == "pixel-welcome" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Reality Bytes/Welcome.ogg'
elif [ "$soundnotification" == "pixel-bolt" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Retro Riffs/Bolt.ogg'
elif [ "$soundnotification" == "pixel-boomerang" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Retro Riffs/Boomerang.ogg'
elif [ "$soundnotification" == "pixel-bubble" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Retro Riffs/Bubble.ogg'
elif [ "$soundnotification" == "pixel-coins" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Retro Riffs/Coins.ogg'
elif [ "$soundnotification" == "pixel-gems" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Retro Riffs/Gems.ogg'
elif [ "$soundnotification" == "pixel-jackpot" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Retro Riffs/Jackpot.ogg'
elif [ "$soundnotification" == "pixel-magic" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Retro Riffs/Magic.ogg'
elif [ "$soundnotification" == "pixel-portal" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Retro Riffs/Portal.ogg'
elif [ "$soundnotification" == "pixel-reward" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Retro Riffs/Reward.ogg'
elif [ "$soundnotification" == "pixel-spell" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Retro Riffs/Spell.ogg'
elif [ "$soundnotification" == "pixel-unlock" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Retro Riffs/Unlock.ogg'
elif [ "$soundnotification" == "pixel-bemine" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Seasonal Celebrations/Be Mine.ogg'
elif [ "$soundnotification" == "pixel-champagnepop" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Seasonal Celebrations/Champagne Pop.ogg'
elif [ "$soundnotification" == "pixel-cheers" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Seasonal Celebrations/Cheers.ogg'
elif [ "$soundnotification" == "pixel-eerie" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Seasonal Celebrations/Eerie.ogg'
elif [ "$soundnotification" == "pixel-gobblegobble" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Seasonal Celebrations/Gobble Gobble.ogg'
elif [ "$soundnotification" == "pixel-holidaymagic" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Seasonal Celebrations/Holiday Magic.ogg'
elif [ "$soundnotification" == "pixel-partyfavor" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Seasonal Celebrations/Party Favor.ogg'
elif [ "$soundnotification" == "pixel-sleighbells" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Seasonal Celebrations/Sleigh Bells.ogg'
elif [ "$soundnotification" == "pixel-snowflake" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Seasonal Celebrations/Snowflake.ogg'
elif [ "$soundnotification" == "pixel-summersurf" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Seasonal Celebrations/Summer Surf.ogg'
elif [ "$soundnotification" == "pixel-sweatheart" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Seasonal Celebrations/Sweetheart.ogg'
elif [ "$soundnotification" == "pixel-winterwind" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Seasonal Celebrations/Winter Wind.ogg'
elif [ "$soundnotification" == "pixel-chime" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Pixel Sounds/Chime.ogg'
elif [ "$soundnotification" == "pixel-clink" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Pixel Sounds/Clink.ogg'
elif [ "$soundnotification" == "pixel-flick" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Pixel Sounds/Flick.ogg'
elif [ "$soundnotification" == "pixel-hey" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Pixel Sounds/Hey.ogg'
elif [ "$soundnotification" == "pixel-note" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Pixel Sounds/Note.ogg'
elif [ "$soundnotification" == "pixel-strum" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Pixel Sounds/Strum.ogg'
elif [ "$soundnotification" == "pixel-trill" ]; then
    gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/teampixel/notifications/Pixel Sounds/Trill.ogg'
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