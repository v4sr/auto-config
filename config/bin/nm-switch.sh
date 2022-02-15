#!/bin/bash

# nm-applet switch utility

ON_EXEC=$(pstree | grep -c nm-applet)

if [ $ON_EXEC -gt 0 ]; then
  killall -s 9 nm-applet
else
  nm-applet
fi
