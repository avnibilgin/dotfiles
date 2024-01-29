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


# SDDM
cat "/usr/share/sddm/themes/corners/themerc.conf" "$HOME/.cache/wal/colors-sddm.conf" > "/usr/share/sddm/themes/corners/theme.conf" &
