#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

## Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

## Launch

## Left bar
polybar LOGO -c ~/.config/polybar/current.ini &
polybar DATE -c ~/.config/polybar/current.ini &
polybar IP -c ~/.config/polybar/current.ini &
polybar HTB -c ~/.config/polybar/current.ini &

## Right bar
polybar SETTINGS -c ~/.config/polybar/current.ini &
polybar SYS -c ~/.config/polybar/current.ini &
polybar TARGET -c ~/.config/polybar/current.ini &

## Center bar
polybar primary -c ~/.config/polybar/workspace.ini &

#if [ $(xrandr --query | grep " connected" | grep -v eDP | cut -d" " -f1) = "HDMI-A-0" ]; then
#	## Left bar
#	polybar main_ext -c ~/.config/polybar/current.ini &
#	polybar LOGO_external -c ~/.config/polybar/current.ini &
#	polybar DATE_external -c ~/.config/polybar/current.ini &
#	polybar IP_external -c ~/.config/polybar/current.ini &
#	polybar HTB_external -c ~/.config/polybar/current.ini &
#
#	## Right bar
#	polybar SETTINGS_external -c ~/.config/polybar/current.ini &
#	polybar SYS_external -c ~/.config/polybar/current.ini &
#	polybar TARGET_external -c ~/.config/polybar/current.ini &
#	polybar MONITOR -c ~/.config/polybar/current.ini &
#	polybar MONITOR_external -c ~/.config/polybar/current.ini &
#	/home/v4sr/.config/bspwm/scripts/monitor_swap
#
#	## Center bar
#	polybar primary_external -c ~/.config/polybar/workspace.ini &
#fi;
