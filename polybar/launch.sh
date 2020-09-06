#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# wait
sleep 2

# Launch bar
polybar -c ~/.config/polybar/config.ini main &
