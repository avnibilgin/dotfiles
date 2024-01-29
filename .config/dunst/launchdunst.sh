#!/bin/bash

cat "$HOME/.config/dunst/dunst.conf" "$HOME/.cache/wal/colors-dunst.conf" > "$HOME/.config/dunst/dunstrc"
killall dunst
dunst &
