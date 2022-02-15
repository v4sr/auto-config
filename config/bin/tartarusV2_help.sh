#!/bin/bash 

INSTALLED=$(which notify-send)

if [ "$INSTALLED" = "notify-send not found" ]; then
  echo "[!] Error: notify-send not installed"
else
  notify-send "Razer Tartarus V2 Help" \
"01: Ranger
02: Mate Calculator
03: Obsidian
04: Signal
05: Flameshot (fs-switch.sh)
06: LibreOffice
07: Lunar NeoVim
08: Pluma
09: Gimp
10: input-remapper-gtk (irgtk-switch.sh)
11: Polychromatic
12: RazerGenie
13: AUP (Auto Update and Parrot upgrade)
14: nm-applet (nm-switch.sh)
15: Htop
16: FileZilla client (fz-switch.sh)
17: Unasigned
18: Unasigned
19: Unasigned
20: Unasigned

Main button: Close focused window
Joystick: Unasigned
Mouse up Unasigned
Mouse down: Unasigned
Mouse Centre: Help notification" \
  -u critical   \
  -i razer_logo \
  -t 100000
fi

