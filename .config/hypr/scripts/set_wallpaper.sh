#!/bin/bash
#                _ _
# __      ____ _| | |_ __   __ _ _ __   ___ _ __
# \ \ /\ / / _` | | | '_ \ / _` | '_ \ / _ \ '__|
#  \ V  V / (_| | | | |_) | (_| | |_) |  __/ |
#   \_/\_/ \__,_|_|_| .__/ \__,_| .__/ \___|_|
#                   |_|         |_|
#
# by Avni Bilgin (2023)
# -----------------------------------------------------

# Erstelle mit Pywal Farbpaletten
wal -q -i "$1"

# Kopiere Hintergrundbild in den Cache-Ordner
cp "$1" $HOME/.cache/current_wallpaper.jpg

# Setze das neue Wallpaper
swww img $HOME/.cache/current_wallpaper.jpg \
    --transition-bezier .43,1.19,1,.4 \
    --transition-fps=60 \
    --transition-type="wipe" \
    --transition-duration=0.7 \
    --transition-pos "$( hyprctl cursorpos )"

# Erstelle ein verschwommenes Hintergrundbild für Rofi
convert -strip -scale 10% -blur 0x3 -resize 100% "$1" "$HOME/.cache/current_wallpaper.blur" &

# Erstelle benutzerdefinierte Config-Dateien (mit PyWal-Templates)
$HOME/.config/hypr/scripts/create_sddm_config.sh &
$HOME/.config/hypr/scripts/create_module_clock_colors.sh &

# Starte Waybar neu
killall waybar
sleep 1
waybar &
