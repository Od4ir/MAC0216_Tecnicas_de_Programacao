TAM = 16

def main():
    # Lendo a entrada:
    string_entrada = input("Digite uma string: ")

    # Parâmetros importantes:
    tam_entrada = len(string_entrada)
    num_blocos = int(tam_entrada / TAM)

    if num_blocos * TAM < tam_entrada:
        num_blocos = num_blocos + 1
    new_pos = TAM * num_blocos - tam_entrada
    # new_pos - Indica quantos espaços em um dos blocos serão preenchidos com alguma informação aleatória;


    """ ----- PASSO 1 - Ajuste do Tamanho: ----- """

    # Colocando em uma lista o código em ASCII de cada caractere da entrada:
    saidaPassoUm = []
    for i in range(len(string_entrada)):
        saidaPassoUm.append(ord(string_entrada[i]))
    
    # Preenchendo os espaços até ter um múltiplo de 16 com: 16 - tam_entrada % 16
    print("Posições a serem preenchidas: ", new_pos, '\n')
    for i in range(new_pos):
        saidaPassoUm.append(TAM - tam_entrada % TAM)

    """ 
     for i in range(len(saidaPassoUm)):
        print(i, ": ", saidaPassoUm[i])

    print(saidaPassoUm) 
    """ 

    """ ----- PASSO 2 - Cálculo e Contanação dos XOR ----- """



    
    


main()