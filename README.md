# SMS_News

SMS_News - Sistema de Sobrevivencialismo

Sistema automatizado de monitoramento e alertas via SMS desenvolvido para Termux, criado por biohack como ferramenta de apoio ao sobrevivencialismo urbano e rural.

🎯 Objetivo

Fornecer informações críticas em tempo real via SMS sobre:

· Cotações de moedas e commodities
· Condições climáticas locais
· Notícias mundiais importantes
· Status do sistema

📋 Scripts Incluídos

🚨 Core

· sms.sh - Envio básico de SMS para números pré-configurados
· relatorio.sh - Executa relatório completo (cotações + clima + notícias)

💰 Cotações Financeiras

· cotacao.sh - Coleta cotações de gasolina, dólar, bitcoin e petróleo Brent
· cotacao_sms.sh - Envia cotações via SMS

🌤️ Monitoramento Climático

· hora.sh - Coleta e envia dados climáticos locais via SMS

📰 Notícias

· news_sms.sh - Envia últimas 3 notícias mundiais via SMS

🎨 Utilitários

· biohack.sh - Banner estilizado do sistema

⚙️ Instalação e Dependências

```bash
# Atualizar pacotes
pkg update && pkg upgrade

# Instalar dependências básicas
pkg install curl jq bc

# Configurar permissões de SMS no Termux
termux-setup-storage

# Conceder permissões necessárias
termux-sms-list
termux-telephony-call
```

🔧 Configuração

1. Configurar números para SMS

Edite sms.sh e substitua os números no array NUMERO_FIXO:

```bash
NUMERO_FIXO="+5511999999999,+5511888888888"
```

2. Configurar Tasker

Abra o tasker > Criar > Evento > Intent Recebido

```
com.example.SEND_SMS
```
Nova Tarefa > Enviar SMS
```
Numero > %number
Mensagem > %message
```

3. Configurar API do Clima (Opcional)

Para o hora.sh funcionar completamente, registre-se em:

· Climatempo API
· Substitua o token no script

4. Tornar scripts executáveis

```bash
chmod +x *.sh
```

🚀 Uso

Relatório Completo

```bash
./relatorio.sh
```

Cotações Apenas

```bash
./cotacao_sms.sh
```

Clima Local

```bash
./hora.sh
```

Notícias

```bash
./news_sms.sh
```

SMS Personalizado

```bash
./sms.sh "Mensagem personalizada de alerta"
```

📊 Dados Monitorados

· 💰 Financeiro: Dólar, Bitcoin, Petróleo Brent, Gasolina
· 🌤️ Climático: Temperatura, Vento, Umidade, Pressão
· 📰 Informação: 3 principais notícias mundiais
· 🔋 Sistema: Status da bateria (integrado)

🛡️ Aplicações Sobrevivencialistas

· Preparação: Monitoramento de commodities essenciais
· Crise Econômica: Acompanhamento de moedas e inflação
· Desastres Naturais: Alertas climáticos em tempo real
· Colapso de Comunicação: Sistema offline-ready
· Mobilidade: Operação via smartphone sem internet

⚠️ Notas Importantes

· Desenvolvido para Termux Android
· Requer créditos SMS na operadora
· Funciona offline após primeira execução
· Otimizado para baixo consumo de bateria
· Sistema modular - use apenas os scripts necessários

🆘 Comandos de Emergência

```bash
# Relatório rápido (2 minutos)
./relatorio.sh

# Apenas alerta climático  
./hora.sh

# Status financeiro instantâneo
./cotacao_sms.sh
```

---

Desenvolvido por biohack para comunidade sobrevivencialista
Manter informação é manter viva a esperança
