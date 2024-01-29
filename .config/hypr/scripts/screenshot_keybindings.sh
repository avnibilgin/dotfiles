#!/bin/bash
#  ____                               _           _
# / ___|  ___ _ __ ___  ___ _ __  ___| |__   ___ | |_
# \___ \ / __| '__/ _ \/ _ \ '_ \/ __| '_ \ / _ \| __|
#  ___) | (__| | |  __/  __/ | | \__ \ | | | (_) | |_
# |____/ \___|_|  \___|\___|_| |_|___/_| |_|\___/ \__|
#
#
# by Avni Bilgin (2023)
# -----------------------------------------------------

# Da das Bild an das Grafikbearbeitungstool "Swappy" übergeben wird,
# ist das Screenshotverzeichnis # des Tools in seiner config-file
# definiert: "/home/thor/.config/swappy/config"
# Die hier unten angebenen Orte gelten für die standalone-Nutzung von grim

DIR="$HOME/Medien/Screenshots/"
NAME="screenshot_$(date +%d-%m-%Y_%H%M%S).png"

case $1 in
    "select")
        grim -g "$(slurp)" - | swappy -f -
        notify-send "Screenshot created" "Mode: Selected area"
    ;;
    *)
        grim - | swappy -f -
        notify-send "Screenshot created" "Mode: Fullscreen"
;;
esac
