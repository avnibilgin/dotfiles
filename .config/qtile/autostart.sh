#!/bin/bash
#   ___ _____ ___ _     _____   ____  _             _
#  / _ \_   _|_ _| |   | ____| / ___|| |_ __ _ _ __| |_
# | | | || |  | || |   |  _|   \___ \| __/ _` | '__| __|
# | |_| || |  | || |___| |___   ___) | || (_| | |  | |_
#  \__\_\|_| |___|_____|_____| |____/ \__\__,_|_|   \__|
#
# -----------------------------------------------------

feh --bg-fill ~/.cache/current_wallpaper.jpg &
/usr/lib/polkit-kde-authentication-agent-1 &
picom --experimental-backends &
qtile cmd-obj -o cmd -f reload_config
#dunst &
/home/thor/.config/qtile/scripts/energieverwaltung.sh &
/usr/lib/kdeconnectd &
sleep 3 ; copyq --start-server &
sleep 5 ; $HOME/.config/qtile/scripts/echodot_autoconnect.sh
$HOME/.config/qtile/scripts/qtile-ddc-module.sh &
easystroke &
#/usr/bin/mcorners -tl 'xdotool key super+y' -bl 'xdotool key super+x' -br 'skippy-xd-fix' -iof &
