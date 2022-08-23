#!/bin/bash

# SET THE STAGE
CINN_VERSION=$(cinnamon --version)
CWD=$(pwd)

# READY THE STAGE
mkdir -p $CWD/deps/themes
mkdir -p $HOME/.themes/DermoDeX
cd $CWD/deps

#rm -rf $CWD/deps/Fluent-gtk-theme 

# CLONE FLUENT
#git clone https://github.com/vinceliuice/Fluent-gtk-theme.git
cd $CWD/deps/Fluent-gtk-theme

# INSTALL FLUENT IN CURRENT WORKING DIRECTORY NOT USR THEMES
$CWD/deps/Fluent-gtk-theme/install.sh --dest $CWD/deps/themes --tweaks round --size standard --theme default

# REMIX LIGHT AND DARK
cp -r $CWD/deps/themes/Fluent-round-Light/* $CWD/theme
cp -rf $CWD/deps/themes/Fluent-round-Dark/cinnamon/* $CWD/theme/cinnamon

# ADD COMMON ASSETS
cp -rf $CWD/deps/common-assets/user-avatar.png $CWD/theme/cinnamon/assets

cp -rf $CWD/deps/common-assets/grouped-window-dot.svg $CWD/theme/cinnamon/assets

cp -rf $CWD/deps/common-assets/grouped-window-dot-active.svg $CWD/theme/cinnamon/assets

# APPEND CINNAMON-EXT TO CINNAMON
cat $CWD/deps/common-assets/cinnamon-ext.css >> $CWD/theme/cinnamon/cinnamon.css

# COPY HYBRID AS DERMODEX
cp -rf $CWD/theme/* $HOME/.themes/DermoDeX

# REMOVE FLUENT BUILDS
rm -rf $CWD/deps/themes/Fluent*