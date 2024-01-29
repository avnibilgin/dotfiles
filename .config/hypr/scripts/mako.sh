#!/bin/bash

case $1 in
    "toggle_mode")
CURRENT_MODE=$(makoctl mode)

if [ "$CURRENT_MODE" = "default" ]; then
    makoctl mode -s do-not-disturb
    echo "󰂛"
else
    makoctl mode -s default
    echo "󰂚"
fi
    ;;
    *)
        MODE=$(makoctl mode)
        COUNT=$(makoctl list | jq '[.data[] | .[].id.data] | length')

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

# makoctl mode (show modus)
# makoctl -s or -a do-not-disturb
# makoctl -s or -r default
