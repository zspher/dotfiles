#!/usr/bin/env bash

for file in ./in/*.{mkv,mp4}; do
    [ -e "$file" ] || continue # prevent cases where glob does not match
    filename=${file##*/}
    filename=${filename%%.*}

    [[ -e ./out/"$filename".o.mov ]] && continue # if file is prescent skip convert
    ffmpeg -i "$file" -c:v dnxhd -profile:v dnxhr_hq -pix_fmt yuv422p -c:a pcm_s16le -f mov ./out/"$filename".o.mov
done