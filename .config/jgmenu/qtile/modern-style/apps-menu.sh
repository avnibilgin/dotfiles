#!/bin/sh
##  save jgmenu apps module output, and run with jgmenu
## by @damo March 2020

# apps-menu.csv is sourced by apps.csv
MENU_FILE="${HOME}/.config/jgmenu/qtile/apps-menu.csv"

# use env var to only output applications module
jgmenu_run apps >"${MENU_FILE}"

# display menu
jgmenu --simple --config-file=$HOME/.config/jgmenu/qtile/appsrc --csv-file=$HOME/.config/jgmenu/qtile/apps.csv

exit
