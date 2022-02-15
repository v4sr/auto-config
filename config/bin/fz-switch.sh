#!/bin/bash

# FileZilla switch utility

ON_EXEC=$(pstree | grep -c filezilla)

if [ $ON_EXEC -gt 0 ]; then
  notify-send "FileZilla" "Client closed" -u critical -i FZ_logo -t 3000
  killall -s 9 filezilla;
else
  notify-send "FileZilla" "Client opened" -u critical -i FZ_logo -t 3000
  /opt/FileZilla3/bin/filezilla;
fi
