#!/bin/bash
# AUTOR:
# # NOME:   Odair Gonçalves de Oliveira
# # Nº USP: 13671581
# # E-MAIL: od4ir@usp.br

# DESCRIÇÃO:
# O programa a seguir, escrito em bash script, simula um sistema de chat
# com modos de servidor e cliente que permite a comunicação entre termi-
# nais do seu computador. Cada modo conta com diferentes opções, sendo o
# o modo servidor o principal para controle do sistema e o modo cliente
# o modo responsável por permitir simular o uso de um usuário. 

# COMO EXECUTAR:
# Para executar o modo servidor:
# 1) Abra um terminal e na pasta com esse script digite:
#    bash ep2.sh servidor
# Esse comando irá executar o modo servidor do sistema de chat.

# Para executar o modo cliente:
# 1) Primeiro execute o servidor em algum terminal como foi descrito
# anteriormente;
# 2) Abra um novo terminal e na pasta com esse arquivo digite:
#    bash ep2.sh cliente
# Esse comando irá executar o modo cliente e permitir que outras opções
# e comandos sejam realizados para esse tipo de modo.

# TESTES:
# Para testar a comunicação entre terminais diferentes faça:
# 1) Execute o modo servidor em um terminal;
# 2) Execute o modo cliente em dois terminais diferentes;
# 3) Crie ao menos 2 usuários com os comandos para isso;
# 4) Faça login com cada um deles nos dois terminais no modo cliente;
# 5) Manda mensagens usando o nome dos usuários entre os terminais e se 
# divirta!

# DEPENDÊNCIAS:
# O testes desse script foram feitos em um SO: Ubuntu 22.04.3 LTS
# Também foi utilizado o curl curl 7.81.0


LOGADOS="/tmp/logados.txt"
USERS_INFO="/tmp/usuarios.txt"
TOKEN= # INSIRA O TOKEN DO SEU BOT AQUI!
CHATID= # INSIRA O ID DO SEU CHAT AQUI;

# Recebe uma mensagem e envia para o Telegram;
function envia_msg_telegram {
    curl -s https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHATID} -d text="$1" 1>/dev/null
}

# Exibe o tempo em que o servidor está ligado;
function mostrar_tempo {
    tempo_atual=$(date +%s)
    tempo_passado=$((tempo_atual - tempo_inicial))
    echo "${tempo_passado} segundos."
}

# Lista os usuários do arquivo 'logados.txt'
function lista_usuarios_logados {
    if [ -s "${LOGADOS}" ]; then
        echo "Usuárixs logadxs: "
        cat ${LOGADOS}
    else
        echo "Não há usuárixs logadxs!"
    fi
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
        echo "Usuárix não encontradx"
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
            echo "Usuárix já logadx!"   
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
        echo "Usuárix não encontradx"
    fi
}

function logout_usuario {
    AUX=$(cat ${USER})
    if [ -e "${AUX}" ]; then
        USER_ATUAL=$(echo "${AUX}" | sed "s|/tmp/||")
        echo "Logout de ${USER_ATUAL} feito!"

        MSG_TELEGRAM=()
        MSG_TELEGRAM="<LOGOUT REALIZADO> Usuárix fez logout"
        DATA=$(date)
        envia_msg_telegram "[ ${DATA} ] ${MSG_TELEGRAM}"
        sed -i "/${USER_ATUAL}/d" "${LOGADOS}"
        > ${USER}
        echo "" >"/tmp/${USER_ATUAL}"
        rm -f ${AUX}
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
        msg="[Mensagem de ${sender}]: ${result}"
        # printf "%s\n" "${msg}" > "${dest}"
        echo "${msg}" >${dest}
        # echo "cliente> " >${dest}
    else 
        echo "Usuárix não encontradx"
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
            envia_msg_telegram "${conteudo}"
        fi
        sleep 1m
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
            echo "Encerrando servidor..."
            kill -15 ${LOOP_MSG_TELEGRAM}
            limpa_arquivos
            exit 0

        else
            echo "Opção inválida, digite novamente: "
        fi
    done

elif [ $1 = "cliente" ]; then

    if [ ! -e "/tmp/usuarios.txt" ] && [ ! -e "/tmp/logados.txt" ]; then
        echo "Servidor não iniciado!"
        exit 0
    fi

    # Esse arquivo guarda as informações do pipe do usuário atual;
    USER=$(mktemp)
    trap "rm -f ${USER}" EXIT
    trap "kill -15 ${LOOP_RECEBE_MSG}" EXIT

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

    while true; do
        if [ -s "${USER}" ]; then
            AUX=$(cat ${USER})
            if [ -e "${AUX}" ]; then
                conteudo=$(cat <${AUX})
                if [ "${conteudo}" != "" ]; then
                    echo "${conteudo}"
                    echo -n "cliente> " 
                fi
            fi
        fi
        sleep 1
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
            logout_usuario
            rm -f ${USER}
            exit 0

        elif [ ${op[0]} = "create" ]; then
            cria_usuario ${op[1]} ${op[2]}

        elif [ ${op} = "login" ]; then
            if [ ! -s "${USER}" ]; then
                login_usuario  ${op[1]} ${op[2]}
            else 
                echo "Você já está logadx!"
            fi

        elif [ ${op} = "passwd" ]; then
            muda_senha_usuario ${op[1]} ${op[2]} ${op[3]}

        elif [ -s "${USER}" ]; then
            if [ ${op} = "list" ]; then
                lista_usuarios_logados

            elif [ ${op} = "logout" ]; then
                logout_usuario 

            elif [ ${op} = "msg" ]; then
                remetente=$(cat "${USER}" | sed "s/\/tmp\///g")
                mensagem_usuario ${op[0]} ${op[1]} ${remetente} ${op[@]}
            else 
                echo "Não há essa opção. Tente novamente!"
            fi
        
        else 
            echo "ERRO: Opção não disponível"
        fi
    done
else
    echo "Opção não encontrada."
fi



# Garantir que o modo cliente não seja ativado sem o servidor;
# O reset tem que zerar o tempo também?
# Verificar se o usuário está logado antes de enviar a mensagem

