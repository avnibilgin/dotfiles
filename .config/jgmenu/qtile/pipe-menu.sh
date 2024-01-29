#!/bin/bash
##
## menu-pipe

item="$1"
declare -A MENU_ARR

MENU_ARR[favorites-menu]='

Web Browser,firefox,firefox
File Manager,dolphin,system-file-manager
Terminal,kitty,utilities-terminal
Text Editor,geany,geany
^sep()
KeepassXC,keepassxc,keepassxc
Obsidian,~/Applications/Obsidian-1.5.3_9d05c0a25ba09a76045a8778be11300a.AppImage --no-sandbox %U,obsidian
FeatherNotes,feathernotes,feathernotes

'

MENU_ARR[exit-menu]='

  Lock,betterlockscreen -l
  Logout,qtile cmd-obj -o cmd -f shutdown
  Reboot,systemctl reboot
  Suspend,systemctl suspend
  Poweroff,systemctl poweroff

'

MENU_ARR[bluetooth-menu]='

Blutooth Manager, blueman-manager, blueman
^sep(Lautsprecher (Echo Dot-J1W))
 Koppeln,bluetoothctl connect 74:58:F3:D2:2D:E2
 Entkoppeln, bluetoothctl disconnect 74:58:F3:D2:2D:E2
^sep(Kopfhörer (WF-C500))
 Koppeln,bluetoothctl connect 30:53:C1:DC:44:A6
 Entkoppeln,bluetoothctl disconnect 30:53:C1:DC:44:A6

'

echo "${MENU_ARR[${item}]}"
