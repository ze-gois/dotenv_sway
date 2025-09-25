#!/bin/bash

choice=$(printf "Cancel\nYes, exit sway" | wmenu -p "Do you really want to exit sway?" -l 2)

case "$choice" in
    "Yes, exit sway")
        swaymsg exit
        ;;
    *)
        ;;
esac
