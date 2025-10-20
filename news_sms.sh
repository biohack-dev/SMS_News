#!/bin/bash

# For�ar encoding UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# URL do RSS das not�cias mundiais
WORLD_NEWS_URL="https://news.google.com/rss/topics/CAAqKggKIiRDQkFTRlFvSUwyMHZNRGx1YlY4U0JYQjBMVUpTR2dKQ1VpZ0FQAQ?hl=pt-BR&gl=BR&ceid=BR%3Apt-419"

# Busca as �ltimas 3 not�cias (pula os dois primeiros t�tulos)
titulos=$(curl -s "$WORLD_NEWS_URL" | grep -oP '<title>\K[^<]+' | tail -n +3 | head -3)

# Envia cada t�tulo em um SMS separado (silenciosamente)
i=1
echo "$titulos" | while read -r titulo; do
    MENSAGEM="$i/3: $titulo"
    ./sms.sh "$MENSAGEM" > /dev/null 2>&1
    i=$((i + 1))
    sleep 2  # Aguarda 2 segundos entre os SMS
done