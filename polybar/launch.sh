#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# wait
sleep 2

# Launch bar1 and bar2
polybar -c ~/.config/polybar/config.ini main &
