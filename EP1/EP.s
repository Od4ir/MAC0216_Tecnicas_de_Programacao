global _start

; ----- VARIÁVEIS INICIADAS: -----
section .data
    str:          db   "Digite alguma string: ", 0xA
    str_size:     equ  $ - str

    STDIN:        equ  0
    STDOUT:       equ  1
    SIZE_BLOCO:   equ  16
    ENTER_:       equ  10

    vetorhex:     db   '0', '1', '2', '3', '4', '5', '6' ,'7' ,'8', '9', 'a', 'b', 'c', 'd', 'e', 'f'
    vetormagico:  db   122, 77, 153, 59, 173, 107, 19, 104, 123, 183, 75, 10, 114, 236, 106, 83, 117, 16, 189, 211, 51, 231, 143, 118, 248, 148, 218, 245, 24, 61, 66, 73, 205, 185, 134, 215, 35, 213, 41, 0, 174, 240, 177, 195, 193, 39, 50, 138, 161, 151, 89, 38, 176, 45, 42, 27, 159, 225, 36, 64, 133, 168, 22, 247, 52, 216, 142, 100, 207, 234, 125, 229, 175, 79, 220, 156, 91, 110, 30, 147, 95, 191, 96, 78, 34, 251, 255, 181, 33, 221, 139, 119, 197, 63, 40, 121, 204, 4, 246, 109, 88, 146, 102, 235, 223, 214, 92, 224, 242, 170, 243, 154, 101, 239, 190, 15, 249, 203, 162, 164, 199, 113, 179, 8, 90, 141, 62, 171, 232, 163, 26, 67, 167, 222, 86, 87, 71, 11, 226, 165, 209, 144, 94, 20, 219, 53, 49, 21, 160, 115, 145, 17, 187, 244, 13, 29, 25, 57, 217, 194, 74, 200, 23, 182, 238, 128, 103, 140, 56, 252, 12, 135, 178, 152, 84, 111, 126, 47, 132, 99, 105, 237, 186, 37, 130, 72, 210, 157, 184, 3, 1, 44, 69, 172, 65, 7, 198, 206, 212, 166, 98, 192, 28, 5, 155, 136, 241, 208, 131, 124, 80, 116, 127, 202, 201, 58, 149, 108, 97, 60, 48, 14, 93, 81, 158, 137, 2, 227, 253, 68, 43, 120, 228, 169, 112, 54, 250, 129, 46, 188, 196, 85, 150, 6, 254, 180, 233, 230, 31, 76, 55, 18, 9, 32, 82, 70

; ----- VARIÁVEIS NÃO INICIADAS: -----
section .bss
    buf:            resb 100010
    buf_size:       equ 100010
    num_blocos:     resq 3
    new_pos:        resq 2
    saida:          resb 100020
    saida3:         resb 48
    novoBloco:      resb 16
    hexac:          resb 35

; ----- CÓDIGO: -----
section .text

; ////////////// ----- SUBROTINAS - IMPRESSÕES ----- //////////////
impressao1:
        ; Chamada do write() para imprimir o conteúdo da 'str' na tela:
        MOV RAX, 1
        MOV RDI, STDOUT
        MOV RSI, str
        MOV RDX, str_size
        syscall  
        ret 

impressao2:
        ; Chamada do write() para imprimir o conteúdo de 'hexac' na tela:
        MOV RAX, 1
        MOV RDI, STDOUT
        MOV RSI, hexac
        MOV RDX, 35
        syscall  
        ret 

; ////////////// ----- SUBROTINA - LEITURA ----- //////////////
leitura:
        ; Chamada da leitura para ler um conteúdo do terminal;
        MOV RAX, 0
        MOV RDI, STDIN
        MOV RSI, buf
        MOV RDX, buf_size
        syscall
        ret


; ////////////// ----- SUBROTINA - PASSO 1 ----- //////////////
passo1:
        ; 'new_pos' guarda quantas posições do novo bloco precisarão serem
        ; preenchidas com alguma informação aleatória.
        ; Note que se RDX == 0, então 'new_pos' == SIZE_BLOCO.
        ;       * RDX guarda o resto da divisão do tamanho_entrada pelo SIZE_BLOCO.
        MOV R9, SIZE_BLOCO
        SUB R9, RDX
        MOV [new_pos], R9    

        ; Vamos percorrer a entrada e salvar os valores na 'saida'.
        ; Lembrando que R8 = nº de caracteres da entrada;
        MOV RCX, 0
 loop1: MOV AL, byte[buf + RCX]
        MOV byte[saida + RCX], AL
        INC RCX
        CMP RCX, R8              ; Verifica se o contador (RCX) == tamanho_entrada.
        JNE loop1

        ; Se 'new_pos' == 16, não precisamos preencher o vetor 'saida' 
        ; com mais nada e podemos sair sa subrotina;
        MOV R9, SIZE_BLOCO
        CMP R9, [new_pos]  
        MOV R9, R8               ; Mas antes salvamos em R9 o tamanho da 'saida'.
        JE  fim1       

        ; Se 'new_pos' != SIZE_BLOCO, precisamos preencher as novas posições com 
        ; SIZE_BLOCO - (tamanho % SIZE_BLOCO), que é o mesmo valor de 'new_pos':        
        ADD R9, [new_pos]        ; Em R9, temos o tamanho final da saida;
        MOV AL, [new_pos]        ; Colocamos em AL o valor que vamos inserir na saída.
 loop2: MOV byte[saida + RCX], AL
        INC RCX
        CMP RCX, R9              ; Verificamos se já chegamos ao final da 'saida' preenchida. 
        JNE loop2

 fim1:  ret

; ////////////// ----- SUBROTINA - PASSO 2 ----- //////////////
passo2:
        ; O novo bloco já está preenchido com zeros;
        ; O novoValor será salvo em RBX.
        MOV RBX, 0

        ; Zerando RAX, RCX e RDX para os processos seguintes;
        XOR RAX, RAX
        XOR RCX, RCX
        XOR RDX, RDX

        ; Na passagem abaixo iremos fazer o seguinte:
        ; Para i (R10) de 0 até num_blocos:
        ;       Para j (RCX) de 0 até SIZE_BLOCO:
        ;               novoValor = vetorMagico[(saidaPassoUm[i * SIZE_BLOCO + j] ^ novoValor(RBX))] ^ novoBloco[j]
        ;               novoBloco[j] = novoValor(RBX)
        
        MOV R10, -1              ; R10 vai de 0 até 'num_blocos'
 loop3: INC R10
        CMP R10, [num_blocos]
        JE addnb
        MOV RCX, 0               ; RCX vai de 0 até 'SIZE_BLOCO'
 loop4: MOV RAX, SIZE_BLOCO
        MUL R10                          
        ADD RAX, RCX                     ; Em RAX temos: i(R10) * SIZE_BLOCO + j(RCX)
        MOV DL, byte[saida + RAX]        ; Salvamos saidaPassoUm[RAX] em DL;
        XOR DL, BL                       ; Fazemos saidaPassoUm[RAX] ^ novoValor(BL) que fica salvo em RDX
        MOV BL, [vetormagico + RDX]      ; Salvamos vetorMagico[RDX] em BL
        XOR BL, byte[novoBloco + RCX]    ; Fazemos novoValor(BL) = vetorMagico[RDX] ^ novoBloco[j(RCX)]   
        XOR BH, BH      
        MOV byte[novoBloco + RCX], BL    ; Fazemos novoBloco[j(RCX)] = novoValor
        INC RCX
        CMP RCX, SIZE_BLOCO
        JNE loop4
        JMP loop3

        ; R9 guarda o tamanho da 'saida'. Vamos adicionar 
        ; 16 novos valores nesse vetor que estão no 'novoBloco':
        ;       *addnb = Adicionando novo bloco;
 addnb: MOV RCX, R9
        MOV RBX, 0
 loop5: MOV AL, byte[novoBloco + RBX]    ; Colocamos o caractere novoBloco[i(RBX)] em AL
        MOV byte[saida + RCX], AL        ; Colocamos AL nas posições finais da 'saida'
        INC RCX
        INC RBX
        CMP RBX, SIZE_BLOCO
        JNE loop5
        ret

; ////////////// ----- SUBROTINA - PASSO 3 ----- //////////////
passo3:
        INC byte[num_blocos]     ; Aumentamos em 1 o 'num_blocos' para comparações futuras;

        ; R12 = SIZE_BLOCO + 2
        ; R13 = SIZE_BLOCO * 3
        ; R14 = 256
        MOV R12, SIZE_BLOCO
        ADD R12, 2
        MOV RAX, SIZE_BLOCO
        MOV R13, 3
        MUL R13
        MOV R13, RAX
        MOV R14, 256


        ; Para i(R8) de 0 até num_blocos + 1:
        ;       Para j(RCX) de 0 até SIZE_BLOCO:
        ;               // Executamos algumas ações;
        ;        Para j(RCX) de 0 até SIZE_BLOCO + 2:
        ;               Para k(R9) de 0 até SIZE_BLOCO * 3:
        ;                       // Executamos algumas ações;
        ;               temp(R10) = (temp(R10) + j(RCX)) % 256
        MOV R8, -1
 loop6: INC R8
        CMP R8, [num_blocos]
        JE fim3

        MOV RCX, -1
 loop7: INC RCX
        CMP RCX, SIZE_BLOCO
        JE next
        MOV RAX, SIZE_BLOCO       ; RAX = SIZE_BLOCO
        MUL R8                    ; RAX = SIZE_BLOCO * i(R8)
        ADD RAX, RCX              ; RAX = SIZE_BLOCO * i(R8) + j(RCX)

        MOV BL, byte[saida + RAX]    ; BL = saida[SIZE_BLOCO * i + j]

        ADD RCX, SIZE_BLOCO          ; RCX = SIZE_BLOCO + j
        MOV byte[saida3 + RCX], BL   ; saida3[SIZE_BLOCO + j] = BL

        SUB RCX, SIZE_BLOCO          ; Voltando RCX para seu valor correto;
        XOR BL, byte[saida3 + RCX]   ; BL = saida3[SIZE_BLOCO + j] ^ saida3[j]

        MOV RAX, SIZE_BLOCO
        ADD RAX, RAX                 ; RAX = 2 * SIZE_BLOCO
        ADD RAX, RCX                 ; RAX = 2 * SIZE_BLOCO + j
        MOV byte[saida3 + RAX], BL   ; saida[2 * SIZE_BLOCO + j] = BL
        JMP loop7

 next:  MOV R10, 0                ; R10 é o 'temp'
        MOV RCX, -1
 loop8: INC RCX
        CMP RCX, R12              ; j(RCX) == SIZE_BLOCO + 2?
        JE loop6
 
        MOV R9, -1
 loop9: INC R9   
        CMP R9, R13               ; k(R9) == SIZE_BLOCO * 3?
        JE next2
        MOV BL, byte[saida3 + R9]        
        XOR BL, byte[vetormagico + R10]  ; BL = saida3[k] ^ saida3[temp]
        MOV R10, RBX                     ; Atualizando 'temp'
        MOV byte[saida3 + R9], BL        ; saida3[k] = temp
        JMP loop9
 next2: MOV RAX, R10
        ADD RAX, RCX
        DIV R14                   ; RAX = (temp + j) / 256
        MOV R10, RDX              ; temp = (temp + j) % 256
        JMP loop8
 fim3:  ret

; ////////////// ----- SUBROTINA - PASSO 4 ----- //////////////
passo4:
        ; Vamos converter os 'SIZE_BLOCO's primeiros valores da saída 3 em hexadecimal
        ; e salvar em hexac:
        MOV RCX, -1
        MOV R10, -1
        MOV R8, SIZE_BLOCO

        ; Para i(R10) de 0 até SIZE_BLOCO, j(R10) de 0 até 2 * SIZEBLOCO:
        ;       Converte saida3[i] em hexadecimal;
        ;       Salva em hexac[j] o primeiro caractere do hexadecimal;   
        ;       j++;
        ;       Salva em hexac[j] o segundo caractere do hexadecimal;
 loop10:INC RCX  
        INC R10  
        CMP R10, SIZE_BLOCO
        JE fim4                       
        XOR RDX, RDX
        XOR RAX, RAX
        XOR RBX, RBX
        MOV AL, byte[saida3 + R10]
        DIV R8
        MOV BL, byte[vetorhex + RAX]
        MOV byte[hexac + RCX], BL
        INC RCX
        MOV BL, byte[vetorhex + RDX]
        MOV byte[hexac + RCX], BL
        JMP loop10

 fim4:  INC RCX
        MOV byte[hexac + RCX], 10     ; Coloca o '\n' no final da saída.
        ret




; ////////////// ----- SUBROTINA - SAÍDA ----- //////////////
saida_programa:
        ; Saída do programa:
        mov rax, 60          ; chamada de sistema sys_exit
        mov rdi, 0           ; retorna 0 (sucesso)
        syscall              ; chamada ao sistema operacional
        

; ////////////// ----- PARTE PRINCIPAL ----- //////////////
_start:
        call impressao1
        call leitura

        ; Vamos descobrir o número de blocos dividindo o nº de caracateres 
        ; lidos pelo tamanho de cada bloco.
        ; RAX guarda o nº de caracteres lidos + 1, por isso, decrementamos.
        ; RBX será o divisor;
        ; No fim, 'num_blocos' guarda o quociente;
        ; R8 vai guarda o tamanho para operações futuras;
        DEC RAX                         
        MOV R8, RAX
        MOV RBX, SIZE_BLOCO             
        MOV RDX, 0                      
        DIV RBX
        MOV [num_blocos], EAX  


        ; Se o resto da divisão for zero, então num_blocos será suficiente;
        ; Se não, precisaremos de mais um bloco para o resto;
        CMP EDX, 0
        JZ p1
        INC byte[num_blocos]

 p1:    call passo1

        call passo2

        call passo3

        call passo4

        call impressao2

        call saida_programa
