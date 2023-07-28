
section .text

ehprimo:
            MOV  byte[primo], 1          ; Varíavel primo, de comparação, recebe 1 (Verdadeiro);
            MOV  dword[div], 2           ; Varíavel div, para as divisões que irão checar se o número é primo, recebe 2;
            CMP  dword[numero], 1        ; Compara "entrada" com número 1;
            JNE  nao_um                  ; Se entrada não for 1, pula para linha nao_um;
            MOV  byte[primo], 0          ; Se entrada for 1, a varíavel primo de comparação recebe 0;
            RET                          ; Retorna para o start;
nao_um:     MOV  EAX, dword[div]         ; Se entrada != 1, move div para o EAX para fazer multiplicação;
            MUL  EAX                     ; Salva em EAX o valor de div*div;
            CMP  EAX, dword[numero]      ; Compara EAX (div*div) com a "entrada";
            JG   eh_primo                ; Se EAX > "entrada", encerra-se o loop e retornamos para o start;
            MOV  EAX, dword[numero]      ; Salva em EAX o valor de entrada;
            DIV  dword[div]              ; Divide o valor de entrada, salvo em EAX por div;
            INC  dword[div]              ; Adiciona 1 em div;
            CMP  EDX, 0                  ; Compara o resto da divisão feita na linha 15 com 0;
            JNE  nao_um                  ; Se a divisão não der 0, loop;
            MOV byte[primo], 0           ; Se a divisão der 0, primo recebe 0 e retornamos para o start;
eh_primo:   RET


global _start  ; tipo o main
_start: 

            ; Leitura da entrada:
            mov RDI, STDIN               ; primeiro parâmetro é o descritor de arquivo que será lido
            mov RSI, buffer              ; segundo parâmetro é o ponteiro para o buffer onde o conteúdo lido será armazenado
            mov RDX, 256                 ; terceiro argumento é a quantidade de bytes a serem lidos
            mov RAX, 0                   ; número da syscall read
            syscall

            ; /// MODO ESCOLHIDO /// ;
            MOV ECX, buffer              ; Move o endereço lido para ECX, que é um ponteiro apontando
                                         ; para a 1º posição do que foi lido. 
            MOV BL, byte[ECX]            ; Move o primeiro caractere lido, que indica o modo para BL;
            SUB BL, ASCII                ; Converte o caractere ainda em ASCII para inteiro.
            MOV [modo], BL               ; Salva em "modo" o modo escolhido;
            MOV [contador], EAX          ; Salva o número de caracteres lidos em [contador].
            MOV [tamanho], EAX
            MOV EDX, 10                  ; Salva 10 em EDX que irá funcionar para construir o número 
                                         ; dado na entrada.
            XOR EAX, EAX                 ; Zera EAX, onde ficara o número lido; 
            ADD ECX, 2                   ; Direciona o ponteiro ECX para o 1º dígito da string lida;
            SUB dword[contador], 3       ; Já lemos 2 casas, o modo e o espaço, e a última é um "pula
                                         ; linha", logo, temos -3 casas para ler.
            ; /// CONSTRUÇÃO DO NÚMERO /// ;
num_making: SUB dword[contador], 1       
            MOV BL, byte[ECX]            ; Move o (x + 2)º digito, ainda em código ASCII, para BL.
            SUB BL, ASCII                ; Converte o digito de ASCII para inteiro;
            ADD EAX, EBX                  ; Salva esse dígito em EAX;
                              
            CMP dword[contador], 0       ; Verifica se temos mais dígitos para salvar.
            JE num_pronto                ; Se não houver mais, já temos o número pronto.
            MUL EDX                      ; Se houver mais dígitos, multiplica o atual por 10.
            ADD ECX, 1                   ; Coloca o ponteiro apontando para o (x + 1)º digito do 
                                         ; número, com x começando em zero.               
            JMP num_making               ; Continua o loop de montar o número;
num_pronto: MOV [numero], EAX            ; Salva o número final na variável "numero". 


            CMP  byte[modo], 0
            JNE  modo_1
modo_0:     INC  dword[numero]
            MOV  EBX, dword[numero] 
            CMP  EBX, dword[MAX]
            JG   fim
            CMP  byte[primo], 0
            JNE  fim
            call ehprimo
            CMP  byte[primo], 0
            JE   modo_0
            MOV EBX, dword[numero]          ; Return ECX, pois ECX tem o número!
                         
modo_1: 



            MOV EBX, numero
            MOV EAX, [tamanho]
            SUB EAX, 2
            mov rdi, STDOUT         ; primeiro parâmetro é o descritor do arquivo que será escrito
            mov rsi, RBX           ; segundo parâmetro é o ponteiro para a mensagem que será escrita
            mov rdx, rax            ; terceiro parâmetro é o tamanho da mensagem (ainda está em eax)
            mov rax, 1              ; número da syscall write
            syscall
            JMP fim

fim:        ; sys_exit(return_code)
            mov rax, 60 ; chamada de sistema sys_exit
            mov rdi, 0 ; retorna 0 (sucesso)
            syscall ; chamada ao sistema operacional
            

section .bss 
buffer:       resb 256
numero:       resb 10
contador:     resb 12
tamanho:      resb 10

section .data
    primo:    dd   0
    div:      dd   2
    modo:     dd   0
    MAX:      dd   10000
    dez:     EQU 10
    STDIN:   EQU 0
    STDOUT:  EQU 1
    STDERR:  EQU 2
    ASCII:   EQU 48
