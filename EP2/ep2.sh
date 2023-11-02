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

CONTADOR=0
USUARIOS=()
LOGADOS=()
SENHAS=()
MSG_TELEGRAM=()

arq_temp=$(mktemp)
tempo_inicial=$(date +%s)

function envia_msg_telegram {
    curl -s https://api.telegram.org/bot6599211463:AAGKSxJsGbU6kuqAvzJgxcKbDOrB6G2Uxag/sendMessage -d chat_id=1360171414 -d text="$1" 1>/dev/null
}

function mostrar_tempo {
    tempo_atual=$(date +%s)
    tempo_passado=$((tempo_atual - tempo_inicial))
    echo "${tempo_passado} segundos."
}

function lista_usuarios_logados {
    echo "Usuários Logados: "
    CONTADOR=0
    while [ ${CONTADOR} -lt ${#USUARIOS[*]} ]; do
        if [ ${LOGADOS[${CONTADOR}]} -eq 1 ]; then
            echo ${USUARIOS[${CONTADOR}]}
        fi
        let CONTADOR=CONTADOR+1
    done
}

function reset_servidor {
    USUARIOS=()
    SENHAS=()
    LOGADOS=()
}

function cria_usuario {
    for nome_usuario in ${USUARIOS[*]}; do
        if [ ${nome_usuario} == $1 ]; then
            echo "ERRO!"
            return 1
        fi
    done
    USUARIOS+=($1)
    SENHAS+=($2)
    LOGADOS+=(0)
}

function muda_senha_usuario {
    CONTADOR=0
    while [ ${CONTADOR} -lt ${#USUARIOS[*]} ]; do
        if [ ${USUARIOS[${CONTADOR}]} -eq $1 ] && [ ${SENHAS[$CONTADOR]} -eq $2]; then
            SENHAS[${CONTADOR}]=$3
            return 0
        fi
        let CONTADOR=CONTADOR+1
    done
    echo "ERRO!"
}

function login_usuario {
    CONTADOR=0
    while [ ${CONTADOR} -lt ${#USUARIOS[@]} ]; do
        let CONTADOR=CONTADOR+1
        if [ ${USUARIOS[${CONTADOR}]} == $1 ]; then
            if [ ${SENHAS[${CONTADOR}]} == $2 ]; then
                if [ ${LOGADOS[$CONTADOR]} -eq 0 ]; then
                    LOGADOS[${CONTADOR}]=1
                    AUX=${USUARIOS[${CONTADOR}]}
                    MSG_TELEGRAM=()
                    MSG_TELEGRAM="Usuárix " ${AUX} "fez login"
                    echo ${MSG_TELEGRAM}
                else
                    echo "Usuário já logado"
                fi
            else
                echo "Senha incorreta"
            fi
        fi
        let CONTADOR=CONTADOR+1
    done
    echo "ERRO!"
}

function logout_usuario {
    MSG_TELEGRAM=()
    MSG_TELEGRAM="<LOGOUT REALIZADO> Usuário $1 fez logout"
    envia_msg_telegram ${MSG_TELEGRAM}
    sed -i "/$1/d" "${arq_tempo}"
    # Faz logout do usuário do pipe atual;
}

function mensagem_usuario {
    # Pega o usuário do pipe atual; ??
    # Pega o destinatário; $1
    # Pega a mensagem; $2
    # Envia a mensagem para o usuário destinatário;
    echo "mensagem"
}

while [ 1 ]; do
    while [ ${CONTADOR} -lt ${#USUARIOS[*]} ]; do
        if [ ${LOGADOS[${CONTADOR}]} -eq 1 ]; then
            echo "oii"
        else 
            curl -s https://api.telegram.org/bot6599211463:AAGKSxJsGbU6kuqAvzJgxcKbDOrB6G2Uxag/sendMessage -d chat_id=1360171414 -d text=" Não temos usuários!(Mensagem: ${CONTADOR}) " 1>/dev/null
        fi
        let CONTADOR=CONTADOR+1
        sleep 5
    done
done &

SEGUNDOPLANO=$!

if [ $1 = "servidor" ]; then
    echo " >>> MODO SERVIDOR LIGADO <<< "
    # Execução principal do modo servidor:

    while [ 1 ]; do
        # Leitura do comando escolhido pelo usuário:
        echo -n "servidor> " 
        read op

        # Execução do comando escolhido pelo usuário:
        if [ ${op} = "list" ]; then
            lista_usuarios_logados

        elif [ ${op} = "time" ]; then
            mostrar_tempo

        elif [ ${op} = "reset" ]; then
            reset_servidor
            
        elif [ ${op} = "quit" ]; then
            echo "Saindo"
            kill -15 ${SEGUNDOPLANO}
            exit 0

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
            cria_usuario ${op[1]} ${op[2]}

        elif [ ${op} = "list" ]; then
            echo "Listando usuários"
            lista_usuarios_logados

        elif [ ${op} = "time" ]; then
            mostrar_tempo

        elif [ ${op} = "magic" ]; then
            cat ${arq_temp}

        else 
            echo "Não há essa opção."
        fi
    done
else
    echo "Opção não encontrada."
fi

kill -15 ${SEGUNDOPLANO}
exit 0
