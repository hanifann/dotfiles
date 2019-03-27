#!/bin/bash

#  _                                _
# | |                              | |
# | |     ___ _ __ ___   ___  _ __ | |__   __ _ _ __
# | |    / _ \ '_ ` _ \ / _ \| '_ \| '_ \ / _` | '__|
# | |___|  __/ | | | | | (_) | | | | |_) | (_| | |
# |______\___|_| |_| |_|\___/|_| |_|_.__/ \__,_|_|
#
#  github.com/fikriomar16

pkill lemonbar

. "${HOME}/.cache/wal/colors.sh"

trans='#002f343f'

bg="%{B$color7}%{F$color4}"
active="%{B$color4}%{F$color7}"

brdr="%{U$color7}%{+o}%{+u}"
cbrdr="%{-o}%{-u}"

#geo="1366x28+0+0"
geo="1920x28+0+0"
f1="iosevka\Nerd\Font:size=9"
f2="TakaoPGothic:size=11"

wsa="  "
wsd="  "

menu(){
    echo "%{B$color7}%{F$color0}%{A:menubar:}  %{A}%{B-}%{F-}"
}

get_ws(){
    desk=$(xdotool get_desktop)
    wsname=("  " "  " "  " "  ")
    for i in {0..3}; do
        echo -n "$bg%{A:xdotool set_desktop $i:}"
        if [[ "$((desk))" == "$i" ]]; then
            echo -n "$active"
        else
            echo -n ""
        fi
        if [[ "$((desk))" == "$i" ]]; then
            echo -n "${wsname[$((i))]}" | tr '[:lower:]' '[:upper:]'
        else
            echo -n "${wsname[$((i))]}" | tr '[:lower:]' '[:upper:]'
        fi
        echo -n "%{A}%{B-}%{F-}"
done
}

get_window(){
	id=$(xtitle -t 50)
	echo -n "%{B$color7}%{F$color3}| $id %{B-}%{F-}"
}
icon_window(){
	echo -n "%{B$color3}%{F$color0}%{A:rofi -show window:}  %{A}%{B-}%{F-}"
}

get_song() {
    echo "%{B$color7}%{F$color1}%{A:popup-art:} $(mpc -p 6601 current -f %title%) %{A}%{B-}%{F-}"
}
icon_song(){
    echo "%{B$color7}%{F$color1}%{A:mpc -p 6601 toggle:}%{A3:mpd-popup:} |  %{A}%{A}%{B-}%{F-}"
}

get_network() {
    network_id=$(/sbin/iwgetid -r)
    if [ -n "$network_id" ]
    then
        echo "%{B$color15}%{F$color0} ${network_id} %{B-}%{F-}"
    else
        echo "%{B$color15}%{F$color0} offline %{B-}%{F-}"
    fi
}
icon_network(){
    network_id=$(/sbin/iwgetid -r)
    if [ -n "$network_id" ]
    then
        echo "%{B$color7}%{F$color6}%{A3:nmcli_dmenu:}%{A:urxvt -g 75x25 -e nmtui:}  %{A}%{A}%{B-}%{F-}"
    else
        echo "%{B$color7}%{F$color6}%{A3:nmcli_dmenu:}%{A:urxvt -g 75x25 -e nmtui:}  %{A}%{A}%{B-}%{F-}"
    fi
}

get_volume(){
    statusLine=$(amixer get Master | tail -n 1)
    echo "%{B$color15}%{F$color0} $(echo "${statusLine}" | awk -F ' ' '{print $4}' | tr -d '[]%')% %{B-}%{F-}"
}
icon_volume(){
    echo "%{B$color7}%{F$color5}%{A:amixer -q sset Master 3%+ unmute:}%{A3:amixer -q sset Master 3%- unmute:}  %{A}%{A}%{B-}%{F-}"
}

get_battery() {
    battery_status=$(cat /sys/class/power_supply/BAT1/status)
    battery_percent=$(cat /sys/class/power_supply/BAT1/capacity)
    case "$battery_status" in
        Charging)
            echo "%{B$color15}%{F$color0} ${battery_percent}% %{B-}%{F-}"
            ;;
        Discharging)
            if [ "$battery_percent" -gt 80 ]
            then
                echo "%{B$color15}%{F$color0} ${battery_percent}% %{B-}%{F-}"
            elif [ "$battery_percent" -gt 30 ]
            then
                echo "%{B$color15}%{F$color0} ${battery_percent}% %{B-}%{F-}"
            else
                echo "%{B$color15}%{F$color0} ${battery_percent}% %{B-}%{F-}"
            fi
            ;;
        Unknown|Full) echo "%{B$color15}%{F$color0} Full %{B-}%{F-}";;
    esac
}
icon_battery() {
    battery_status=$(cat /sys/class/power_supply/BAT1/status)
    battery_percent=$(cat /sys/class/power_supply/BAT1/capacity)
    case "$battery_status" in
        Charging)
            echo "%{B$color7}%{F$color2}  %{B-}%{F-}"
            ;;
        Discharging)
            if [ "$battery_percent" -gt 80 ]
            then
                echo "%{B$color7}%{F$color2}  %{B-}%{F-}"
            elif [ "$battery_percent" -gt 30 ]
            then
                echo "%{B$color7}%{F$color2}  %{B-}%{F-}"
            else
                echo "%{B$color7}%{F$color2}  %{B-}%{F-}"
            fi
            ;;
        Unknown|Full) echo "%{B$color7}%{F$color2}  %{B-}%{F-}";;
    esac
}

get_time() {
        echo "%{B$color7}%{F$color3} $(date +'%H:%M - %b %d') %{B-}%{F-}"
}
icon_time(){
    echo "%{B$color7}%{F$color3}  %{B-}%{F-}"
}

while true; do
    echo "$brdr%{l} %{O5}$(menu) $(get_ws)$(icon_song)$(get_song)$(get_window) \
    %{r} $(icon_network)$(icon_volume)$(icon_battery)$(icon_time)$(get_time)%{O5} "
    sleep 1
done | lemonbar -g "${geo}" -f "${f1}" -f "${f2}" -B "${color7}" -F "${color4}" -u 0 -a 25 | sh & > /dev/null
