#!/bin/bash

# Flameshot switch utility

ON_EXEC=$(pstree | grep -c flameshot);

if [ $ON_EXEC -gt 0 ]; then
  killall -s 9 flameshot;
else
  flameshot gui;
fi
