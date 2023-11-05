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

# Variáveis gerais:
CONTADOR=0
MSG_TELEGRAM=""
USER=""

# Arquivos importantes:
LOGADOS="/tmp/logados.txt"
USERS="/tmp/usuarios_info.txt"
USERS_INFO="/tmp/usuarios.txt"

touch "${LOGADOS}"
touch "${USERS}"
touch "${USERS_INFO}"

tempo_inicial=$(date +%s)

# Recebe uma mensagem e envia para o Telegram;
function envia_msg_telegram {
    curl -s https://api.telegram.org/bot6599211463:AAGKSxJsGbU6kuqAvzJgxcKbDOrB6G2Uxag/sendMessage -d chat_id=1360171414 -d text="$1" 1>/dev/null
}

# Exibe o tempo em que o servidor está ligado;
function mostrar_tempo {
    tempo_atual=$(date +%s)
    tempo_passado=$((tempo_atual - tempo_inicial))
    echo "${tempo_passado} segundos."
}

# Lista os usuários do arquivo 'logados.txt'
function lista_usuarios_logados {
    cat ${LOGADOS}
}

# Apaga os arquivos de informações do servidor;
function reset_servidor {
    rm -f ${LOGADOS} 
    rm -f ${USERS}
    rm -f ${USERS_INFO}
    touch "${LOGADOS}"
    touch "${USERS}"
    touch "${USERS_INFO}"
}

# Registra um usuário no arquivo usuarios.txt e usuarios_info.txt
function cria_usuario {
    if grep -q "$1;" ${USERS_INFO}; then
        echo "Username indisponível" 
    else
        echo "$1;$2" >> ${USERS_INFO}
        # Isso é feito para permitir que se crie um usuário
        # que seja igual a senha de outro usuário;
    fi
}

function muda_senha_usuario {
    info=$(grep "$1;" "${USERS_INFO}")
    if [ -n "${info}" ]; then
        senha=$(echo "${info}" | sed "s/$1;//g")
        if [ "${senha}" == "$2" ]; then
            sed -i "s/$1;$2/$1;$3/" ${USERS_INFO}
        else 
            echo "Senha incorreta"
            echo "ERRO!"
        fi
    else 
        echo "Usuário não encontrado"
        echo "ERRO!"
    fi
}

function login_usuario {
    info=$(grep "$1;" "${USERS_INFO}")
    if [ -n "${info}" ]; then        
        result=$(echo "${info}" | sed "s/$1;//g")
        if [ "${result}" == $2 ]; then
            echo "$1" >> ${LOGADOS}

            USER="/tmp/$1"
            echo ${USER}
            if [[ ! -p ${USER} ]]; then
                mkfifo ${USER}
            fi
            trap "rm -f ${USER}" EXIT

        else 
            echo "Senha incorreta"
            MSG="Usuárix $1 errou a senha"
            envia_msg_telegram ${MSG[*]}
        fi
    else 
        echo "Usuário não encontrado"
    fi
    # CONTADOR=0
    # while [ ${CONTADOR} -lt ${#USUARIOS[@]} ]; do
    #     if [ ${USUARIOS[${CONTADOR}]} == $1 ]; then
    #         if [ ${SENHAS[${CONTADOR}]} == $2 ]; then
    #             if [ ${LOGADOS[$CONTADOR]} -eq 0 ]; then

    #                 LOGADOS[${CONTADOR}]=1

    #                 AUX=${USUARIOS[${CONTADOR}]}
    #                 MSG_TELEGRAM="Usuárix ${AUX} fez login"
    #                 envia_msg_telegram "${MSG_TELEGRAM}"
    #                 echo ${AUX} >> "${LOGADOS}"

    #                 USER="/tmp/${AUX}"
    #                 if [[ ! -p ${USER} ]]; then
    #                     mkfifo ${USER}
    #                 fi
    #                 trap "rm -f ${USER}" EXIT
    #             else
    #                 echo "Usuário já logado"
    #             fi
    #         else
    #             echo "Senha incorreta"
    #         fi
    #     fi
    #     let CONTADOR=CONTADOR+1
    # done
}

function logout_usuario {
    MSG_TELEGRAM=()
    MSG_TELEGRAM="<LOGOUT REALIZADO> Usuário $1 fez logout"
    envia_msg_telegram ${MSG_TELEGRAM[*]}
    sed -i "/$1/d" "${LOGADOS}"
    rm -f ${USER}
    USER=""
    # Faz logout do usuário do pipe atual;
}

function mensagem_usuario {
    # Pega o usuário do pipe atual; ??
    # Pega o destinatário; $1
    # Pega a mensagem; $2
    # Envia a mensagem para o usuário destinatário;
    aux=$1
    user=$2
    shift 2
    mensagem="$@"
    result=$(echo "${mensagem}" | sed "s/${aux} ${user}//g")
    echo ${result}
    dest="/tmp/${user}"
    echo ${dest}
    echo "${result[*]}" >${dest}
}

function apagar_arquivos {
    rm -f ${LOGADOS} 
    rm -f ${USERS}
    rm -f ${USERS_INFO}
}

while [ 1 ]; do
    if [ -s "${LOGADOS}" ]; then
        conteudo=$(cat "${LOGADOS}")
        envia_msg_telegram ${conteudo}
    fi
    sleep 16s
done &

PRIMEIROPLANO=$!

while [ 1 ]; do
     if [ "${USER}" != "" ]; then
        conteudo=$(cat <${USER})
        echo ${CONTADOR} ${conteudo}
        let CONTADOR=CONTADOR+1
     fi
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
            kill -15 ${PRIMEIROPLANO}
            kill -15 ${SEGUNDOPLANO}
            exit 0

        else
            echo "Opção inválida, digite novamente: "
        fi
    done

elif [ $1 = "cliente" ]; then
    echo -e " >>> SEJA BEM VINDX <<< \n"
     # Execução principal do modo cliente:
    echo " Lista de opções disponíveis: "
    echo -e "\n [ Login NÃO necessário: ]"
    echo "  >>> create usuario senha.........[ Criação de usuário ]"
    echo "  >>> passwd usuario antiga nova...[ Mudança de senha ]"
    echo "  >>> login usuario senha..........[ Login ]"
    echo -e "  >>> quit.........................[ Sair do chat ]\n"

    echo " [ Login necessário: ] "
    echo "  >>> list.........................[ Lista usuários logados ]"
    echo "  >>> logout.......................[ Faz logout do sistema ]"
    echo -e "  >>> msg usuario mensagem.........[ Envia mensagem para outro usuário ]\n"
    while [ 1 ]; do
        # Leitura do comando escolhido pelo usuário:
        echo -n "cliente> " 
        read -a op

        # Execução do comando escolhido pelo usuário:
        if [ ${op[0]} = "quit" ]; then
            echo "Saindo"
            kill -15 ${PRIMEIROPLANO}
            kill -15 ${SEGUNDOPLANO}
            apagar_arquivos
            exit 0

        elif [ ${op[0]} = "create" ]; then
            cria_usuario ${op[1]} ${op[2]}

        elif [ ${op} = "list" ]; then
            echo "Listando usuários"
            lista_usuarios_logados

        elif [ ${op} = "time" ]; then
            mostrar_tempo

        elif [ ${op} = "magic" ]; then
            cat ${ARQ}

        elif [ ${op} = "login" ]; then
            if [ "${USER}" == "" ]; then
                login_usuario  ${op[1]} ${op[2]}
            else 
                echo "Você já está logado!"
            fi

        elif [ ${op} = "passwd" ]; then
            muda_senha_usuario ${op[1]} ${op[2]} ${op[3]}

        elif [ ${op} = "logout" ]; then
            logout_usuario ${op[1]}

        elif [ ${op} = "msg" ]; then
            mensagem_usuario ${op[0]} ${op[1]} ${op[@]}

        elif [ ${op} = "panda" ]; then
            cat ${USERS_INFO}

        else 
            echo "Não há essa opção."
        fi
    done
else
    echo "Opção não encontrada."
fi

kill -15 ${PRIMEIROPLANO} 
kill -15 ${SEGUNDOPLANO}
exit 0


# Garantir que o modo cliente não seja ativado sem o servidor;
# Apagar os usuários quando fizerem logout;
# Corrigir o time para os clientes;
# O reset tem que zerar o tempo também?

