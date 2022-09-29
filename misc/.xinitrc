# Disable touchpad taps
synclient MaxTapTime=0

# Tell Qt to use GTK theme
QT_QPA_PLATFORMTHEME=gtk2

# Start polkit agent
/usr/lib/polkit-gnome-authentication-agent-1 &

# Apply Xmodmap
xmodmap ~/.Xmodmap
xset r rate 500 60
