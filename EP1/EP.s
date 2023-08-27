global _start

section .data
    str:          db   "Digite alguma string: ", 0xA
    str_size:     equ  $ - str

    STDIN:        equ  0
    STDOUT:       equ  1
    SIZE_BLOCO:   equ  16

    vetorhex:     db   0, 1, 2, 3, 4, 5, 6 ,7 ,8, 9, 'a', 'b', 'c', 'd', 'e', 'f'
    vetormagico:  db   122, 77, 153, 59, 173, 107, 19, 104, 123, 183, 75, 10, 114, 236, 106, 83, 117, 16, 189, 211, 51, 231, 143, 118, 248, 148, 218, 245, 24, 61, 66, 73, 205, 185, 134, 215, 35, 213, 41, 0, 174, 240, 177, 195, 193, 39, 50, 138, 161, 151, 89, 38, 176, 45, 42, 27, 159, 225, 36, 64, 133, 168, 22, 247, 52, 216, 142, 100, 207, 234, 125, 229, 175, 79, 220, 156, 91, 110, 30, 147, 95, 191, 96, 78, 34, 251, 255, 181, 33, 221, 139, 119, 197, 63, 40, 121, 204, 4, 246, 109, 88, 146, 102, 235, 223, 214, 92, 224, 242, 170, 243, 154, 101, 239, 190, 15, 249, 203, 162, 164, 199, 113, 179, 8, 90, 141, 62, 171, 232, 163, 26, 67, 167, 222, 86, 87, 71, 11, 226, 165, 209, 144, 94, 20, 219, 53, 49, 21, 160, 115, 145, 17, 187, 244, 13, 29, 25, 57, 217, 194, 74, 200, 23, 182, 238, 128, 103, 140, 56, 252, 12, 135, 178, 152, 84, 111, 126, 47, 132, 99, 105, 237, 186, 37, 130, 72, 210, 157, 184, 3, 1, 44, 69, 172, 65, 7, 198, 206, 212, 166, 98, 192, 28, 5, 155, 136, 241, 208, 131, 124, 80, 116, 127, 202, 201, 58, 149, 108, 97, 60, 48, 14, 93, 81, 158, 137, 2, 227, 253, 68, 43, 120, 228, 169, 112, 54, 250, 129, 46, 188, 196, 85, 150, 6, 254, 180, 233, 230, 31, 76, 55, 18, 9, 32, 82, 70

section .bss
    buf:            resb 100001
    buf_size:       equ 100001
    num_blocos:     resq 1
    new_pos:        resb 1
    saidaPassoUm:   resb 100001


section .text
_start:

        ; Chamada do write() para imprimir o conteúdo da 'str' na tela:
        MOV RAX, 1
        MOV RDI, STDOUT
        MOV RSI, str
        MOV RDX, str_size
        syscall

        ; Chamada da leitura para ler um conteúdo do terminal;
        MOV RAX, 0
        MOV RDI, STDIN
        MOV RSI, buf
        MOV RDX, buf_size
        syscall

        ; Vamos descobrir o número de blocos dividindo o nº de caracateres 
        ; lidos pelo tamanho de cada bloco.
        ; RAX guarda o nº de caracteres lidos + 1, por isso, decrementamos.
        ; RBX será o divisor;
        ; No fim, 'num_blocos' guarda o quociente;
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


        ; """ ----- PASSO 1 - Ajuste do Tamanho: ----- """

        ; 'new_pos' guarda quantas posições do novo bloco precisão ser 
        ; preenchidas com alguma informação aleatória.
        ; Note que se RDX == 0, 'new_pos' == '6.
p1:     MOV R9, SIZE_BLOCO
        SUB R9, RDX
        MOV [new_pos], R9    

        MOV RCX, 0
loop1:  MOV AL, byte[buf + RCX]
        MOV byte[saidaPassoUm + RCX], AL
        INC RCX
        CMP RCX, R8
        JNE loop1
             








        ; Saída do programa:
        mov rax, 60          ; chamada de sistema sys_exit
        mov rdi, 0           ; retorna 0 (sucesso)
        syscall              ; chamada ao sistema operacional



