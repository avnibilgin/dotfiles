#!/usr/bin/env bash

receive_pipe="/tmp/waybar-ddc-module-rx"
step=5
iDIR="$HOME/.config/mako/icons"

ddcutil_fast() {
    ddcutil --noverify --bus 1 --sleep-multiplier .03 "$@" 2>/dev/null
}

ddcutil_slow() {
    ddcutil --maxtries 15,15,15 "$@" 2>/dev/null
}

print_brightness() {
    if brightness=$("$@" -t getvcp 10); then
        brightness=$(echo "$brightness" | cut -d ' ' -f 4)
    else
        brightness=-1
    fi
    echo '{ "percentage":' "$brightness" '}'
}

notify_user() {
    current=$(print_brightness ddcutil_fast | jq -r '.percentage')
    if   [ "$current" -le "20" ]; then
        icon="$iDIR/brightness-20.png"
    elif [ "$current" -le "40" ]; then
        icon="$iDIR/brightness-40.png"
    elif [ "$current" -le "60" ]; then
        icon="$iDIR/brightness-60.png"
    elif [ "$current" -le "80" ]; then
        icon="$iDIR/brightness-80.png"
    else
        icon="$iDIR/brightness-100.png"
    fi
    notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$icon" "Helligkeit: $current%"
}

rm -rf $receive_pipe
mkfifo $receive_pipe

print_brightness ddcutil_slow

while true; do
    read -r command < $receive_pipe
    case $command in
        + | -)
            ddcutil_fast setvcp 10 $command $step
            notify_user
            ;;
        max)
            ddcutil_fast setvcp 10 100
            notify_user
            ;;
        min)
            ddcutil_fast setvcp 10 0
            notify_user
            ;;
    esac
    print_brightness ddcutil_fast
done
