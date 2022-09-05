#!/bin/bash
set -ueo pipefail

RENDER_SVG="$(command -v rendersvg)" || true
INKSCAPE="$(command -v inkscape)" || true
OPTIPNG="$(command -v optipng)" || true





# SET THE STAGE
CWD=$(pwd)
LWD=$HOME/.local/share/dermodex
CCD=$HOME/.cache/dermodex
TWD=$HOME/.themes/DermoDeX
GTK_ASSETS=$LWD/theme-ext/gtk

CONF_FILE="$HOME/.local/share/dermodex/config.ini"

ASSETS_DIR="$GTK_ASSETS/assets"
SRC_FILE="$GTK_ASSETS/assets.svg"

INDEX="$GTK_ASSETS/assets.txt"

# RECOLOR GTK ASSETS SVG FIRST
cp -f "$GTK_ASSETS/assets.orig" "$GTK_ASSETS/assets.svg"
sed -i "s|#1A73E8|$1|g" "$GTK_ASSETS/assets.svg"
sed -i "s|#3281ea|$1|g" "$GTK_ASSETS/assets.svg"



[[ -d $ASSETS_DIR ]] && rm -rf $ASSETS_DIR
mkdir -p $ASSETS_DIR

for i in `cat $INDEX`; do
echo "Rendering '$ASSETS_DIR/$i.png'"

if [[ -f "$ASSETS_DIR/$i.png" ]]; then
  echo "$ASSETS_DIR/$i.png" exists.
else
if [[ -n "${RENDER_SVG}" ]]; then
  "$RENDER_SVG" --export-id "$i" \
                "$SRC_FILE" "$ASSETS_DIR/$i.png"
else
  "$INKSCAPE" --export-id="$i" \
              --export-id-only \
              --export-filename="$ASSETS_DIR/$i.png" "$SRC_FILE" >/dev/null
fi
if [[ -n "${OPTIPNG}" ]]; then
  "$OPTIPNG" -o7 --quiet "$ASSETS_DIR/$i.png"
fi
fi

echo "Rendering '$ASSETS_DIR/$i@2.png'"

if [[ -f "$ASSETS_DIR/$i@2.png" ]]; then
  echo "$ASSETS_DIR/$i@2.png" exists.
else
if [[ -n "${RENDER_SVG}" ]]; then
  "$RENDER_SVG" --export-id "$i" \
                --dpi 192 \
                --zoom 2 \
                "$SRC_FILE" "$ASSETS_DIR/$i@2.png"
else
  "$INKSCAPE" --export-id="$i" \
              --export-id-only \
              --export-dpi=192 \
              --export-filename="$ASSETS_DIR/$i@2.png" "$SRC_FILE" >/dev/null
fi
if [[ -n "${OPTIPNG}" ]]; then
  "$OPTIPNG" -o7 --quiet "$ASSETS_DIR/$i@2.png"
fi
fi

done

cp -f "$GTK_ASSETS/assets.svg" "$GTK_ASSETS/assets.current"
cp -f "$GTK_ASSETS/assets.orig" "$GTK_ASSETS/assets.svg"
cp -rf $ASSETS_DIR "$TWD/gtk-3.0"
cp -rf $ASSETS_DIR "$TWD/gtk-4.0"
#[[ -d $ASSETS_DIR ]] && rm -rf $ASSETS_DIRs