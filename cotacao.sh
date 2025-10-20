#!/bin/bash

# Gasolina
url_gasolina="https://precos.petrobras.com.br/w/gasolina/sp"
preco_gasolina=$(curl -s "$url_gasolina" | grep -oP '(?<=<p class="h4 real-value" data-lfr-editable-type="text" data-lfr-editable-id="telafinal-precofinal" id="telafinal-precofinal">)[^<]+' 2>/dev/null || echo "null")

# Dólar
url_dolar="https://economia.awesomeapi.com.br/json/last/USD-BRL"
dolar_data=$(curl -s "$url_dolar")
dolar=$(echo "$dolar_data" | jq -r '.USDBRL.ask // "null"' 2>/dev/null || echo "null")

if [ "$dolar" != "null" ] && [ -n "$dolar" ]; then
    dolar_formatado=$(printf "%.2f" "$dolar" 2>/dev/null | sed 's/\./,/' || echo "null")
else
    dolar_formatado="null"
fi

# Bitcoin em Dólar - Arredondar para inteiro (sem centavos)
url_bitcoin="https://economia.awesomeapi.com.br/json/last/BTC-USD"
bitcoin_data=$(curl -s "$url_bitcoin")
bitcoin=$(echo "$bitcoin_data" | jq -r '.BTCUSD.ask // "null"' 2>/dev/null || echo "null")

if [ "$bitcoin" != "null" ] && [ -n "$bitcoin" ]; then
    # Arredondar para inteiro (remover decimais)
    bitcoin_inteiro=$(echo "$bitcoin" | awk '{printf "%.0f", $1}')
    # Formatar com pontos para milhares
    bitcoin_formatado=$(echo "$bitcoin_inteiro" | awk '{len=length($0); for(i=len-2; i>1; i-=3) $0=substr($0,1,i-1) "." substr($0,i); print $0}')
else
    bitcoin_formatado="null"
fi

# Petróleo Brent do investing.com
url_petroleo="https://br.investing.com/commodities/brent-oil"
brent=$(curl -s -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" "$url_petroleo" | grep -oP '(?<=<div class="text-5xl/9 font-bold text-\[\#232526\] md:text-\[42px\] md:leading-\[60px\]" data-test="instrument-price-last">)[^<]+' | head -1)

if [ -z "$brent" ]; then
    # Tentativa alternativa com padrão diferente
    brent=$(curl -s -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" "$url_petroleo" | grep -oP 'data-test="instrument-price-last"[^>]*>[^<]*' | grep -oP '>[\d,\.]+' | head -1 | sed 's/>//')
fi

if [ -n "$brent" ]; then
    # Converter para formato numérico (trocar vírgula por ponto se necessário)
    brent=$(echo "$brent" | sed 's/\.//g' | sed 's/,/./')
    brent_formatado=$(printf "%.2f" "$brent" 2>/dev/null | sed 's/\./,/' || echo "null")
else
    brent_formatado="null"
fi

# Criar arquivo JSON
cat > cotacao.json << EOF
{
  "gasolina": "$preco_gasolina",
  "dolar": "$dolar_formatado",
  "bitcoin": "$bitcoin_formatado",
  "petroleo_brent": "$brent_formatado",
  "data": "$(date '+%Y-%m-%d %H:%M:%S')"
}
EOF