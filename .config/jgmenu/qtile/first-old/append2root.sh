#!/bin/bash

root_menu_file="$HOME/.config/jgmenu/qtile/test/root-menu.csv"
append_menu_file="$HOME/.config/jgmenu/qtile/test/append-menu.csv"

# Extrahiere Zeilen mit "checkout" aus 'append-menu.csv'
grep "checkout" "$append_menu_file" > tmp-checkout-lines.txt

# Füge checkout-Zeilen hinter der letzten "checkout" in root-menu.csv ein
last_checkout_line=$(grep -n "checkout" "$root_menu_file" | tail -n 1 | cut -d ":" -f 1)
awk -v last_checkout_line="$last_checkout_line" 'NR<=last_checkout_line{print}NR==last_checkout_line+1{while(getline<"'"tmp-checkout-lines.txt"'")print}NR>last_checkout_line+1' "$root_menu_file" > tmp-apps-menu.csv
mv tmp-apps-menu.csv "$root_menu_file"

# Extrahiere Zeilen -nach- "checkout" aus 'append-menu.csv' → ^tag-Zeilen
last_checkout_line=$(grep -n "checkout" "$append_menu_file" | tail -n 1 | cut -d ":" -f 1)
awk -v last_checkout_line="$last_checkout_line" 'NR>last_checkout_line' "$append_menu_file" > tmp-tag-lines.txt

# Füge ^tag-Zeilen ans Ende von root-menu.csv ein
cat tmp-tag-lines.txt >> "$root_menu_file"

# Lösche temporäre Dateien
rm tmp-checkout-lines.txt
rm tmp-tag-lines.txt
