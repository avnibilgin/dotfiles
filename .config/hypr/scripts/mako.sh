#!/bin/bash

case $1 in
    "toggle_mode")
CURRENT_MODE=$(makoctl mode)

if [ "$CURRENT_MODE" = "default" ]; then
    makoctl set-mode do-not-disturb
    echo "󰂛"
else
    makoctl set-mode default
    echo "󰂚"
fi
    ;;
    *)
        MODE=$(makoctl mode)
        COUNT=$(makoctl count)

        ENABLED="󰂚"
        DISABLED="󰂛"

        if [ "$COUNT" -ne 0 ]; then
            DISABLED="󰂛 $COUNT"
        fi

        if [ "$MODE" = "default" ]; then
            echo "$ENABLED"
        else
            echo "$DISABLED"
        fi
    ;;
esac

# makoctl mode (Modus zeigen)
# makoctl set-mode do-not-disturb
# makoctl set-mode default
