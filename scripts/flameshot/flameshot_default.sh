#!/usr/bin/sh
export QT_QPA_PLATFORM=wayland
export XDG_CURRENT_DESKTOP=sway  # Replace 'sway' with your compositor (e.g., gnome, hyprland)
/usr/bin/flameshot gui "$@"
swaymsg floating enable
