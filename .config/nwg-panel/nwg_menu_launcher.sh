#!/bin/bash

nwg-menu \
  -s "menu-start2.css" \
  -va "top" \
  -ha "left" \
  -fm "dolphin" \
  -cmd-lock "swaylock -f" \
  -cmd-logout "hyprctl dispatch exit" \
  -cmd-restart "systemctl -i reboot" \
  -cmd-shutdown "systemctl -i poweroff" \
  -d \
#~ menu styling
#~ -height 300 \
#~ -width 400
#~ -isl 32 \
#~ -iss 16 \
#~ -lang "de" \
#~ -padding 2 \
# -mb 100 \
#~ -ml 10 \
#~ -mr 10 \
# -mt 100 \
#~ -o "your_output_name" \
#~ -term "alacritty" \
#~ -v \
