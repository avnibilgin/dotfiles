#!/bin/bash

##############################################################################
#                                                                            #
#  Farbdefinitionen aus den entsprechenden config Dateien                    #
#  werden durch Pywal-Templates erstellt und mit den Befehlen unten          #
#  wieder zu einer einzigen configrc Datei zusammengefügt. Dafür muss die    #
#  originale configrc Datei (bereinigt von den Farbdefinitioten die von      #
#  Pywal-Templates erstellt werden) zu config.conf manuell umbenannt werden. #
#                                                                            #
##############################################################################

# Dunst

cat "$HOME/.config/dunst/dunst.conf" "$HOME/.cache/wal/colors-dunst.conf" > "$HOME/.config/dunst/dunstrc"
killall dunst
dunst &
