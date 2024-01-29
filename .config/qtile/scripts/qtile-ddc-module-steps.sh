#!/usr/bin/env bash

print_brightness() {
    if brightness=$(ddcutil -t getvcp 10); then
        brightness=$(echo "$brightness" | cut -d ' ' -f 4)
    else
        brightness=-1
    fi
    echo "$brightness"
}

case $1 in
        plus)
            echo ' + ' > /tmp/waybar-ddc-module-rx
            ;;
        minus)
            echo ' - ' > /tmp/waybar-ddc-module-rx
            ;;
        max)
            echo ' max ' > /tmp/waybar-ddc-module-rx
            ;;
        min)
            echo ' min ' > /tmp/waybar-ddc-module-rx
            ;;
        show)
            print_brightness
            ;;
esac
