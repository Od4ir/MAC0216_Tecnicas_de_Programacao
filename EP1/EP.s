global _start

section .text
_start:

            MOV RCX, 10
inicio:     DEC RCX
            JNZ inicio

            ; sys_exit(return_code)
            mov rax, 60          ; chamada de sistema sys_exit
            mov rdi, 0           ; retorna 0 (sucesso)
            syscall              ; chamada ao sistema operacional


section .data


