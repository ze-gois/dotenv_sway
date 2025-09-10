#!/usr/bin/sh

while true; do
    echo -n "1"
    # i3status output
    i3status_output=$(i3status --run-once 2>/dev/null)

    # modeo ativo
    mode_name=$(basename "$(readlink ~/.config/sway/mode)")

    # imprime na mesma linha ou formato desejado
    echo "Mode: $mode_name | $i3status_output"

    sleep 5  # atualiza a cada segundo
done
