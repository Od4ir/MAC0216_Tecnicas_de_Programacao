global _start

section .data
    str:        db "Digite alguma mensagem: ", 0xA
    str_size:   equ $ - str

    STDIN:      equ 0
    STDOUT:     equ 1


section .bss
    buf:        resb 64
    buf_size:   equ 64


section .text
_start:

impressao1:
        ; Chamada do write() para imprimir o conteúdo da 'str' na tela:
        MOV RAX, 1
        MOV RDI, STDOUT
        MOV RSI, str
        MOV rdx, str_size
        syscall

leitura:
        ; Chamada da leitura para ler um conteúdo do terminal;
        MOV RAX, 0
        MOV RDI, STDIN
        MOV RSI, buf
        MOV RDX, buf_size
        syscall

impressao2:
        ; Após a leitura, RAX guarda o número de bytes que foram lidos;
        MOV RBX, RAX

        MOV RAX, 1
        MOV RDI, STDOUT
        MOV RSI, buf
        MOV RDX, RBX
        syscall

        ; sys_exit(return_code)
        mov rax, 60          ; chamada de sistema sys_exit
        mov rdi, 0           ; retorna 0 (sucesso)
        syscall              ; chamada ao sistema operacional





