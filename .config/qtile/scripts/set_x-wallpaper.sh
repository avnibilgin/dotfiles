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

sleep 1

# Lade das neue Wallpaper → Es wid durch qtile-config.py die aktualisierte
# "$HOME/.cache/current_wallpaper.jpg"-Datei als Hintergrund gesetzt.
qtile cmd-obj -o cmd -f reload_config

# Erstelle ein verschwommenes Hintergrundbild für Rofi
convert -strip -scale 10% -blur 0x3 -resize 100% "$1" "$HOME/.cache/current_wallpaper.blur" &

# Erstelle benutzerdefinierte Config-Dateien (mit PyWal-Templates)
$HOME/.config/hypr/scripts/create_dunst_config.sh &
$HOME/.config/qtile/scripts/create_jgmenu_config_X.sh &
$HOME/.config/hypr/scripts/create_sddm_config.sh &
$HOME/.config/hypr/scripts/create_module_clock_colors.sh &
# $HOME/.config/hypr/scripts/create_polybar_colors.sh &

# Aktualisiere betterlockscreen Wallpaper
betterlockscreen -u $HOME/.cache/current_wallpaper.jpg &
