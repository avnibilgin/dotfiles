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

# -----------------------------------------------------
# Übergebe den ausgewählten Dateinamen als Parameter
# -----------------------------------------------------
selected="$1"

# -----------------------------------------------------
# Überprüfe, ob die Datei existiert
# -----------------------------------------------------
if [ ! -f "$selected" ]; then
    echo "Fehler: Datei '$selected' existiert nicht."
    exit 1
fi

# -----------------------------------------------------
# Übergebe  Wallpaper an Pywal
# -----------------------------------------------------
wal -q -i "$selected"

# -----------------------------------------------------
# Load current pywal color scheme
# -----------------------------------------------------
source "$HOME/.cache/wal/colors.sh"
echo "Wallpaper: $wallpaper"

# -----------------------------------------------------
# Copy selected wallpaper into .cache folder
# -----------------------------------------------------
cp $wallpaper ~/.cache/current_wallpaper.jpg

# -----------------------------------------------------
# get wallpaper image name
# -----------------------------------------------------
newwall=$(echo $wallpaper | sed "s|$HOME/wallpaper/||g")

# -----------------------------------------------------
# Reload waybar with new colors
# -----------------------------------------------------
~/dotfiles/waybar/launch.sh

# -----------------------------------------------------
# Set the new wallpaper
# -----------------------------------------------------
transition_type="wipe"
# transition_type="outer"
# transition_type="random"

swww img $wallpaper \
    --transition-bezier .43,1.19,1,.4 \
    --transition-fps=60 \
    --transition-type=$transition_type \
    --transition-duration=0.7 \
    --transition-pos "$( hyprctl cursorpos )"

# -----------------------------------------------------
# Send notification
# -----------------------------------------------------
sleep 1
notify-send "Farben und Hintergrundbild aktualisiert" "Neues Bild: $newwall"

echo "ERLEDIGT!"
