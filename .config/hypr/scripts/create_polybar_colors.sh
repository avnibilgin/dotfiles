#!/bin/bash

# Quellpfad der Datei
source_path="$HOME/.cache/wal/colors-polybar"

# Zielverzeichnis und Dateiname
target_directory="$HOME/.config/polybar/shapes"
target_filename="colors.ini"

# Zielvollständiger Pfad
target_path="$target_directory/$target_filename"

# Überprüfen, ob das Zielverzeichnis existiert, andernfalls erstellen
if [ ! -d "$target_directory" ]; then
    mkdir -p "$target_directory"
fi

# Kopiere die Datei
cp "$source_path" "$target_path"
