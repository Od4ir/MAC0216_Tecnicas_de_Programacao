# 📚 EP3 - Reprodução do [EP1](https://github.com/Od4ir/MAC0216_Tecnicas_de_Programacao/tree/main/EP1) usando Bibliotecas em C

## Índice


## 📄 Descrição:
Este projeto consiste no Exercício Programa 3 (EP3) da disciplina MAC 0216 - 
Técnicas de Programação I, orientada pelo professor Daniel Macedo Batista, no
curso de Ciência da Computação do Instituto de Mamemática e Estatística da
Universidade de São Paulo (IME - USP). 

O projeto consiste na implementação de duas bibliotecas utilizando linguagem
C, sendo uma estática e outra dinâmica, com funções responsáveis por transfor-
mar qualquer string dada como parâmetro em um codigo de 32 caracteres utilizan-
do os dígitos do sistema hexadecimal, além de um programa que realiza os testes
dessas funções e retorna o tempo que cada função levou para rodar.

Para compreender melhor o projeto, considere ler:
- [Relatório EP3]();
- [Enunciado EP3]();

## 🔗 Dependências:
- **Sistema Operacional:** Ubuntu 22.04.3 LTS
- **GCC:** gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
- **BASH:** GNU bash, versão 5.1.16(1)-release (x86_64-pc-linux-gnu)
- **Doxygen:** doxygen 1.9.1
- **Bibliotecas C:** <stdio.h>, <stdlib.h>, <string.h>, <math.h> e <sys/time.h>

## ▶️ Executando o código:

Para compilar e gerar o executável do teste.c, digite no terminal:
```bash
bash compila.sh
```

Esse comando irá rodar o script 'compila.sh' que irá compilar todas as bibliotecas e o código do programa de teste além de gerar uma documentação Doxygen dentro de uma pasta chamada 'doc'. Para verificar essa documentação em formato html basta entrar na pasta:

```bash
cd doc/html
```
E abrir o arquivo index.html no seu navegador.

Para rodar o arquivo 'teste' gerado antes é necessário setar a variavel de ambiente para busca das bibliotecas para o local atual onde está aberto seu terminal:

```bash
export LD_LIBRARY_PATH=${PWD}:$LD_LIBRATY_PATH
```
Após isso basta rodar o executável de nome teste:
```bash
./teste
```


## 🧪 Testes:

Ao rodar os testes, você verá as seguintes informações na sua tela (exemplo):

<pre>
    TESTE 1:
    Hexadecimal: 5d40c34f5ce897d9fe4d5c20b83a46d0
    Entropia: 0.249145
    Teste com string de tamanho: 10

    >>> Tempo:   (médio)      (menor)     (maior)
    > Função 0: 0.000006  ; 0.000000  ;  0.000056
    > Função 1: 0.000003  ; 0.000000  ;  0.000025
    > Função 2: 0.000000  ; 0.000000  ;  0.000001
    > Função 3: 0.000003  ; 0.000001  ;  0.000005
    > Função 4: 0.000056  ; 0.000040  ;  0.000061
    > Função 5: 0.000000  ; 0.000000  ;  0.000001
    > Função 6: 0.000001  ; 0.000000  ;  0.000003
    >>> Tempo TOTAL: 0.000681
</pre>

Onde é possível ver o número do teste feito, o código hexadecimal de 32 caracteres que foi gerado, o cálculo da Entropia de Shannon para a string utilizada e o tempo médio, máximo, mínimo de cada uma das 7 funções implementadas.  

Ao final dos resultados dos testes também é possível ver a legenda de qual função
é qual:

<pre>
    Legenda Funções: 
    Função 0: int * ep3CriaVetorMagico(int);
    Função 1: char * ep1Passo1Preenche(char * );
    Função 2: long double ep3CalculaEntropiaShannon(char *, int);
    Função 3: char * ep1Passo2XOR(char *, int *, int *); 
    Função 4: char * ep1Passo3Comprime(char *, int *, int); 
    Função 5: char * ep1Passo4Hash(char *);
    Função 6: char * ep1Passo4HashEmHexa(char *);
</pre>

Para realizar mais testes ou alterar o tamanho dos testes realizados, entre no arquivo 'teste.c' e altere as variáveis 'tamanho' e 'fator_aumento_tamanho' para alterar os tamanhos de cada teste e 'num_testes' para alterar o número de testes que deseja realizar.

