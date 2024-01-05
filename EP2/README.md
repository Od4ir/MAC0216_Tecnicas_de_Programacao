# 💬 EP2 - Sistema de Chat 

## 📑 índice:

- [📄 Descrição](#-descrição)
- [🔗 Dependências](#-dependências)
- [▶️ Executando o código](#️-executando-o-código)
    - [🌐 Modo Servidor](#-modo-servidor)
    - [👤 Modo Cliente](#-modo-cliente)
- [🧪 Como Testar](#-como-testar)


## 📄 Descrição:
O programa a seguir, escrito em bash script, simula um sistema de chat com modos de servidor e cliente que permite a comunicação entre terminais do seu computador. Cada modo conta com diferentes opções, sendo o modo servidor o principal para controle do sistema e o modo cliente o modo responsável por permitir simular o uso de um usuário. 

Para entender o melhor o projeto, considere ler:
- [Relatório do EP2](https://github.com/Od4ir/MAC0216_Tecnicas_de_Programacao/blob/main/EP2/Relatorio_do_EP2.pdf);
- [Enunciado do EP2](https://github.com/Od4ir/MAC0216_Tecnicas_de_Programacao/blob/main/EP2/EP2_Enunciado.pdf);


## 🔗 Dependências:
Todos os testes foram feitos em um computador com **arquitetura x86_64** com sistema operacional **Linux Ubuntu - 22.04.3 LTS**.
- **Curl** - curl 7.81.0

## ▶️ Executando o código:
### 🌐 Modo Servidor:
Para executar o modo servidor:
1. Abra um terminal e na pasta com esse script digite: (Esse comando irá executar o modo servidor do sistema de chat.
)
```bash
bash ep2.sh servidor
```

### 👤 Modo Cliente:
Para executar o modo cliente:
1. Primeiro execute o servidor em algum terminal como foi descrito anteriormente;
2. Abra um novo terminal e na pasta com esse arquivo digite (# Esse comando irá executar o modo cliente e permitir que outras opções e comandos sejam realizados para esse tipo de modo):
```bash
bash ep2.sh cliente
```


## 🧪 Como Testar:
Para testar a comunicação entre terminais diferentes faça:
1. Execute o modo servidor em um terminal;
2. Execute o modo cliente em dois terminais diferentes;
3. Crie ao menos 2 usuários com os comandos para isso;
4. Faça login com cada um deles nos dois terminais no modo cliente;
5. Manda mensagens usando o nome dos usuários entre os terminais e se divirta!

