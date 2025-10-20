#!/bin/bash

# For�ar encoding UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8	

# Número fixo
NUMERO_FIXO="+5519999999999,+551999999999"

# Mensagem do argumento
MENSAGEM="$*"

# Envia SMS
termux-sms-send -n "$NUMERO_FIXO" "$MENSAGEM"
