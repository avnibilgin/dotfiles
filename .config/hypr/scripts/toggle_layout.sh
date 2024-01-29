!/bin/bash

current_layout=$(hyprctl getoption general:layout | grep -oP 'str: "\K[^"]+')

if [ "$current_layout" == "dwindle" ]; then
    hyprctl keyword general:layout "master"
    echo "Switched layout to master."
else
    hyprctl keyword general:layout "dwindle"
    echo "Switched layout to dwindle."
fi
