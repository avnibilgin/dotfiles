#!/bin/bash
##
## menu-pipe

item="$1"
declare -A MENU_ARR

MENU_ARR[exit-menu]='

. ~/.config/jgmenu/qtile/test/exit-menu.csv

'

MENU_ARR[prepend-menu]='

. ~/.config/jgmenu/qtile/test/prepend-menu.csv

'

echo "${MENU_ARR[${item}]}"
