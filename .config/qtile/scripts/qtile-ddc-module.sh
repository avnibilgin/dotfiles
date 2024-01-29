#!/usr/bin/env bash

# Hier werden zwei Variablen definiert: receive_pipe, der den Pfad
# zu einer FIFO-Pipeline (Named Pipe) speichert, und step, der den
# Schritt oder die Inkremente für Helligkeitsanpassungen festlegt.

receive_pipe="/tmp/waybar-ddc-module-rx"
step=5

# Dies sind Funktionen, die die DDCUtil-Befehle mit verschiedenen
# Parametern aufrufen. ddcutil_fast wird verwendet, um schnelle
# Helligkeitsanpassungen durchzuführen, während ddcutil_slow für
# langsame Anpassungen mit maximalen Versuchen konfiguriert ist.

ddcutil_fast() {
    ddcutil --noverify --bus 1 --sleep-multiplier .03 "$@" 2>/dev/null
}

ddcutil_slow() {
    ddcutil --maxtries 15,15,15 "$@" 2>/dev/null
}

# Diese Funktion ruft den DDCUtil-Befehl auf, um die aktuelle Bildschirmhelligkeit
# abzurufen, und gibt das Ergebnis im JSON-Format aus. Wenn der Abruf erfolgreich
# ist, wird die Helligkeit extrahiert und als JSON-String formatiert.

print_brightness() {
    if brightness=$("$@" -t getvcp 10); then
        brightness=$(echo "$brightness" | cut -d ' ' -f 4)
    else
        brightness=-1
    fi
    echo "$brightness"
}

# Hier wird die vorhandene FIFO-Pipeline (falls vorhanden) gelöscht und eine
# neue erstellt.

# 1. SCHRITT (läuft einmalig bei Initialisierung)
rm -rf $receive_pipe
mkfifo $receive_pipe

# Das Skript gibt zu Beginn die aktuelle Bildschirmhelligkeit aus, um
# sicherzustellen, dass es nach einem Neustart von Waybar oder nach dem
# Neustart/Umstecken eines Monitors korrekt funktioniert.

# 2. SCHRITT (läuft einmalig bei Initialisierung)
print_brightness ddcutil_slow

# Hier befindet sich die Hauptschleife des Programms. Sie wartet auf Befehle,
# die über die FIFO-Pipeline empfangen werden. Je nach empfangenem Befehl werden
# die entsprechenden DDCUtil-Befehle ausgeführt, um die Bildschirmhelligkeit
# anzupassen. Danach wird die aktuelle Helligkeit erneut ausgegeben. Der
# Schleifenbetrieb läuft kontinuierlich, um auf weitere Befehle zu warten.

# 3. SCHRITT (läuft dauerhaft)
while true; do
    read -r command < $receive_pipe
    case $command in
        + | -)
            ddcutil_fast setvcp 10 $command $step
            ;;
        max)
            ddcutil_fast setvcp 10 100
            ;;
        min)
            ddcutil_fast setvcp 10 0
            ;;
    esac
    print_brightness ddcutil_fast
done
