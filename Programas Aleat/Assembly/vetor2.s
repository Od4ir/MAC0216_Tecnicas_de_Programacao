; codigo de exemplo para verificar como o +1 de um vetor criado
; com dw caminha no vetor

global _start
section .text
_start:


p1:    mov ah, byte[vetordb]   ; 1
p2:   mov ah, byte[vetordb+1] ; 2
p3:    mov ah, byte[vetordb+2] ; 7
p33:   mov ah, byte[vetordb + 4]; 23

p4:   mov ax, word[vetordw]   ; 0x14
p5:   mov ax, word[vetordw+2] ; Se caminhar 2 bytes ah vai ter 0x16.
                        ; Se nao, vai ter 0x13
p6:  mov eax, dword[vetordw+2] 
p7:  mov eax, dword[vetordw+5] 

  mov rax, 60
   mov rdi, 0
    syscall

section .data
vetordb: db 1, 2, 7, 21, 43
vetordw: dw 257, 259, 9009, 909, 1, 4
vetorhex: db 0, 1, 2, 3, 4, 5, 6 ,7 ,8, 9, 'a', 'b', 'c', 'd', 'e', 'f'


; A especificação antes do segundo parâmetro do MOV permite controlar o que está sendo enviado;
; Nos exemplos da linha p4 e p5, o word especifica que serão movidos 2 bytes, que é o que os números representados ocupam. Ao somar 1 byte na memória, eu não chego na segunda posição, mas ao fazer +2, eu chego na próxima;
