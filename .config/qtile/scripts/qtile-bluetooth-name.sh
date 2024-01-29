#!/bin/bash

get_active_device_name() {
    # Get the active Bluetooth device name
    active_device_name=$(bluetoothctl info | grep "Name" | awk -F ' ' '{print $2}')

    if [ -n "$active_device_name" ]; then
        echo "$active_device_name"
    else
        echo "Off"
    fi
}

# Output the active device name or "Off" for Qtile to display
get_active_device_name
