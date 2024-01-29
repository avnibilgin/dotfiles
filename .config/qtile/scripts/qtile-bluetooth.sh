#!/bin/bash

device_address_1="74:58:F3:D2:2D:E2"
device_address_2="30:53:C1:DC:44:A6"

current_device=$device_address_1

toggle_bluetooth() {
    if [ "$current_device" == "$device_address_1" ]; then
        # Disconnect device 1 and connect device 2
        bluetoothctl disconnect $device_address_1
        bluetoothctl connect $device_address_2
        current_device=$device_address_2
    else
        # Disconnect device 2 and connect device 1
        bluetoothctl disconnect $device_address_2
        bluetoothctl connect $device_address_1
        current_device=$device_address_1
    fi
}

get_icon() {
    if [ "$current_device" == "$device_address_1" ]; then
        echo ""  # Icon for your Bluetooth device
    else
        echo ""  # Icon for your Headphones
    fi
}

# Check if the script is called for toggling
if [ "$1" == "toggle" ]; then
    toggle_bluetooth
fi

# Output the current icon for Qtile to display
get_icon


#~ #!/bin/bash



#~ # Here we set the Bluetooth device address

#~ device_address="74:58:F3:D2:2D:E2"



#~ # Get the connection status of the device

#~ connection_status=$(bluetoothctl info $device_address | grep "Connected:" | awk '{print $2}')



#~ # Here we determine status based on connection status

#~ if [ "$connection_status" == "yes" ]; then

#~ status="connected"

#~ else

#~ status="disconnected"

#~ fi



#~ # Let's print initial status

#~ echo "Device $device_address is currently $status"



#~ # If the device is connected, disconnect it

#~ if [ "$connection_status" == "yes" ]; then

#~ echo "Disconnecting from $device_address..."

#~ status="disconnected"

#~ bluetoothctl << EOF

#~ disconnect $device_address

#~ EOF

#~ else

#~ # If the device is disconnected, connect to it

#~ echo "Connecting to $device_address..."

#~ status="connected"

#~ bluetoothctl << EOF

#~ connect $device_address

#~ EOF

#~ fi



#~ # Print final status

#~ echo "Device $device_address is now $status"
