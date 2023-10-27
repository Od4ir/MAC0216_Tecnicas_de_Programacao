#!/bin/bash
# AUTOR:
# Seu nome, NUSP e endereço de e-mail

# DESCRIÇÃO:
# Explique o que os programas fazem (Não diga apenas que ele é o EP2 da
# disciplina tal, explique o que de fato os programas fazem)

# COMO EXECUTAR:
# Informe como executar o cliente e o servidor e quais os parâmetros
# de linha de comando necessários

# TESTES:
# Forneça explicações sobre o testa.c

# DEPENDÊNCIAS:
# Informe o que é necessário para rodar o programa. Informações como o
# SO onde você executou e sabe que ele funciona são importantes de serem
# colocadas aqui.

# FUNÇÃO DE LOGOUT:
function logout {
    echo "Logout feito"
}

function create {
    echo "USUÁRIO: " $1 " criadx!"
    echo "SENHA: " $2 " definida"
}

# FUNÇÃO PARA ENCERRAR TUDO:
function quit {
    if [ $1 = "cliente" ]; then
        logout
    fi
    exit 0
}

# INICIO DO PROGRAMA:
if [ $1 = "servidor" ]; then
    echo " >>> MODO SERVIDOR LIGADO <<< "
    # Execução principal do modo servidor:
    while [ 1 ]; do
        # Leitura do comando escolhido pelo usuário:
        echo -n "servidor> " 
        read op
        echo ${op}

        # Execução do comando escolhido pelo usuário:
        if [ ${op} = "sair" ]; then
            echo "Saindo"
            quit $1
        fi
    done

elif [ $1 = "cliente" ]; then
    echo " >>> SEJA BEM VINDX <<< "
     # Execução principal do modo cliente:
    while [ 1 ]; do
        # Leitura do comando escolhido pelo usuário:
        echo -n "cliente> " 
        read op
        echo ${op}

        # Execução do comando escolhido pelo usuário:
        if [ ${op} = "sair" ]; then
            echo "Saindo"
            quit $1
        elif [ ${op} = "create" ]; then
            create $2 $3
        else 
            echo "Não há essa opção."
        fi
    done

else 
    echo "Nenhum modo identificado, programa encerrado"
    exit 0
fi

CONTADOR=0


while [ 1 ]; do
    # A cada 1 minuto, a mensagem abaixo será enviada ao Telegram;
    sleep 1 
    echo "Digite um nome: "
    read nome

    # A mensagem enviada pelo bot:
    curl -s https://api.telegram.org/bot6599211463:AAGKSxJsGbU6kuqAvzJgxcKbDOrB6G2Uxag/sendMessage -d chat_id=1360171414 -d text="Olá, ${nome}, tudo bem? (Mensagem: ${CONTADOR}) " 1>/dev/null
    let CONTADOR=CONTADOR+1

done

exit 0