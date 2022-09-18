#!/bin/bash

CINN_VERSION=$(cinnamon --version)
if awk "BEGIN {exit !($CINN_VERSION < 5.2)}"; then
    echo "[i] ERROR: Cinnamon version too low, this script was designed for Cinnamon 5.2 and above"
    exit
fi

CWD=$(pwd)



mkdir -p $CWD/deps/themes
mkdir -p $HOME/.local/share/dermodex/theme
cd $CWD/deps

#rm -rf $CWD/deps/Fluent-gtk-theme 

# CLONE FLUENT
echo ""

if [ -d $CWD/deps/Fluent-gtk-theme ] ; then
    echo "[i] Fluent Theme Already Installed"
    cd $CWD/deps/Fluent-gtk-theme
    git fetch
    git pull
else
    git clone https://github.com/vinceliuice/Fluent-gtk-theme.git
    cd $CWD/deps/Fluent-gtk-theme
fi

echo ""
echo ""
read -p "Do you wish to use the rounded version of fluent (y/n)? " answer
case ${answer:0:1} in
    y|Y )
        # INSTALL FLUENT IN CURRENT WORKING DIRECTORY NOT USR THEMES
        $CWD/deps/Fluent-gtk-theme/install.sh --dest $CWD/deps/themes --tweaks round --size standard --theme default

        # REMIX LIGHT AND DARK
        cp -r $CWD/deps/themes/Fluent-round-Light/* $CWD/theme
        cp -rf $CWD/deps/themes/Fluent-round-Dark/cinnamon/* $CWD/theme/cinnamon
    ;;
    * )
        # INSTALL FLUENT IN CURRENT WORKING DIRECTORY NOT USR THEMES
        $CWD/deps/Fluent-gtk-theme/install.sh --dest $CWD/deps/themes --tweaks square --size standard --theme default

        # REMIX LIGHT AND DARK
        cp -r $CWD/deps/themes/Fluent-Light/* $CWD/theme
        cp -rf $CWD/deps/themes/Fluent-Dark/cinnamon/* $CWD/theme/cinnamon
    ;;
esac



# ADD COMMON ASSETS
cp -rf $CWD/src/user-avatar.png $CWD/theme/cinnamon/assets
cp -rf $CWD/src/icons/*.svg $CWD/theme/cinnamon/assets

# COPY HYBRID THEME TO .local
cp -rf $CWD/theme/* $HOME/.local/share/dermodex/theme