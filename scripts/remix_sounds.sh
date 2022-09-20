#!/usr/bin/env bash
# remix_sounds.sh <name=notification|osd> <name=mint20>

type=$1
name=$2

DIR_SOUND="/usr/share/sounds"
APP_SOUND="notification.ogg"

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

echo $name

# SET SOUNDS

if [ "$type" == "notification" ]; then

    if [ "$name" == "linux-a11y" ]; then
        APP_SOUND="$DIR_SOUND/linux-a11y/stereo/window-attention.oga"
    elif [ "$name" == "teampixel" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notification_simple-01.ogg"
    elif [ "$name" == "pixel-keys" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Classical Harmonies/Changing Keys.ogg"
    elif [ "$name" == "pixel-flourish" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Classical Harmonies/Piano Flourish.ogg"
    elif [ "$name" == "pixel-flutter" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Classical Harmonies/Piano Flutter.ogg"
    elif [ "$name" == "pixel-carbonate" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Material Adventures/Carbonate.ogg"
    elif [ "$name" == "pixel-discovery" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Material Adventures/Discovery.ogg"
    elif [ "$name" == "pixel-epiphany" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Material Adventures/Epiphany.ogg"
    elif [ "$name" == "pixel-everblue" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Material Adventures/Everblue.ogg"
    elif [ "$name" == "pixel-gradient" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Material Adventures/Gradient.ogg"
    elif [ "$name" == "pixel-lota" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Material Adventures/Lota.ogg"
    elif [ "$name" == "pixel-moondrop" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Material Adventures/Moondrop.ogg"
    elif [ "$name" == "pixel-plonk" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Material Adventures/Plonk.ogg"
    elif [ "$name" == "pixel-scamper" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Material Adventures/Scamper.ogg"
    elif [ "$name" == "pixel-shuffle" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Material Adventures/Shuffle.ogg"
    elif [ "$name" == "pixel-sunflower" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Material Adventures/Sunflower.ogg"
    elif [ "$name" == "pixel-teapot" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Material Adventures/Teapot.ogg"
    elif [ "$name" == "pixel-birdsong" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Pixel Sounds/Birdsong.ogg"
    elif [ "$name" == "pixel-absurdbird" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Play It Loud/Absurd Bird.ogg"
    elif [ "$name" == "pixel-chefsspecial" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Play It Loud/Chef_s Special.ogg"
    elif [ "$name" == "pixel-crosswalk" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Play It Loud/Crosswalk.ogg"
    elif [ "$name" == "pixel-cyclist" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Play It Loud/Cyclist.ogg"
    elif [ "$name" == "pixel-dj" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Play It Loud/DJ.ogg"
    elif [ "$name" == "pixel-doorbell" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Play It Loud/Doorbell.ogg"
    elif [ "$name" == "pixel-grandopening" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Play It Loud/Grand Opening.ogg"
    elif [ "$name" == "pixel-honkhonk" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Play It Loud/Honk Honk.ogg"
    elif [ "$name" == "pixel-nightlife" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Play It Loud/Nightlife.ogg"
    elif [ "$name" == "pixel-nightsky" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Play It Loud/Night Sky.ogg"
    elif [ "$name" == "pixel-rockconcert" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Play It Loud/Rock Concert.ogg"
    elif [ "$name" == "pixel-welcome" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Play It Loud/Welcome.ogg"
    elif [ "$name" == "pixel-bellhop" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Reality Bytes/Bellhop.ogg"
    elif [ "$name" == "pixel-bikeride" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Reality Bytes/Bike Ride.ogg"
    elif [ "$name" == "pixel-blacksmith" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Reality Bytes/Blacksmith.ogg"
    elif [ "$name" == "pixel-cowbell" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Reality Bytes/Cowbell.ogg"
    elif [ "$name" == "pixel-cointoss" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Reality Bytes/Coin Toss.ogg"
    elif [ "$name" == "pixel-fraidycat" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Reality Bytes/Fraidy Cat.ogg"
    elif [ "$name" == "pixel-gibboncall" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Reality Bytes/Gibbon Call.ogg"
    elif [ "$name" == "pixel-guardianangel" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Reality Bytes/Guardian Angel.ogg"
    elif [ "$name" == "pixel-magictrick" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Reality Bytes/Magic Trick.ogg"
    elif [ "$name" == "pixel-paperclip" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Reality Bytes/Paper Clip.ogg"
    elif [ "$name" == "pixel-pingpong" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Reality Bytes/Ping-Pong.ogg"
    elif [ "$name" == "pixel-sadtrombone" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Reality Bytes/Sad Trombone.ogg"
    elif [ "$name" == "pixel-swansong" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Reality Bytes/Swan Song.ogg"
    elif [ "$name" == "pixel-tropicalfrog" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Reality Bytes/Tropical Frog.ogg"
    elif [ "$name" == "pixel-welcome" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Reality Bytes/Welcome.ogg"
    elif [ "$name" == "pixel-bolt" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Retro Riffs/Bolt.ogg"
    elif [ "$name" == "pixel-boomerang" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Retro Riffs/Boomerang.ogg"
    elif [ "$name" == "pixel-bubble" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Retro Riffs/Bubble.ogg"
    elif [ "$name" == "pixel-coins" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Retro Riffs/Coins.ogg"
    elif [ "$name" == "pixel-gems" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Retro Riffs/Gems.ogg"
    elif [ "$name" == "pixel-jackpot" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Retro Riffs/Jackpot.ogg"
    elif [ "$name" == "pixel-magic" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Retro Riffs/Magic.ogg"
    elif [ "$name" == "pixel-portal" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Retro Riffs/Portal.ogg"
    elif [ "$name" == "pixel-reward" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Retro Riffs/Reward.ogg"
    elif [ "$name" == "pixel-spell" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Retro Riffs/Spell.ogg"
    elif [ "$name" == "pixel-unlock" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Retro Riffs/Unlock.ogg"
    elif [ "$name" == "pixel-bemine" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Seasonal Celebrations/Be Mine.ogg"
    elif [ "$name" == "pixel-champagnepop" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Seasonal Celebrations/Champagne Pop.ogg"
    elif [ "$name" == "pixel-cheers" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Seasonal Celebrations/Cheers.ogg"
    elif [ "$name" == "pixel-eerie" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Seasonal Celebrations/Eerie.ogg"
    elif [ "$name" == "pixel-gobblegobble" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Seasonal Celebrations/Gobble Gobble.ogg"
    elif [ "$name" == "pixel-holidaymagic" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Seasonal Celebrations/Holiday Magic.ogg"
    elif [ "$name" == "pixel-partyfavor" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Seasonal Celebrations/Party Favor.ogg"
    elif [ "$name" == "pixel-sleighbells" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Seasonal Celebrations/Sleigh Bells.ogg"
    elif [ "$name" == "pixel-snowflake" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Seasonal Celebrations/Snowflake.ogg"
    elif [ "$name" == "pixel-summersurf" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Seasonal Celebrations/Summer Surf.ogg"
    elif [ "$name" == "pixel-sweatheart" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Seasonal Celebrations/Sweetheart.ogg"
    elif [ "$name" == "pixel-winterwind" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Seasonal Celebrations/Winter Wind.ogg"
    elif [ "$name" == "pixel-chime" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Pixel Sounds/Chime.ogg"
    elif [ "$name" == "pixel-clink" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Pixel Sounds/Clink.ogg"
    elif [ "$name" == "pixel-flick" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Pixel Sounds/Flick.ogg"
    elif [ "$name" == "pixel-hey" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Pixel Sounds/Hey.ogg"
    elif [ "$name" == "pixel-note" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Pixel Sounds/Note.ogg"
    elif [ "$name" == "pixel-strum" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Pixel Sounds/Strum.ogg"
    elif [ "$name" == "pixel-trill" ]; then
        APP_SOUND="$DIR_SOUND/teampixel/notifications/Pixel Sounds/Trill.ogg"
    elif [ "$name" == "x11" ]; then
        APP_SOUND="$DIR_SOUND/x11/stereo/message-new-instant.ogg"
    elif [ "$name" == "x10" ]; then
        APP_SOUND="$DIR_SOUND/x10/notify-system-generic.ogg"
    elif [ "$name" == "xxp" ]; then
        APP_SOUND="$DIR_SOUND/xxp/notify.ogg"   
    elif [ "$name" == "mint20" ]; then
        APP_SOUND="$DIR_SOUND/LinuxMint/stereo/system-ready.ogg"
    elif [ "$name" == "miui" ]; then
        APP_SOUND="$DIR_SOUND/miui/stereo/message-sent-instant.ogg"
    elif [ "$name" == "deepin" ]; then
        APP_SOUND="$DIR_SOUND/deepin/suspend-resume.ogg"
    elif [ "$name" == "enchanted" ]; then
        APP_SOUND="$DIR_SOUND/enchanted/message-sent-instant.ogg"
    elif [ "$name" == "borealis" ]; then
        APP_SOUND="$DIR_SOUND/borealis/notification.ogg"
    elif [ "$name" == "harmony" ]; then
        APP_SOUND="$DIR_SOUND/harmony/notification-brighter.ogg"
    elif [ "$name" == "fresh-dream" ]; then
        APP_SOUND="$DIR_SOUND/dream/stereo/dialog-question.ogg"
    elif [ "$name" == "ubuntu-original" ]; then
        APP_SOUND="$DIR_SOUND/linux-ubuntu/new-mail.ogg"
    elif [ "$name" == "nightlynews" ]; then
        APP_SOUND="$DIR_SOUND/nightlynews/chimes.ogg"
    elif [ "$name" == "zorin" ]; then
        APP_SOUND="$DIR_SOUND/zorin/stereo/message-new-instant.ogg"
    
    
    
    elif [ "$name" == "theme" ]; then

        echo "[i] SOUND AS THEMED"
        # SET SOUNDS
        if [ "$soundtheme" == "zorin" ]; then
            APP_SOUND="$DIR_SOUND/zorin/stereo/message-new-instant.ogg"

        elif [ "$soundtheme" == "x11" ]; then
            APP_SOUND="$DIR_SOUND/x11/stereo/message-new-instant.ogg"

        elif [ "$soundtheme" == "x10" ]; then
            APP_SOUND="$DIR_SOUND/x10/notify-system-generic.ogg"
            
        elif [ "$soundtheme" == "xxp" ]; then
            APP_SOUND="$DIR_SOUND/xxp/notify.ogg"

        elif [ "$soundtheme" == "miui" ]; then
            APP_SOUND="$DIR_SOUND/miui/stereo/message-sent-instant.ogg"

        elif [ "$soundtheme" == "deepin" ]; then
            APP_SOUND="$DIR_SOUND/deepin/suspend-resume.ogg"

        elif [ "$soundtheme" == "borealis" ]; then
            APP_SOUND="$DIR_SOUND/borealis/notification.ogg"

        elif [ "$soundtheme" == "harmony" ]; then
            APP_SOUND="$DIR_SOUND/harmony/notification-brighter.ogg"
            
        elif [ "$soundtheme" == "dream" ]; then
            APP_SOUND="$DIR_SOUND/dream/stereo/dialog-question.ogg"

        elif [ "$soundtheme" == "ubuntu-original" ]; then
            APP_SOUND="$DIR_SOUND/linux-ubuntu/new-mail.ogg"

        elif [ "$soundtheme" == "teampixel" ]; then
            APP_SOUND="$DIR_SOUND/teampixel/notification_simple-01.ogg"
            
        elif [ "$soundtheme" == "linux-a11y" ]; then
            APP_SOUND="$DIR_SOUND/teampixel/notification_simple-01.ogg"

        else
            APP_SOUND="$DIR_SOUND/dream/stereo/dialog-question.ogg"
        fi
        
    fi
    
    # APPLY THE SOUND
    gsettings set org.cinnamon.sounds notification-file "$APP_SOUND"

fi