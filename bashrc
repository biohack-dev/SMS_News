clear

~/biohack.sh

# Adicione isso no final do seu ~/.bashrc
# Adicione isso no final do seu ~/.bashrc
if ! pgrep -x "sshd" > /dev/null; then
    nohup sshd > /dev/null 2>&1 &
fi

if ! pgrep -x "crond" > /dev/null; then
    nohup crond > /dev/null 2>&1 &
fi

~/sms.sh Servidor iniciado com sucesso! $(date '+%Y-%m-%d %H:%M:%S')

echo " "
