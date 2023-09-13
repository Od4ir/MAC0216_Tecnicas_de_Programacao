; codigo de exemplo para verificar como o +1 de um vetor criado
; com dw caminha no vetor

global _start
section .text
_start:

p1:    mov ah, [vetordb]   ; 0x10
p2:   mov ah, [vetordb+1] ; 0x11
p3:    mov ah, [vetordb+2] ; 0x12

p4:   mov ah, [vetordw]   ; 0x14
p5:   mov ah, [vetordw+1] ; Se caminhar 2 bytes ah vai ter 0x16.
                        ; Se nao, vai ter 0x13
p6:  mov ah, [vetordw+2] 

p7:    mov rax, 60
p8:   mov rdi, 0
    syscall

section .data
vetordb: db 0x10, 0x11, 0x12
vetordw: dw 0x1314, 0x1516, 0x1718