#!/bin/bash

TIMER_FILE="/var/tmp/waybar_timer"

case "$1" in
    up)
        # Überprüfen, ob die Timer-Datei existiert und NICHT "READY" ist
        if [ -f "$TIMER_FILE" ] && [ "$(cat "$TIMER_FILE")" != "READY" ]; then
            # Aktuellen Timer-Wert aus der Datei lesen
            CURRENT_TIMER=$(cat "$TIMER_FILE")
        else
            # Wenn die Datei nicht existiert oder "READY" ist, setze den Timer-Wert auf die bestehenden Daten
            CURRENT_TIMER=$(date +%s)
        fi

        # Wenn der Timer nicht "READY" ist, füge 5 Minuten zum aktuellen Timer-Wert hinzu
        if [ "$CURRENT_TIMER" != "READY" ]; then
            NEW_TIMER=$((CURRENT_TIMER + 5 * 60))
            # Setze den neuen Timer-Wert in die Datei
            echo $NEW_TIMER > "$TIMER_FILE"
        fi

        # Gib den aktualisierten Timer-Wert in MM:SS-Format aus
        echo $(date -d @$CURRENT_TIMER +%M:%S)
        ;;

    down)
        # Überprüfen, ob die Timer-Datei existiert
        if [ -f "$TIMER_FILE" ] && [ "$(cat "$TIMER_FILE")" != "READY" ]; then
            # Aktuellen Timer-Wert aus der Datei lesen
            CURRENT_TIMER=$(cat "$TIMER_FILE")
        else
            # Wenn die Datei nicht existiert oder "READY" ist, setze den Timer-Wert auf die bestehenden Daten
            CURRENT_TIMER=$(date +%s)
        fi

        # Subtrahiere 5 Minuten vom aktuellen Timer-Wert
        NEW_TIMER=$((CURRENT_TIMER - 5 * 60))

        # Überprüfen, ob der neue Timer-Wert kleiner ist als der aktuelle Timer-Wert
        if [ "$NEW_TIMER" -lt "$CURRENT_TIMER" ]; then
            # Setze den neuen Timer-Wert in die Datei
            echo "$NEW_TIMER" > "$TIMER_FILE"
            # Gib den aktualisierten Timer-Wert in MM:SS-Format aus
            echo $(date -d @"$NEW_TIMER" +%M:%S)
        else
            # Wenn der neue Timer-Wert nicht kleiner ist, schreibe "READY" in die Timer-Datei
            echo "READY" > "$TIMER_FILE"
        fi
        ;;

    date30set)
        date --date='30 minutes' +%s > /var/tmp/waybar_timer
        ;;

    readyset)
        echo READY > /var/tmp/waybar_timer
        ;;

    date1set)
        date --date='45 minute' +%s > /var/tmp/waybar_timer
        ;;

    *)
        echo "Ungültige Option ausgewählt. Bitte wähle up oder down."
        ;;
esac
