#!/bin/bash
set -ueo pipefail

RENDER_SVG="$(command -v rendersvg)" || true
INKSCAPE="$(command -v inkscape)" || true
OPTIPNG="$(command -v optipng)" || true
INKSCAPE_VERSION=$(inkscape --version | cut -d ' ' -f 2)
INKSCAPE_VERSION_TARGET="1.0"


# SET THE STAGE
CWD=$(pwd)
LWD=$HOME/.local/share/dermodex
CCD=$HOME/.cache/dermodex
TWD=$HOME/.themes/DermoDeX
GTK_ASSETS=$LWD/theme-ext/gtk
GTK2_ASSETS=$LWD/theme-ext/gtk-2.0

CONF_FILE="$HOME/.local/share/dermodex/config.ini"

ASSETS_DIR="$GTK_ASSETS/assets"
SRC_FILE="$GTK_ASSETS/assets.svg"

INDEX="$GTK_ASSETS/assets.txt"
INDEX2="$GTK2_ASSETS/assets.txt"

ASSETS_DIR2="$GTK2_ASSETS/assets"
SRC_FILE2="$GTK2_ASSETS/assets.svg"

# RECOLOR GTK ASSETS SVG FIRST
cp -f "$GTK_ASSETS/assets.orig" "$GTK_ASSETS/assets.svg"
sed -i "s|#1A73E8|$1|g" "$GTK_ASSETS/assets.svg"
sed -i "s|#3281ea|$1|g" "$GTK_ASSETS/assets.svg"
sed -i "s|#0078D4|$1|g" "$GTK_ASSETS/assets.svg"

cp -f "$GTK2_ASSETS/assets.orig" "$GTK2_ASSETS/assets.svg"
sed -i "s|#0078D4|$1|g" "$GTK2_ASSETS/assets.svg"


# RENDER A THUMBNAIL FOR THEME SETTINGS UI
if [[ -n "${RENDER_SVG}" ]]; then
    "$RENDER_SVG" "$GTK_ASSETS/assets.svg" "$CCD/gtk-3.0/thumbnail.png"
else
    if awk "BEGIN {exit !($INKSCAPE_VERSION >= $INKSCAPE_VERSION_TARGET)}"; then
        "$INKSCAPE" \
              --export-id-only \
              -o "$CCD/gtk-3.0/thumbnail.png" "$SRC_FILE" >/dev/null
    else
        "$INKSCAPE" \
              --export-id-only \
              -z -e "$CCD/gtk-3.0/thumbnail.png" "$SRC_FILE" >/dev/null
    fi
fi
convert "$CCD/gtk-3.0/thumbnail.png" -gravity West -crop 50%x100%+0+0 "$CCD/gtk-3.0/thumbnail_crop.png"
cp -f "$CCD/gtk-3.0/thumbnail_crop.png" "$TWD/gtk-3.0/thumbnail.png"


# RENDER GTK3/4
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
    if awk "BEGIN {exit !($INKSCAPE_VERSION >= $INKSCAPE_VERSION_TARGET)}"; then
        "$INKSCAPE" --export-id="$i" \
              --export-id-only \
              -o "$ASSETS_DIR/$i.png" "$SRC_FILE" >/dev/null
    else
        "$INKSCAPE" --export-id="$i" \
              --export-id-only \
              -z -e "$ASSETS_DIR/$i.png" "$SRC_FILE" >/dev/null
    fi

  
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
    if awk "BEGIN {exit !($INKSCAPE_VERSION >= $INKSCAPE_VERSION_TARGET)}"; then
        "$INKSCAPE" --export-id="$i" \
              --export-id-only \
              --export-dpi=192 \
              -o "$ASSETS_DIR/$i@2.png" "$SRC_FILE" >/dev/null
    else
        "$INKSCAPE" --export-id="$i" \
              --export-id-only \
              --export-dpi=192 \
              -z -e "$ASSETS_DIR/$i@2.png" "$SRC_FILE" >/dev/null
    fi
fi
if [[ -n "${OPTIPNG}" ]]; then
  "$OPTIPNG" -o7 --quiet "$ASSETS_DIR/$i@2.png"
fi
fi

done
# DONE RENDERING GTK3/4



# RENDER GTK2
[[ -d $ASSETS_DIR2 ]] && rm -rf $ASSETS_DIR2
mkdir -p $ASSETS_DIR2

for i in `cat $INDEX2`; do
echo "Rendering '$ASSETS_DIR2/$i.png'"

if [[ -f "$ASSETS_DIR2/$i.png" ]]; then
  echo "$ASSETS_DIR2/$i.png" exists.
else
if [[ -n "${RENDER_SVG}" ]]; then
  "$RENDER_SVG" --export-id "$i" \
                "$SRC_FILE2" "$ASSETS_DIR2/$i.png"
else
    if awk "BEGIN {exit !($INKSCAPE_VERSION >= $INKSCAPE_VERSION_TARGET)}"; then
        "$INKSCAPE" --export-id="$i" \
              --export-id-only \
              -o "$ASSETS_DIR2/$i.png" "$SRC_FILE2" >/dev/null
    else
        "$INKSCAPE" --export-id="$i" \
              --export-id-only \
              -z -e "$ASSETS_DIR2/$i.png" "$SRC_FILE2" >/dev/null
    fi

  
fi
if [[ -n "${OPTIPNG}" ]]; then
  "$OPTIPNG" -o7 --quiet "$ASSETS_DIR2/$i.png"
fi
fi

done
# DONE RENDERING GTK2






cp -f "$GTK_ASSETS/assets.svg" "$GTK_ASSETS/assets.current"
cp -f "$GTK_ASSETS/assets.orig" "$GTK_ASSETS/assets.svg"

cp -f "$GTK2_ASSETS/assets.svg" "$GTK2_ASSETS/assets.current"
cp -f "$GTK2_ASSETS/assets.orig" "$GTK2_ASSETS/assets.svg"

cp -rf $ASSETS_DIR2 "$TWD/gtk-2.0"
cp -rf $ASSETS_DIR "$TWD/gtk-3.0"
cp -rf $ASSETS_DIR "$TWD/gtk-4.0"
#[[ -d $ASSETS_DIR ]] && rm -rf $ASSETS_DIRs

echo "[i] Rendering assets complete!"
notify-send --urgency=normal --category=transfer.complete --icon=cs-backgrounds-symbolic "DermoDeX Rendering" "Rendering of all SVG assets to PNG now complete!"