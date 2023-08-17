section .text

ehprimo:
            MOV  byte[primo], 1         ; Varíavel primo, de comparação, recebe 1 (Verdadeiro);
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
            MOV EAX, [numero]          ; Return EBX, pois EBX tem o número!
            MOV EAX, 900               ; DÁ UM I R AGORAAA!
modo_1: 



fim:    


section .bss   


section .data
primo:    dd   0
numero:   dd   5
div:      dd   2
modo:     dd   0
MAX:      dd   100



