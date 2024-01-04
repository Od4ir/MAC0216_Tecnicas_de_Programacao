# 🔐 EP1 - Código Hash em Assembly e Python


## 📄 Descrição:
Este projeto consiste no Exercício Programa I (EP1) da disciplina MAC 0216 - Técnicas de Programação I, orientada pelo professor Daniel Macedo Batista, no curso de Ciência da Computação do Instituto de Mamemática e Estatística da Universidade de São Paulo (IME - USP). 

O projeto consiste em dois programas escritos em 2 linguagens diferentes:Python e Assembly. Os programas recebem um texto passado como entrada pelo terminal e devolvem um código de 32 caracteres utilizando os dígitos do sis- tema hexadecimal. 

A ideia do programa é simular um algoritmo de hashing, que recebe uma entrada de tamanho variável e a mapeia para uma saída de tamanho constante. No caso, a entrada é o texto e a saída de tamanho constante é o código de 32 caracteres construído com os dígitos do sistema hexadecimal. 

## 🔗 Dependências:

Todos os testes foram feitos em um computador com **arquitetura x86_64** com sistema operacional **Linux Ubuntu - 22.04.3 LTS**.

- **GNU ld**: GNU ld (GNU Binutils for Ubuntu) 2.38
- **NASM:** Versão 2.15.05 - Montador para linguagem Assembly;
- **Python:** Versão 3.10.10 - Linguagem Python;
- **GNU gdb (Compilação):** GNU gdb (Ubuntu 12.1-0ubuntu1~22.04) 12.1

## 🔨 Gerando o Executável:
Para gerar o executável (a.out) em Assembly, basta digitar no terminal:

```bash
nasm -f elf64 -g -o EP.o EP.s
ld -s -o a.out EP.o
```

* O parâmetro -g pode ser retirado caso não deseje debugar o código utilizando o GDB;

## ▶️ Executando o código:

#### 🐍 Em Python:
Para o código em Python, basta digitar no terminal:
```bash
python EP1.py
```
Após isso, irá aparecer na tela:
<pre>
Digite uma string: 
</pre>

Basta digitar o texto desejado e pressionar enter para produzir o 
código que será semelhante ao exposto a seguir (no sentido de tamanho
e caracteres usados, provavelmente vai ser algo bem mais aleatório):
<pre>
abcdef1234567890abcdef1234567890
</pre>

Para passar um arquivo, por exemplo, 'textoexemplo.txt' como entrada, basta digitar no terminal:
```bash
python ep1.py < textoexemplo.txt
```
A saída nesse caso será:
<pre>
Digite uma string:
< Código de 32 caracteres gerado >
</pre>

#### 🤖 Em Assembly:

Para o código em Assembly, após gerar o executável basta digitar no 
terminal:

```bash
./a.out
```
Após isso, irá aparecer na tela:
<pre>
Digite uma string: 
</pre>

E assim como o código em Python, basta digitar a string, pressionar 
enter e verificar o código gerado na saída. 
Para exemplos utilizando arquivo, basta digitar no terminal:
```bash
./a.out < textoexemplo.txt
```

## 🧪📋 Testes & Exemplos:

**Python:**
<pre>
python EP1.py
Digite uma string: 
Pandas sao fofos
8d7af7c76a92c8369d2b6f69b2fcb234
</pre>

<pre>
python EP1.py
Digite uma string: 
Por favor me de uma nota boa
58a078fa420bd0994c6bcf03e0b00a9b
</pre>


**Assembly:**
<pre>
./a.out 
Digite alguma string: 
Pandas sao fofos
8d7af7c76a92c8369d2b6f69b2fcb234
</pre>

<pre>
./a.out 
Digite alguma string: 
Por favor me de uma nota boa
58a078fa420bd0994c6bcf03e0b00a9b
</pre>