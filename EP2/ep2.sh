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

CONTADOR=0
LOGADOS="/tmp/logados.txt"
USERS_INFO="/tmp/usuarios.txt"

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
    echo ${LOGADOS}
    cat ${LOGADOS}
}

# Apaga os arquivos de informações do servidor;
function reset_servidor {
    rm -f ${LOGADOS} 
    rm -f ${USERS_INFO}
    touch "${LOGADOS}"
    touch "${USERS_INFO}"
}

# Registra um usuário no arquivo usuarios.txt e usuarios_info.txt
function cria_usuario {
    if grep -q "$1;" ${USERS_INFO}; then
        echo "Username indisponível" 
    else
        echo "$1;$2" >> ${USERS_INFO}
        # O formato desse arquivo fica como uma lista de "username;senha"
    fi
}

# Altera a senha do usuário no arquivo usuarios_info.txt
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

# Tenta fazer o login do usuário;
function login_usuario {
    # Procura o usuário na lista de informações do usuário:
    info=$(grep "$1;" "${USERS_INFO}")
    if [ -n "${info}" ]; then    
        # Se achar, verifica se o usuário está na lista de logados;
        aux=$(grep "$1" "${LOGADOS}") 
        if [ -n "${aux}" ]; then
            echo "Usuárix já logado!"   
        else
            # Se o usuário não estiver logado, verifica se a senha está correta;
            result=$(echo "${info}" | sed "s/$1;//g")
            if [ "${result}" == $2 ]; then
                # Marca que o usuário está logado;
                echo "$1" >> ${LOGADOS}

                # Salva em ${USER} o caminho para o pipe do usuário logado;
                echo "/tmp/$1" > ${USER}
                AUX=$(cat ${USER})

                # Cria o pipe do usuário para ele receber as mensagens:
                if [[ ! -p ${AUX} ]]; then
                    mkfifo ${AUX}
                fi

                # Apaga o arquivo quando o programa se encerrar:
                trap "rm -f ${AUX}" EXIT

                # Envia a mensagem para o telegram sobre o login do usuário:
                DATA=$(date)
                MSG_TELEGRAM="Usuárix $1 fez login"
                envia_msg_telegram "[ ${DATA} ] ${MSG_TELEGRAM}"

            else 
                echo "Senha incorreta"
                DATA=$(date)
                MSG_TELEGRAM="Usuárix $1 errou a senha"
                envia_msg_telegram "[ ${DATA} ] ${MSG_TELEGRAM}"
            fi
        fi
    else 
        echo "Usuário não encontrado"
    fi
}

function logout_usuario {
    # Verifica se o usuário que está tentando fazer logout é o 
    # user logado atualmente;
    USER_ATUAL=$(cat "${USER}" | sed "s/\/tmp\///g")

    if [ "${USER_ATUAL}" != "$1" ]; then
        echo "Você não é esse usuário, não pode fazer o logout"
    else 
        MSG_TELEGRAM=()
        MSG_TELEGRAM="<LOGOUT REALIZADO> Usuário $1 fez logout"
        DATA=$(date)
        envia_msg_telegram "[ ${DATA} ] ${MSG_TELEGRAM}"
        sed -i "/$1/d" "${LOGADOS}"
        rm -f "/tmp/${USER_ATUAL}"
    fi
    # Faz logout do usuário do pipe atual;
}

function mensagem_usuario {
    info=$(grep "$2" "${LOGADOS}")
    if [ -n "${info}" ]; then
        aux=$1
        user=$2
        sender=$3
        shift 3
        mensagem="$@"
        result=$(echo "${mensagem}" | sed "s/${aux} ${user}//g")
        dest="/tmp/${user}"
        msg="[Mensagem do ${sender}]: ${result}"
        # printf "%s\n" "${msg}" > "${dest}"
        echo "${msg}" >${dest}
        echo "cliente> " >${dest}
    else 
        echo "Usuárix não encontrado"
    fi  
    # printf "cliente> " > "${dest}"
}

function limpa_arquivos {
    rm -f ${LOGADOS}
    rm -f ${USERS_INFO}
}

if [ $1 = "servidor" ]; then
    tempo_inicial=$(date +%s)

    touch "${LOGADOS}"
    touch "${USERS_INFO}"

    echo " >>> MODO SERVIDOR LIGADO <<< "
    # Execução principal do modo servidor:

    while [ 1 ]; do
        if [ -s "${LOGADOS}" ]; then
            let CONTADOR=CONTADOR+1
            conteudo=$(cat ${LOGADOS})
            envia_msg_telegram "${CONTADOR}: ${conteudo}"
        fi
        sleep 16s
    done &

    LOOP_MSG_TELEGRAM=$!

    while [ 1 ]; do
        # Leitura do comando escolhido pelo usuário:
        echo -n "servidor> " 
        read op

        # Execução do comando escolhido pelo usuário:
        if [ ${op} = "list" ]; then
            lista_usuarios_logados

        elif [ ${op} = "time" ]; then
            tempo_atual=$(date +%s)
            tempo_passado=$((tempo_atual - tempo_inicial))
            echo "${tempo_passado} segundos."

        elif [ ${op} = "reset" ]; then
            reset_servidor
            
        elif [ ${op} = "quit" ]; then
            echo "Saindo"
            kill -15 ${LOOP_MSG_TELEGRAM}
            limpa_arquivos
            exit 0

        else
            echo "Opção inválida, digite novamente: "
        fi
    done

elif [ $1 = "cliente" ]; then

    if [ ! -e "/tmp/usuarios.txt" ]; then
        echo "Servidor não iniciado!"
        exit 0
    fi

    # Esse arquivo guarda as informações do pipe do usuário atual;
    USER=$(mktemp)
    trap "rm -f ${USER}" EXIT

    echo -e " >>> SEJA BEM VINDX <<< \n"
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
        if [ -s "${USER}" ]; then
            # echo "Entrou"
            AUX=$(cat ${USER})
            if [ -s "${AUX}" ]; then
                conteudo=$(cat <${AUX})
                echo -n "${conteudo}"
                > "${AUX}"
            fi
        fi
    done &

    LOOP_RECEBE_MSG=$!

    while [ 1 ]; do
        # Leitura do comando escolhido pelo usuário:
        echo -n "cliente> " 
        read -a op

        # Execução do comando escolhido pelo usuário:
        if [ ${op[0]} = "quit" ]; then
            echo "Saindo"
            kill -15 ${LOOP_RECEBE_MSG}
            rm -f ${USER}
            exit 0

        elif [ ${op[0]} = "create" ]; then
            cria_usuario ${op[1]} ${op[2]}

        elif [ ${op} = "list" ]; then
            lista_usuarios_logados

        elif [ ${op} = "magic" ]; then
            cat ${ARQ}

        elif [ ${op} = "login" ]; then
            if [ ! -s "${USER}" ]; then
                login_usuario  ${op[1]} ${op[2]}
            else 
                echo "Você já está logado!"
            fi

        elif [ ${op} = "passwd" ]; then
            muda_senha_usuario ${op[1]} ${op[2]} ${op[3]}

        elif [ ${op} = "logout" ]; then
            logout_usuario ${op[1]}
            > "${USER}"

        elif [ ${op} = "msg" ]; then
            remetente=$(cat "${USER}" | sed "s/\/tmp\///g")
            mensagem_usuario ${op[0]} ${op[1]} ${remetente} ${op[@]}

        elif [ ${op} = "panda" ]; then
            cat ${USER}

        else 
            echo "Não há essa opção."
        fi
    done
else
    echo "Opção não encontrada."
fi



# Garantir que o modo cliente não seja ativado sem o servidor;
# O reset tem que zerar o tempo também?
# Verificar se o usuário está logado antes de enviar a mensagem

