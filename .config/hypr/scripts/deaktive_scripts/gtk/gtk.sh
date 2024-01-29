#!/bin/bash
gnome_schema="org.gnome.desktop.interface"
gsettings set "$gnome_schema" icon-theme "Papirus-Dark"
gsettings set "$gnome_schema" cursor-theme "Bibata-Modern-Ice"
gsettings set "$gnome_schema" font-name "Futura Bk BT 11"
gsettings set "$gnome_schema" color-scheme "prefer-dark"
gsettings set "$gnome_schema" gtk-theme "Nordic-darker"
