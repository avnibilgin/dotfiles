#!/bin/bash
#                _ _
# __      ____ _| | |_ __   __ _ _ __   ___ _ __
# \ \ /\ / / _` | | | '_ \ / _` | '_ \ / _ \ '__|
#  \ V  V / (_| | | | |_) | (_| | |_) |  __/ |
#   \_/\_/ \__,_|_|_| .__/ \__,_| .__/ \___|_|
#                   |_|         |_|
#
# by Stephan Raabe (2023)
# -----------------------------------------------------

swww img ~/.cache/current_wallpaper.jpg \
    --transition-bezier .43,1.19,1,.4 \
    --transition-fps=60 \
    --transition-type="wipe" \
    --transition-duration=0.7 \
    --transition-pos "$( hyprctl cursorpos )"
