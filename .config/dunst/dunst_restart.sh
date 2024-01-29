#!/bin/bash
killall dunst
sleep 0.2
dunst &
notify-send "Test" &
notify-send -u critical "Your computer asplode" &
notify-send -i "emblem-synchronizing" "Passwords synced\!"
