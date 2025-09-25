#!/usr/bin/zsh

SCRIPT_PY="$DOTENV_PATH/sway/scripts/twitch/chromium_history.py"
CURRENT_CHROMIUM="$DOTENV_PATH/sway/scripts/twitch/current_chromium.sh"

MAX_OPEN=${1:-1}
opened=0

messager=swaymsg

if [ $MAX_OPEN -gt 1 ]; then
    for i in {1..10}; do
        echo $messager "focus parent"
        $messager "focus parent"
    done
    $messager "split h"
fi

for url in $(python "$SCRIPT_PY"); do
    if "$(echo $CURRENT_CHROMIUM)" | grep "$url"; then
        continue
    fi

    chromium --new-window --app="https://www.twitch.tv/$url" &

    opened=$((opened+1))

    if [ "$opened" -ge "$MAX_OPEN" ]; then
        if [ "$MAX_OPEN" -gt "1" ]; then
            $messager "resize set width 14ppt"
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
