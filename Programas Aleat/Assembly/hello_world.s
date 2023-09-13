; "Hello World!" em Linux NASM, 64-bits
; Montar com: nasm -f elf64 hello_world-64.s [-o saida.o]
; Linkar com: ld -s [-o saida] saida.o
global _start            ; exporta para o ligador (ld) o ponto de entrada

section .text
_start:
    ; sys_write(stdout, mensagem, tamanho)
    mov rax, 1           ; chamada de sistema sys_write
    mov rdi, 1           ; stdout
    mov rsi, mensagem    ; endereço da mensagem
    mov rdx, tamanho     ; tamanho da string de mensagem
    syscall              ; chamada ao sistema operacional
 
    ; sys_exit(return_code)
    mov rax, 60          ; chamada de sistema sys_exit
    mov rdi, 0           ; retorna 0 (sucesso)
    syscall              ; chamada ao sistema operacional

section .data
mensagem: db 'Hello, world!',0x0A    ; mensagem e quebra de linha
tamanho:  equ $ - mensagem           ; tamanho da mensagem

; Para rodar no terminal: ./a.out