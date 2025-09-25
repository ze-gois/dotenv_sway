#!/usr/bin/zsh

url=$($DOTENV_PATH/sway/scripts/twitch/chromium_history.py | shuf -n1)

if [ -z "$url" ]; then
    echo "No URL found"
    exit 1
fi

chromium --new-window --app="https://www.twitch.tv/$url"
