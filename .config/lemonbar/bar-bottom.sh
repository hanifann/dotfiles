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

color0='#952f343f'
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

bg="%{B$color0}%{F$color6}"
active="%{B$color6}%{F$color0}"
#trans="%{B#002f343f}%{F#00e7e8eb}"

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
    wsname=("  " "  " "  " "  ")
    for i in {0..3}; do
        echo -n "$bg%{A:xdotool set_desktop $i:}"
        if [[ "$((desk))" == "$i" ]]; then
            echo -n "$active"
        else
            echo -n ""
        fi
        echo -n "${wsname[$((i))]}" | tr '[:lower:]' '[:upper:]'
        echo -n "%{A}"
done
}

get_song() {
    echo "%{B$color0}%{F$color15}%{A:popup-bottom:} $(mpc -p 6601 current) %{A}"
}
icon_song(){
    echo "%{B$color0}%{F$color1}%{A:mpc -p 6601 toggle:}%{A3:mpd-popup:}  %{A}%{A}"
}
icon_prev(){
    echo "%{B$color1}%{F$color15}%{A:mpc -p 6601 prev:}  %{A}"
}
icon_stop(){
    echo "%{B$color1}%{F$color15}%{A:mpc -p 6601 stop:}  %{A}"
}
icon_next(){
    echo "%{B$color1}%{F$color15}%{A:mpc -p 6601 next:}  %{A}$trans$bg"
}

get_network() {
    network_id=$(/sbin/iwgetid -r)
    if [ -n "$network_id" ]
    then
        echo "%{B$color0}%{F$color15}${network_id} "
    else
        echo "%{B$color0}%{F$color15}offline "
    fi
}
icon_network(){
    network_id=$(/sbin/iwgetid -r)
    if [ -n "$network_id" ]
    then
        echo "%{B$color0}%{F$color6}%{A:nmcli_dmenu:}  %{A}"
    else
        echo "%{B$color0}%{F$color6}  "
    fi
}

get_volume(){
    statusLine=$(amixer get Master | tail -n 1)
    echo "%{B$color0}%{F$color15}$(echo "${statusLine}" | awk -F ' ' '{print $4}' | tr -d '[]%')% "
}
icon_volume(){
    echo "%{B$color0}%{F$color5}%{A:amixer -q sset Master 3%+ unmute:}%{A3:amixer -q sset Master 3%- unmute:}  %{A}%{A}"
}

get_battery() {
    battery_status=$(cat /sys/class/power_supply/BAT1/status)
    battery_percent=$(cat /sys/class/power_supply/BAT1/capacity)
    case "$battery_status" in
        Charging)
            echo "%{B$color0}%{F$color15} ${battery_percent}% "
            ;;
        Discharging)
            if [ "$battery_percent" -gt 80 ]
            then
                echo "%{B$color0}%{F$color15} ${battery_percent}% "
            elif [ "$battery_percent" -gt 30 ]
            then
                echo "%{B$color0}%{F$color15} ${battery_percent}% "
            else
                echo "%{B$color0}%{F$color15} ${battery_percent}% "
            fi
            ;;
        Unknown|Full) echo "%{B$color0}%{F$color15} 100% ";;
    esac
}
icon_battery() {
    battery_status=$(cat /sys/class/power_supply/BAT1/status)
    battery_percent=$(cat /sys/class/power_supply/BAT1/capacity)
    case "$battery_status" in
        Charging)
            echo "%{B$color0}%{F$color2} "
            ;;
        Discharging)
            if [ "$battery_percent" -gt 80 ]
            then
                echo "%{B$color0}%{F$color2} "
            elif [ "$battery_percent" -gt 30 ]
            then
                echo "%{B$color0}%{F$color2} "
            else
                echo "%{B$color0}%{F$color2} "
            fi
            ;;
        Unknown|Full) echo "%{B$color0}%{F$color2} ";;
    esac
}

get_date() {
        echo "%{B$color0}%{F$color15} $(date +'%a - %b %d, %Y') "
}
icon_date(){
    echo "%{B$color0}%{F$color4} "
}
get_time() {
        echo "%{B$color0}%{F$color15} $(date +'%H:%M') "
}
icon_time(){
    echo "%{B$color0}%{F$color4} "
}

while true; do
    echo " %{l} $(get_ws) $(icon_song)$(get_song) \
    %{r} $(icon_network)$(get_network) $(icon_volume)$(get_volume) $(icon_battery)$(get_battery) $(icon_date)$(get_date)$(icon_time)$(get_time)%{O10}"
    sleep 1
done | lemonbar -b -g "${geo}" -f "${f1}" -f "${f2}" | sh & > /dev/null
