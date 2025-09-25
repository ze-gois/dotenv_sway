#!/usr/bin/sh

# Função DRY para formatar tokens
format_token() {
    key="$1"
    value="$2"

    case "$key" in
        W)  # Wi-Fi
            quality=$(echo "$value" | grep -o '[0-9]\+%' | tr -d '%')
            if [ "$quality" -ge 70 ]; then color="#00FF00";       # verde
            elif [ "$quality" -ge 40 ]; then color="#FFFF00";    # amarelo
            else color="#FF0000"; fi                              # vermelho
            echo "<span foreground='$color'>📶 $value</span>"
            ;;
        E)  # Ethernet
            echo "<span foreground='#00FF00'>🌐 $value</span>"
            ;;
        VPN|DHCP)
            if [ "$value" = "no" ] || [ "$value" = "down" ]; then
                color="#FF0000"; val="off"
            else
                color="#00FF00"; val="on"
            fi
            echo "<span foreground='$color'>🔒 $key $val</span>"
            ;;
        BAT|CHR|FULL|IDLE)
            perc=$(echo "$value" | grep -o '[0-9]\+%' | tr -d '%')
            if [ "$perc" -le 10 ]; then color="#FF0000"
            elif [ "$perc" -le 30 ]; then color="#FFFF00"
            else color="#00FF00"; fi
            echo "<span foreground='$color'>🔋 $value</span>"
            ;;
        MEM*|MEMORY*)
            perc=$(echo "$value" | grep -o '[0-9]\+%' | tr -d '%')
            if [ "$perc" -ge 90 ]; then color="#FF0000"
            else color="#FFFFFF"; fi
            echo "<span foreground='$color'>💾 $value</span>"
            ;;
        T:*) echo "<span foreground='#FFAA00'>🌡 $value</span>" ;;
        */*) echo "<span foreground='#FFFFFF'>💽 $value</span>" ;;  # disco
        [0-9]*:[0-9]*:* ) echo "<span foreground='#AAAAFF'>⏰ $value</span>" ;; # tztime
        *) echo "<span foreground='#FFFFFF'>$value</span>" ;;
    esac
}

while true; do
    # pega o modo atual
    mode_name=$(basename "$(readlink ~/.config/sway/mode)")
    mode_span="<span foreground='#00FF00'>⚡ Mode: $mode_name</span>"

    # pega i3status, limpa códigos dzen2
    i3status_output=$(i3status -c /backup/dotenv/sway/i3status.conf --run-once 2>/dev/null | \
        sed 's/\^fg([^)]*)//g; s/\^p([^)]*)//g; s/\^ro([^)]*)//g')

    # split por campos (| ou espaços), mas mantendo os valores completos
    tokens=$(echo "$i3status_output" | tr '|' '\n')

    # formata cada token DRY
    formatted_tokens=""
    for tok in $tokens; do
        # tenta separar chave/valor
        key=$(echo "$tok" | awk '{print $1}' | tr -d ':')
        value=$(echo "$tok" | cut -d' ' -f2-)
        formatted_tokens="$formatted_tokens<span foreground='#AAAAAA'> | </span>$(format_token "$key" "$value")"
    done

    # imprime linha final
    echo "$mode_span$formatted_tokens"

    sleep 5
done
