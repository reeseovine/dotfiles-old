# Binds insert as compose key.
xmodmap -e "keysym Insert = Multi_key"

# Disable touchpad taps
synclient MaxTapTime=0

# Tell Qt to use GTK theme
QT_QPA_PLATFORMTHEME=gtk2
