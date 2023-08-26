; programa que verifica se um inteiro m eh multiplo de um inteiro n.
; Isso vai ser informado imprimindo [eh multiplo] ou [nao eh multiplo]
; na tela e tambem pelo valor de retorno do programa (0 se multiplo; 1
; se nao multiplo). considere que m e n tem apenas 1 caracter.

global _start
section .text
_start:
    ; ++++++++++++PASSO 1++++++++++++++
    ; Ler m e n (vou usar a sycall read)
    ; Mas antes vou imprimir uma string informando para o
    ; usuário o que eu quero (vou usar a syscall write para
    ; isso primeiro)
    mov rax, 1
    mov rdi, STDOUT
    mov rsi, promptM
    mov rdx, tamPromptM
    syscall

    mov rax, 0
    mov rdi, STDIN
    mov rsi, m
    mov rdx, 2
    syscall

    mov rax, 1
    mov rdi, STDOUT
    mov rsi, promptN
    mov rdx, tamPromptN
    syscall

    mov rax, 0
    mov rdi, STDIN
    mov rsi, n
    mov rdx, 2
    syscall
    ; +++++++++++++++++++++++++++++++++
    
    ; ++++++++++++PASSO 2++++++++++++++
    ; Divide m por n
    ; mas antes tenho que lembrar que o valor eh ASCII e para
    ; ter o digito equivalente eu preciso subtrair 48. Se tiver
    ; dúvida: rode no terminal o comando:
    ; man ascii
    sub byte [m], 48
    sub byte [n], 48

    ; Lembrando da divisão:
    ; DIV reg|mem
    ;   
    ; quando o operando (divisor) tiver 8 bits:
    ; dividendo: ax (Lembrando que m tem 8 bits, então preciso
    ;                colocar o valor de m em al e zerar o valor
    ;                de ah)
    ; resto: ah
    ; quociente: al
    ;
    ; Importante: o dividendo fica em ax (2 bytes), mas o valor de [m]
    ; tem 1 byte então preciso limpar a metade superior de ax
    ; (ah) colocando 0 e movendo o valor de m para a metade
    ; inferior (al)
    mov ah, 0
    mov al, [m]
    div byte [n]
    ; nesse ponto do código, ah tem o resto da divisão

    ; ++++++++++++PASSO 3++++++++++++++
    ; Compara o resto com 0
    ; Imprime se eh multiplo ou nao a depender do valor do
    ; resto, ajusta o código de retorno do programa e termina
    cmp ah, 0
    je eMu
    ; Se o codigo continua aqui, eh porque nao eh multiplo
    mov rax, 1
    mov rdi, STDOUT
    mov rsi, strNaoEhMultiplo
    mov rdx, tamStrNaoEhMutiplo
    syscall
    
    ; Sai do programa com código de retorno = 0
    mov rax, 60
    mov rdi, 1
    syscall

eMu:mov rax, 1
    mov rdi, STDOUT
    mov rsi, strEhMultiplo
    mov rdx, tamStrEhMutiplo
    syscall

    ; Sai do programa com código de retorno = 1
    mov rax, 60
    mov rdi, 0
    syscall

section .data

promptM: db 'Digite o valor de m: '
tamPromptM: equ $ - promptM

promptN: db 'Digite o valor de n: '
tamPromptN: equ $ - promptN

strEhMultiplo: db '[eh multiplo]', 10
tamStrEhMutiplo: equ $ - strEhMultiplo

strNaoEhMultiplo: db '[nao eh multiplo]', 10
tamStrNaoEhMutiplo: equ $ - strNaoEhMultiplo

STDIN: equ 0
STDOUT: equ 1

section .bss

m: resb 2
n: resb 2