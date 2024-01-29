#!/bin/bash

main_menu_file="$HOME//.config/jgmenu/qtile/exit-menu/exit-menu.csv"
rc_file="$HOME/.config/jgmenu/qtile/exit-menu/exit-menu-rc"

# Hauptmenu 'main-menu.csv' wird mittels Jgmenu-Befehl aufgerufen.
jgmenu --simple --config-file=${rc_file} --csv-file=${main_menu_file}
