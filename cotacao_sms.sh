#!/bin/bash

# Forçar encoding UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Executa a cotação
./cotacao.sh

# Lê os dados do JSON
gasolina=$(jq -r '.gasolina' cotacao.json)
dolar=$(jq -r '.dolar' cotacao.json)
bitcoin=$(jq -r '.bitcoin' cotacao.json)
petroleo_brent=$(jq -r '.petroleo_brent' cotacao.json)
data=$(jq -r '.data' cotacao.json)

# Monta a mensagem SMS SEM ACENTOS
MENSAGEM="COTACOES ATUALIZADAS
Gasolina: R$ $gasolina
Dolar: R$ $dolar
Bitcoin: $ $bitcoin
Petroleo Brent: $ $petroleo_brent
Data: $data"

# Envia via SMS
./sms.sh "$MENSAGEM"