#!/bin/bash

MUSIC_DIR=~/Music/

COVER=/tmp/cover.jpg

function reset_background
{
    printf "\e]20;;100x100+1000+1000\a"
}

{
    album="$(mpc --format %album% current --port 6600)"
    file="$(mpc --format %file% current --port 6600)"
    album_dir="${file%/*}"
    [[ -z "$album_dir" ]] && exit 1
    album_dir="$MUSIC_DIR/$album_dir"

    covers="$(find "$album_dir" -type d -exec find {} -maxdepth 1 -type f -iregex ".*/.*\(${album}\|cover\|folder\|artwork\|front\).*[.]\(jpe?g\|png\|gif\|bmp\)" \; )"
    src="$(echo -n "$covers" | head -n1)"
    rm -f "$COVER" 
    if [[ -n "$src" ]] ; then
        #resize the image's width to 500px 
	convert "$src" -resize 500x "$COVER"
        if [[ -f "$COVER" ]] ; then
           printf "\e]20;${COVER};70x70+0+00:op=keep-aspect\a"
        else
            reset_background
        fi
    else
        reset_background
    fi
} &
