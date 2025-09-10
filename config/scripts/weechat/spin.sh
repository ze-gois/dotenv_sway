#!/usr/bin/zsh

tmux has-session -t weechat 2>/dev/null && tmux attach -t weechat && exit 0

tmux new-session -s weechat 'export WEECHAT_PASSPHRASE="$(pass show weechat/passphrase)" && weechat'
