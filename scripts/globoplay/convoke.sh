#!/usr/bin/zsh

SCRIPT_PY="$DOTENV_PATH/sway/scripts/globoplay/chromium_history.py"

MAX_OPEN=${1:-6}
opened=0

messager=swaymsg

if [ $MAX_OPEN -gt 1 ]; then
    for i in {1..10}; do
        echo $messager "focus parent"
        $messager "focus parent"
    done
    $messager "split h"
fi

# for url in {0..$MAX_OPEN}; do
for url in $(python "$SCRIPT_PY" | shuf); do
    chromium --new-window --app="$url" &

    opened=$((opened+1))

    if [ "$opened" -ge "$MAX_OPEN" ]; then
        if [ "$MAX_OPEN" -gt "1" ]; then
            $messager "resize set width 8ppt"
            sleep 1
            $messager "focus parent"
            $messager "split h"
        fi
        break
    fi

    if [ $opened -eq 1 ]; then
        sleep 1
        $messager "split v"
    fi
done
