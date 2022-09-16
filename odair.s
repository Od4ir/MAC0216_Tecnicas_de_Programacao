
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
eh_primo    RET


global _start  ; tipo o main
_start: 

            ; Leitura da entrada:
            mov rdi, STDIN               ; primeiro parâmetro é o descritor de arquivo que será lido
            mov rsi, buffer              ; segundo parâmetro é o ponteiro para o buffer onde o conteúdo lido será armazenado
            mov rdx, 256                 ; terceiro argumento é a quantidade de bytes a serem lidos
            mov rax, 0                   ; número da syscall read
            syscall

            ; Modo escolhido:
            MOV ECX, buffer
            MOV BL, byte[ECX]
            SUB BL, 48

            PUSH EAX
            SUB EAX, 1
            ADD ECX, EAX
            MOV 


            POP EAX










            mov rdi, STDOUT ; primeiro parâmetro é o descritor do arquivo que será escrito
            mov rsi, buffer ; segundo parâmetro é o ponteiro para a mensagem que será escrita
            mov rdx, rax ; terceiro parâmetro é o tamanho da mensagem (ainda está em eax)
            mov rax, 1 ; número da syscall write
            syscall
            JMP fim


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
fim:        ; sys_exit(return_code)
            mov rax, 60 ; chamada de sistema sys_exit
            mov rdi, 0 ; retorna 0 (sucesso)
            syscall ; chamada ao sistema operacional
            

section .bss 
buffer:  resb 256

section .data
    primo:    dd   0
    numero:   dd   17
    div:      dd   2
    modo:     dd   0
    MAX:      dd   10000
    STDIN:   EQU 0
    STDOUT:  EQU 1
    STDERR:  EQU 2
