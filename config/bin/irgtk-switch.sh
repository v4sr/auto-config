#!/bin/bash

# input-remapper-gtk switch utility

ON_EXEC=$(pstree | grep -c irgtk-switch.sh)

if [ $ON_EXEC -gt 0 ]; then
  killall -s 9 irgtk-switch;
else
  alacritty --config-file /home/v4sr/.config/alacritty/alacritty.yml -e $SHELL -lc "sudo input-remapper-gtk";
fi
