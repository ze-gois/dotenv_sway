#!/usr/bin/zsh

swaymsg -t get_tree | jq -r '
  recurse(.nodes[], .floating_nodes[])
  | select(.app_id != null and (.app_id | startswith("chrome-")))
  | .app_id
  | sub("^chrome-"; "")        # remove o prefixo "chrome-"
  | sub("-Default$"; "")       # remove o sufixo do perfil
  | gsub("__"; "/")            # alguns app_id usam "__" para separar
'
