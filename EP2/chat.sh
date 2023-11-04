#!/bin/bash

# pipe=/tmp/testpipe
read -p "Digite o nome do canal: " pipe

trap "rm -f $pipe" EXIT

if [[ ! -p $pipe ]]; then
    mkfifo $pipe
fi

while true; do
    if read line <$pipe; then
        if [[ "$line" == 'sair' ]]; then
            break
        fi
        echo $line
    fi
done

echo "Reader exiting"
exit 0