#!/bin/sh

bspc monitor eDP -s HDMI-A-0
bspc query -M --names | head -n 1 > /home/v4sr/.config/bin/monitor;
