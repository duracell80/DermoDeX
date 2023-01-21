#!/usr/bin/env bash
# remix_wallpapers.sh <name=mintpaper> <name=uma>

CWD=$(pwd)

TYPE=$1
NAME=$2

#CONF_MPKG="http://packages.linuxmint.com/pool/main/m"


if [ "$TYPE" == "mintpaper" ]; then
    
    sudo apt install mint-backgrounds-$2
    
    
    
    # REMOVE PREVIOUS WALLPAPERS
    #gsettings set org.cinnamon.desktop.background picture-uri none
    #mv $HOME/.local/share/dermodex/wallpapers/*.tar.gz $HOME/.local/share/dermodex
    #sleep 1
    #rm -rf $HOME/.local/share/dermodex/wallpapers/mint-backgrounds*
    #mv $HOME/.local/share/dermodex/*.tar.gz $HOME/.local/share/dermodex/wallpapers
    
    #gawk -i inplace '!/mint-backgrounds/' $HOME/.cinnamon/backgrounds/user-folders.lst
    
    #sleep 1
    # FIND THE VERSION OF THE PACKAGE
    #wget -P "$HOME/.local/share/dermodex/wallpapers" -A .tar.gz "$CONF_MPKG/mint-backgrounds-$NAME" 
    #CONF_VERSION=$(grep -Po ".{0,4}tar.gz{0,1}" "$HOME/.local/share/dermodex/wallpapers/mint-backgrounds-$NAME.tmp" | uniq | head -n 1)
    
    #rm $HOME/.local/share/dermodex/wallpapers/*.tmp*
    
    # GET THE PACKAGE
    #wget -nc -P "$HOME/.local/share/dermodex/wallpapers" "${CONF_MPKG}/mint-backgrounds-${NAME}/mint-backgrounds-${NAME}_${CONF_VERSION}"
    
    # UNZIP IT
    #cd $HOME/.local/share/dermodex/wallpapers
    
    #tar xvf "${HOME}/.local/share/dermodex/wallpapers/mint-backgrounds-${NAME}_${CONF_VERSION}" "mint-backgrounds-#${NAME}/backgrounds/linuxmint-${NAME}"
    
    #echo "${HOME}/.local/share/dermodex/wallpapers/mint-backgrounds-${NAME}/backgrounds/linuxmint-${NAME}" >> "${HOME}/.cinnamon/backgrounds/user-folders.lst"
    
    #cd $CWD
    
fi


#cat -n $HOME/.cinnamon/backgrounds/user-folders.lst | sort -uk2 | sort -nk1 | cut -f2- > $HOME/.cinnamon/backgrounds/user-folders.tmp
#mv $HOME/.cinnamon/backgrounds/user-folders.tmp $HOME/.cinnamon/backgrounds/user-folders.lst
#rm -f $HOME/.cinnamon/backgrounds/user-folders.tmp