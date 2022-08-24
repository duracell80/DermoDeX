#!/bin/bash

CINN_VERSION=$(cinnamon --version)
CWD=$(pwd)

mkdir -p $CWD/deps/themes
mkdir -p $HOME/.local/share/dermodex/theme
cd $CWD/deps

#rm -rf $CWD/deps/Fluent-gtk-theme 

# CLONE FLUENT
git clone https://github.com/vinceliuice/Fluent-gtk-theme.git
cd $CWD/deps/Fluent-gtk-theme

# INSTALL FLUENT IN CURRENT WORKING DIRECTORY NOT USR THEMES
$CWD/deps/Fluent-gtk-theme/install.sh --dest $CWD/deps/themes --tweaks round --size standard --theme default

# REMIX LIGHT AND DARK
cp -r $CWD/deps/themes/Fluent-round-Light/* $CWD/theme
cp -rf $CWD/deps/themes/Fluent-round-Dark/cinnamon/* $CWD/theme/cinnamon

# ADD COMMON ASSETS
cp -rf $CWD/src/user-avatar.png $CWD/theme/cinnamon/assets
cp -rf $CWD/src/icons/*.svg $CWD/theme/cinnamon/assets

# COPY HYBRID THEME TO .local
cp -rf $CWD/theme/* $HOME/.local/share/dermodex/theme