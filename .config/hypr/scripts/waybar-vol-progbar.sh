#!/bin/bash

iDIR="$HOME/.config/mako/icons"
VOLUME_STEP=5

# Get Volume
get_volume() {
    volume=$(pamixer --get-volume)
    echo "$volume"
}

# Get icons
get_icon() {
    current=$(get_volume)
    if [[ "$current" -eq "0" ]]; then
        echo "$iDIR/volume-mute.png"
    elif [[ ("$current" -ge "0") && ("$current" -le "30") ]]; then
        echo "$iDIR/volume-low.png"
    elif [[ ("$current" -ge "30") && ("$current" -le "60") ]]; then
        echo "$iDIR/volume-mid.png"
    elif [[ ("$current" -ge "60") && ("$current" -le "100") ]]; then
        echo "$iDIR/volume-high.png"
    fi
}

# Common function to generate notification messages
generate_notification() {
    local icon=$1
    local message=$2
    notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$icon" "$message"
}

# Notify
notify_user() {
    local icon=$(get_icon)
    local volume=$(get_volume)
    generate_notification "$icon" "Volume: $volume %"
}

# Increase Volume
inc_volume() {
    pamixer -i "$VOLUME_STEP" && notify_user
}

# Decrease Volume
dec_volume() {
    pamixer -d "$VOLUME_STEP" && notify_user
}

# Toggle Mute
toggle_mute() {
    if [ "$(pamixer --get-mute)" == "false" ]; then
        pamixer -m && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$iDIR/volume-mute.png" "Volume: OFF"
    elif [ "$(pamixer --get-mute)" == "true" ]; then
        pamixer -u && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$(get_icon)" "Volume: ON"
    fi
}

# Toggle Mic
toggle_mic() {
    if [ "$(pamixer --default-source --get-mute)" == "false" ]; then
        pamixer --default-source -m && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$iDIR/microphone-mute.png" "Microphone: OFF"
    elif [ "$(pamixer --default-source --get-mute)" == "true" ]; then
        pamixer -u --default-source u && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$iDIR/microphone.png" "Microphone: ON"
    fi
}

# Get icons
get_mic_icon() {
    current=$(pamixer --default-source --get-volume)
    if [[ "$current" -eq "0" ]]; then
        echo "$iDIR/microphone.png"
    elif [[ ("$current" -ge "0") && ("$current" -le "30") ]]; then
        echo "$iDIR/microphone.png"
    elif [[ ("$current" -ge "30") && ("$current" -le "60") ]]; then
        echo "$iDIR/microphone.png"
    elif [[ ("$current" -ge "60") && ("$current" -le "100") ]]; then
        echo "$iDIR/microphone.png"
    fi
}

# Notify Mic
notify_mic_user() {
    local mic_icon=$(get_mic_icon)
    local mic_volume=$(pamixer --default-source --get-volume)
    generate_notification "$mic_icon" "Mic-Level: $mic_volume %"
}

# Increase MIC Volume
inc_mic_volume() {
    pamixer --default-source -i "$VOLUME_STEP" && notify_mic_user
}

# Decrease MIC Volume
dec_mic_volume() {
    pamixer --default-source -d "$VOLUME_STEP" && notify_mic_user
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
    get_volume
elif [[ "$1" == "--inc" ]]; then
    inc_volume
elif [[ "$1" == "--dec" ]]; then
    dec_volume
elif [[ "$1" == "--toggle" ]]; then
    toggle_mute
elif [[ "$1" == "--toggle-mic" ]]; then
    toggle_mic
elif [[ "$1" == "--get-icon" ]]; then
    get_icon
elif [[ "$1" == "--get-mic-icon" ]]; then
    get_mic_icon
elif [[ "$1" == "--mic-inc" ]]; then
    inc_mic_volume
elif [[ "$1" == "--mic-dec" ]]; then
    dec_mic_volume
else
    get_volume
fi
