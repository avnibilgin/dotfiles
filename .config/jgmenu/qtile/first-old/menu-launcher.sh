#!/bin/bash

main_menu_file="$HOME/.config/jgmenu/qtile/test/main-menu.csv"
root_menu_file="${HOME}/.config/jgmenu/qtile/test/root-menu.csv"
rc_file="${HOME}/.config/jgmenu/qtile/test/main-menu-rc"

# Einlesen der Root-Apps in die Datei 'root-menu.csv'
jgmenu_run apps --no-prepend --no-append >"${root_menu_file}"

# Inhalt von 'append-menu.csv' wird zu 'root-menu.csv' hinzugefügt.
~/.config/jgmenu/qtile/test/append2root.sh

# Hauptmenu 'main-menu.csv' wird mittels Jgmenu-Befehl aufgerufen.
jgmenu --simple --config-file=${rc_file} --csv-file=${main_menu_file}

exit
