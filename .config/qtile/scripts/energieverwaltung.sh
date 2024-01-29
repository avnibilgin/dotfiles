#!/bin/bash

xidlehook \
--not-when-fullscreen \
--not-when-audio \
--timer 570 'notify-send -u critical "Achtung!" "Bildschirmsperre wird in 30 Sekunden aktiv"' \
'' \
--timer 30 '/usr/bin/betterlockscreen -l' \
'' \
--timer 3000 'systemctl suspend' \
''
