#!/usr/bin/env bash

pkill n30f
while getopts hs options
do
	case $options in
		h)  # hide
            pkill -f polybar\ music
            pkill -f polybar\ np
			;;
		s)  # show
            if pgrep -f polybar\ np > /dev/null; then
                ~/.config/polybar/scripts/popups/cover.sh
            else
                polybar np &
                polybar music &
                ~/.config/polybar/scripts/popups/cover.sh
            fi
			;;
	esac
done
