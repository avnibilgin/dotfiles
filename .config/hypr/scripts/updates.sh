#!/bin/bash


# Determine the terminal
term="kitty"

# Determine the AUR helper
aur_hlpr="yay"

# Define threshholds for color indicators
threshhold_green=0
threshhold_yellow=1
threshhold_red=50

# -----------------------------------------------------
# Calculate available updates pacman and aur (with yay)
# -----------------------------------------------------

if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
    updates_arch=0
fi

if ! updates_aur=$($aur_hlpr -Qua | wc -l); then
    updates_aur=0
fi

if pkg_installed flatpak ; then
    updates_flatpak=$(flatpak remote-ls --updates | wc -l)
    fpk_disp="\n󰏓 Flatpak $updates_flatpak"
    fpk_exup="; flatpak update"
else
    updates_flatpak=0
    fpk_disp=""
fi

updates=$(("$updates_arch" + "$updates_aur" + "$updates_flatpak"))

# -----------------------------------------------------
# Testing
# -----------------------------------------------------

# Overwrite updates with numbers for testing
# updates=101

# test JSON output
# printf '{"text": "20", "alt": "ALT", "tooltip": "30 Updates", "class": "green"}'
#  exit

# -----------------------------------------------------
# Output in JSON format for Waybar Module custom-updates
# -----------------------------------------------------

css_class="green"

if [ "$updates" -gt $threshhold_yellow ]; then
    css_class="yellow"
fi

if [ "$updates" -gt $threshhold_red ]; then
    css_class="red"
fi

if [ "$updates" -gt $threshhold_green ]; then
    printf '{"text": "%s", "alt": "%s", "tooltip": "%s Official | %s AUR | %s Flatpak", "class": "%s"}' "$updates" "$updates" "$updates_arch" "$updates_aur" "$updates_flatpak" "$css_class"
else
    printf '{"text": "0", "alt": "0", "tooltip": " Pakete sind aktuell", "class": "green"}'
fi

# Trigger upgrade

if [ "$1" == "up" ] ; then
    $term --title systemupdate sh -c "$aur_hlpr -Syu $fpk_exup"
    notify-send "Update erfolgreich beendet"
fi
