#!/bin/bash

# Ziel-Datei, in der alle .jsonc Inhalte zusammengeführt werden sollen
ZIEL_DATEI="gesamt.json"

# Überprüfen und ggf. alte Ziel-Datei löschen
if [ -e "$ZIEL_DATEI" ]; then
  rm "$ZIEL_DATEI"
fi

# Durchlaufe alle .jsonc Dateien im aktuellen Verzeichnis
for datei in *.jsonc; do
  # Überprüfe, ob die Datei existiert und lesbar ist
  if [ -r "$datei" ]; then
    # Füge den Inhalt der aktuellen Datei zur Ziel-Datei hinzu
    cat "$datei" >> "$ZIEL_DATEI"
    # Füge eine Leerzeile als Trennung hinzu
    echo >> "$ZIEL_DATEI"
  else
    echo "Fehler: Die Datei $datei konnte nicht gelesen werden."
  fi
done

echo "Der Zusammenführungsprozess ist abgeschlossen. Die Ergebnisse befinden sich in $ZIEL_DATEI."
