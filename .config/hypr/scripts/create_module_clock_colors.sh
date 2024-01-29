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


# Module-CLOCK Dynamische Farb-Formatierung der Kalenderanzeige

# Pfad zur Waybar-Datei
waybar_file="$HOME/.config/waybar/dcol_modules/clock.json"

# Pfad zur Ersatzdatei
replacement_file="$HOME/.cache/wal/module-clock.dcol"

# Überprüfen, ob die Ersatzdatei existiert
if [ -f "$replacement_file" ]; then
    # Ersetze die Bereiche in der Waybar-Datei
    awk -v replacement_file="$replacement_file" '
      BEGIN {
        # Lese den Inhalt der Ersatzdatei in ein Array
        while ((getline < replacement_file) > 0) {
          replacement_array[++num_replacements] = $0
        }
        close(replacement_file)
      }

      # Ersetze "months" Bereich
      /"months":/,/"/ {
        if (!replaced_months) {
          print replacement_array[1]
          replaced_months = 1
          next
        }
      }

      # Ersetze "weekdays" Bereich
      /"weekdays":/,/"/ {
        if (!replaced_weekdays) {
          print replacement_array[2]
          replaced_weekdays = 1
          next
        }
      }

      # Ersetze "today" Bereich
      /"today":/,/"/ {
        if (!replaced_today) {
          print replacement_array[3]
          replaced_today = 1
          next
        }
      }

      # Standardmäßig alle anderen Zeilen ausgeben
      {
        print
      }
    ' "$waybar_file" > tmpfile && mv tmpfile "$waybar_file"

    echo "Ersetzung erfolgreich durchgeführt."
else
    echo "Fehler: Die Ersatzdatei existiert nicht."
fi
