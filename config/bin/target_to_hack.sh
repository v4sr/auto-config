#!/bin/bash
 
ip_address=$(cat /home/v4sr/.config/bin/target | awk '{print $1}')
machine_name=$(cat /home/v4sr/.config/bin/target | awk '{print $2}')
 
if [ $ip_address ] && [ $machine_name ]; then
    echo "%{F#e53935} %{F#ffffff}$ip_address%{u-} - $machine_name"
else
    echo "%{F#e53935} %{u-}%{F#ffffff} No target"
fi
