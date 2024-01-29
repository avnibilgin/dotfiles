#!/bin/bash

prepend_file="$HOME/.config/jgmenu/qtile/prepend.csv"
root_menu_file="$HOME/.config/jgmenu/qtile/root-menu.csv"
append_file="$HOME/.config/jgmenu/qtile/append.csv"
main_menu_file="$HOME/.config/jgmenu/qtile/main-menu.csv"
rc_file="${HOME}/.config/jgmenu/qtile/main-menu-rc"

# Einlesen der Root-Apps in die Datei 'root-menu.csv'
#jgmenu_run apps --prepend-file=${prepend_file} --append-file=${append_file} >"${root_menu_file}"
jgmenu_run apps --prepend-file=${prepend_file} --append-file=${append_file} >"${root_menu_file}"

# Inhalt von 'append-menu.csv' wird zu 'root-menu.csv' hinzugefügt.
#~/.config/jgmenu/qtile/test/append2root.sh

# Hauptmenu 'main-menu.csv' wird mittels Jgmenu-Befehl aufgerufen.
jgmenu --simple --config-file=${rc_file} --csv-file=${main_menu_file}

exit
