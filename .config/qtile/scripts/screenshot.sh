#!/bin/bash
#  ____                               _           _
# / ___|  ___ _ __ ___  ___ _ __  ___| |__   ___ | |_
# \___ \ / __| '__/ _ \/ _ \ '_ \/ __| '_ \ / _ \| __|
#  ___) | (__| | |  __/  __/ | | \__ \ | | | (_) | |_
# |____/ \___|_|  \___|\___|_| |_|___/_| |_|\___/ \__|
#
#
# by Stephan Raabe (2023)
# -----------------------------------------------------

DIR="$HOME/Medien/Screenshots/"
NAME="screenshot_$(date +%d%m%Y_%H%M%S).png"

option1="sel_sav_org"
option2="sel_sav_mod"
option3="sel_clp_org"
option4="sel_clp_mod"

case $1 in
    $option1)
        flameshot gui --clipboard --path "$HOME/Medien/Screenshots/" --accept-on-select
        #notify-send "Screenshot erstellt" "Modus: GESPEICHERT + ORIGINAL"
    ;;
    $option2)
        flameshot gui --clipboard --path "$HOME/Medien/Screenshots/"
        #notify-send "Screenshot erstellt" "Modus: GESPEICHERT + BEARBEITET"
    ;;
    $option3)
        flameshot gui --clipboard --accept-on-select
        #notify-send "Screenshot erstellt" "Modus: ZWISCHENABLAGE + ORIGINAL"
    ;;
    $option4)
        flameshot gui --clipboard
        #notify-send "Screenshot erstellt" "Modus: ZWISCHENABLAGE + BEARBEITET"
    ;;
esac
