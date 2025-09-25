#!/usr/bin/sh

mode="$1"

# se nenhum argumento, usa default
# if [ -z "$mode" ]; then
#     mode="default"
# fi

# verifica se o modeo existe
if [ ! -f ~/.config/sway/modes/$mode ]; then
  echo "Contexto '$mode' não existe!"
  exit 1
fi

rm ~/.config/sway/mode

# atualiza o symlink
ln -sf ~/.config/sway/modes/$mode ~/.config/sway/mode

# recarrega o Sway
swaymsg reload
