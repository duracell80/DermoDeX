#! /bin/bash
mkdir -p ./ogg
for file in *.ogg; do
    filebasename=`basename "$file" .ogg`
    fileout="./ogg/$filebasename.ogg"

    ffmpeg -i "$file" -acodec libvorbis -ab 32k -ab 64k -ar 44100 "$fileout"
done
