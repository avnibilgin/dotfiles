#!/usr/bin/env bash

SIGNAL=1
pid_file="/tmp/waybar-screenrecorder"
wf_recorder_opts="--audio"
video_extension="mp4"

get_status() {
    if [ -e "$pid_file" ]; then
        awk 'BEGIN{printf "{\"text\":\"<span color=\\\"#dc2f2f\\\"></span>\", \"tooltip\":\"Recording\\n"}
        NR==1{printf "PID: %s\\n", $0}
        NR==2{printf "Save to: %s\\n", $0}
        NR==3{printf "Log to: %s\"}\n", $0}' "$pid_file"
    else
        printf '{"text":"", "tooltip":"Stopped"}\n'
    fi
}

toggle_recording() {
    if [ $# -eq 0 ]; then
        printf "ERROR: Argument not provided\n"
        exit 1
    fi

    if [ -e "$pid_file" ]; then
        pid=$(awk 'NR==1' "$pid_file")
        kill "$pid"
        wait "$pid" 2>/dev/null  # Warten, bis der Prozess beendet ist
        rm "$pid_file"
    else
        start_recording "$1"
    fi
    pkill -RTMIN+$SIGNAL -x waybar
}

start_recording() {
    mkdir -p "$HOME/Medien/Screencasts"
    base_file="$HOME/Medien/Screencasts/$(date +'%Y%m%dT%H%M%S')"
    video_file="$base_file.$video_extension"
    log_file="$base_file.log"

    if [ "$1" == "fullscreen" ]; then
        wf-recorder $wf_recorder_opts --file "$video_file" 1>"$log_file" 2>&1 &
    elif [ "$1" == "region" ]; then
        sleep 1
        wf-recorder $wf_recorder_opts --geometry "$(slurp)" --file "$video_file" 1>"$log_file" 2>&1 &
    else
        printf "Argument \$1='%s' not valid (fullscreen/region)\n" "$1"
        exit
    fi

    pid=$(jobs -p | tail -n 1)
    printf "%d\n%s\n%s" "$pid" "$video_file" "$log_file" > "$pid_file"
    disown "$pid"
}

case "$1" in
    "status")
        get_status
        ;;
    "toggle")
        toggle_recording "$2"
        ;;
    *)
        printf "ERROR: Argument %s not valid\n" "$1"
        ;;
esac


#~ # Erstelle einen Dateinamen mit dem aktuellen Datum und Uhrzeit
#~ current_datetime=$(date +"%Y-%m-%d_%H%M%S")
#~ output_file="$HOME/Medien/Screencasts/${current_datetime}.mp4"

        #~ # Führe wf-recorder mit den angegebenen Parametern aus
        #~ wf-recorder -a --file="$output_file"
