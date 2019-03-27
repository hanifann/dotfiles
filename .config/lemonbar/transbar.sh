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

color0='#002f343f'
color8='#444A57'
color1='#BF616A'
color9='#BF616A'
color2='#A3BE8C'
color10='#A3BE8C'
color3='#EBCB8B'
color11='#EBCB8B'
color4='#81A1C1'
color12='#81A1C1'
color5='#B48EAD'
color13='#B48EAD'
color6='#88C0D0'
color14='#88C0D0'
color7='#e1e1e1'
color15='#e7e8eb'

bg="%{B$color7}%{F$color0}"
active="%{B$color6}%{F$color0}"
brdr="%{U$color0}%{+u}%{+o}"
cbrdr="%{-u}%{-o}"

geo="1920x28+0+0"
f1="iosevka\Nerd\Font:size=9"
f2="TakaoPGothic:size=10"

wsa="  "
wsd="  "

get_workspaces() {
    desk=$(xdotool get_desktop)
    current_workspace=$(($desk + 1))
    case "$current_workspace" in
        1) echo "$bg       ";;
        2) echo "$bg       ";;
        3) echo "$bg       ";;
        4) echo "$bg       ";;
        5) echo "$bg       ";;
        6) echo "$bg       ";;
    esac
}

get_ws(){
    desk=$(xdotool get_desktop)
    wsname=("  satu " "  dua " "  tiga " "  empat ")
    for i in {0..3}; do
        echo -n "$bg%{A:xdotool set_desktop $i:}"
        if [[ "$((desk))" == "$i" ]]; then
            echo -n "$active"
        else
            echo -n ""
        fi
        echo -n "${wsname[$((i))]}" | tr '[:lower:]' '[:upper:]'
        echo -n "%{A}%{B-}%{F-}"
done
}

get_window(){
	id=$(xtitle -t 70)
	echo -n "%{B$color15}%{F$color0} $id %{B-}%{F-}"
}
icon_window(){
	echo -n "%{B$color3}%{F$color0}  %{B-}%{F-}"
}

get_song() {
    echo "%{B$color15}%{F$color1}%{A:popup-pane:} $(mpc -p 6601 current) %{A}%{B-}%{F-}"
}
icon_song(){
    echo "%{B$color1}%{F$color15}%{A:mpc -p 6601 toggle:}%{A3:mpd-popup:}  %{A}%{A}%{B-}%{F-}"
}

get_network() {
    network_id=$(/sbin/iwgetid -r)
    if [ -n "$network_id" ]
    then
        echo "%{B$color15}%{F$color0} ${network_id} %{B-}%{F-}"
    else
        echo "%{B$color15}%{F$color0} No Waifu Detected %{B-}%{F-}"
    fi
}
icon_network(){
    network_id=$(/sbin/iwgetid -r)
    if [ -n "$network_id" ]
    then
        echo "%{B$color6}%{F$color0}%{A:nmcli_dmenu:}  %{A}%{B-}%{F-}"
    else
        echo "%{B$color6}%{F$color0}  %{B-}%{F-}"
    fi
}

get_volume(){
    statusLine=$(amixer get Master | tail -n 1)
    echo "%{B$color15}%{F$color0} $(echo "${statusLine}" | awk -F ' ' '{print $4}' | tr -d '[]%')% %{B-}%{F-}"
}
icon_volume(){
    echo "%{B$color5}%{F$color0}%{A:amixer -q sset Master 3%+ unmute:}%{A3:amixer -q sset Master 3%- unmute:}  %{A}%{A}%{B-}%{F-}"
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
        Unknown|Full) echo "%{B$color15}%{F$color0} 100% %{B-}%{F-}";;
    esac
}
icon_battery() {
    battery_status=$(cat /sys/class/power_supply/BAT1/status)
    battery_percent=$(cat /sys/class/power_supply/BAT1/capacity)
    case "$battery_status" in
        Charging)
            echo "%{B$color2}%{F$color0}  %{B-}%{F-}"
            ;;
        Discharging)
            if [ "$battery_percent" -gt 80 ]
            then
                echo "%{B$color2}%{F$color0}  %{B-}%{F-}"
            elif [ "$battery_percent" -gt 30 ]
            then
                echo "%{B$color2}%{F$color0}  %{B-}%{F-}"
            else
                echo "%{B$color2}%{F$color0}  %{B-}%{F-}"
            fi
            ;;
        Unknown|Full) echo "%{B$color2}%{F$color0}  %{B-}%{F-}";;
    esac
}

get_date() {
        echo "%{B$color15}%{F$color0} $(date +'%a - %b %d, %Y') %{B-}%{F-}"
}
icon_date(){
    echo "%{B$color4}%{F$color0}  %{B-}%{F-}"
}
get_time() {
        echo "%{B$color15}%{F$color0} $(date +'%H:%M') %{B-}%{F-}"
}
icon_time(){
    echo "%{B$color3}%{F$color0}  %{B-}%{F-}"
}

while true; do
    echo "$brdr%{l}%{O10} $(icon_song)$(get_song) $(icon_window)$(get_window) \
    %{c} $(get_ws) \
    %{r} $(icon_network)$(get_network) $(icon_volume)$(get_volume) $(icon_battery)$(get_battery) $(icon_date)$(get_date) $(icon_time)$(get_time) %{O10}"
    sleep 1
done | lemonbar -b -g "${geo}" -f "${f1}" -f "${f2}" -B "$color0" -F "$color15" -u 4 | sh & > /dev/null
