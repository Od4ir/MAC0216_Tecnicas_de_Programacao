SIZE_BLOCO = 16
vetorMagico = [122, 77, 153, 59, 173, 107, 19, 104, 123, 183, 75, 10,
114, 236, 106, 83, 117, 16, 189, 211, 51, 231, 143, 118, 248, 148, 218,
245, 24, 61, 66, 73, 205, 185, 134, 215, 35, 213, 41, 0, 174, 240, 177,
195, 193, 39, 50, 138, 161, 151, 89, 38, 176, 45, 42, 27, 159, 225, 36,
64, 133, 168, 22, 247, 52, 216, 142, 100, 207, 234, 125, 229, 175, 79,
220, 156, 91, 110, 30, 147, 95, 191, 96, 78, 34, 251, 255, 181, 33, 221,
139, 119, 197, 63, 40, 121, 204, 4, 246, 109, 88, 146, 102, 235, 223,
214, 92, 224, 242, 170, 243, 154, 101, 239, 190, 15, 249, 203, 162, 164,
199, 113, 179, 8, 90, 141, 62, 171, 232, 163, 26, 67, 167, 222, 86, 87,
71, 11, 226, 165, 209, 144, 94, 20, 219, 53, 49, 21, 160, 115, 145, 17,
187, 244, 13, 29, 25, 57, 217, 194, 74, 200, 23, 182, 238, 128, 103,
140, 56, 252, 12, 135, 178, 152, 84, 111, 126, 47, 132, 99, 105, 237,
186, 37, 130, 72, 210, 157, 184, 3, 1, 44, 69, 172, 65, 7, 198, 206,
212, 166, 98, 192, 28, 5, 155, 136, 241, 208, 131, 124, 80, 116, 127,
202, 201, 58, 149, 108, 97, 60, 48, 14, 93, 81, 158, 137, 2, 227, 253,
68, 43, 120, 228, 169, 112, 54, 250, 129, 46, 188, 196, 85, 150, 6, 254,
180, 233, 230, 31, 76, 55, 18, 9, 32, 82, 70]

vetorhex = [0, 1, 2, 3, 4, 5, 6 ,7 ,8, 9, 'a', 'b', 'c', 'd', 'e', 'f']

def main():
    # Lendo a entrada:
    string_entrada = input("Digite uma string: ")

    # Parâmetros importantes:
    tam_entrada = len(string_entrada)
    num_blocos = tam_entrada // SIZE_BLOCO

    if tam_entrada % SIZE_BLOCO != 0:
        num_blocos = num_blocos + 1
    
    """ ----- PASSO 1 - Ajuste do Tamanho: ----- """

    new_pos = SIZE_BLOCO - tam_entrada % SIZE_BLOCO
    # new_pos - Indica quantos espaços em um dos blocos serão preenchidos com alguma informação aleatória;

    # Colocando em uma lista o código em ASCII de cada caractere da entrada:
    saidaPassoUm = []
    for i in range(len(string_entrada)):
        saidaPassoUm.append(ord(string_entrada[i]))
    
    # Preenchendo os espaços até ter um múltiplo de 16 com: 16 - tam_entrada % 16
    if new_pos != 16:
        for i in range(new_pos):
            saidaPassoUm.append(SIZE_BLOCO - tam_entrada % SIZE_BLOCO)



    """ ----- PASSO 2 - Cálculo e Contanação dos XOR ----- """

    novoBloco = [0] * 16
    novoValor = 0

    for i in range(num_blocos):
        for j in range(SIZE_BLOCO):
            novoValor = vetorMagico[(saidaPassoUm[i * SIZE_BLOCO + j] ^ novoValor)] ^ novoBloco[j]
            novoBloco[j] = novoValor

    saidaPassoDois = []
    saidaPassoDois += saidaPassoUm + novoBloco

    """ ---- PASSO 3 - Transformação dos n + 1 blocos em apenas 3 blocos ----- """
    saidaPassoTres = [0] * (SIZE_BLOCO * 3)

    for i in range(num_blocos + 1):
        for j in range(SIZE_BLOCO):
            saidaPassoTres[SIZE_BLOCO + j] = saidaPassoDois[i * SIZE_BLOCO + j]
            saidaPassoTres[2 * SIZE_BLOCO + j] = (saidaPassoTres[SIZE_BLOCO + j] ^ saidaPassoTres[j])
        temp = 0
        for j in range(SIZE_BLOCO + 2):
            for k in range(SIZE_BLOCO * 3):
                temp = saidaPassoTres[k] ^ vetorMagico[temp]
                saidaPassoTres[k] = temp
            temp = (temp + j) % 256
    

    """ ----- PASSO 4 - Definição do Hash como um valor hexadecimal ----- """
    hexac = ''

    for i in range(SIZE_BLOCO):
        # Convertendo valor em hexadecimal:
        hex_atu = saidaPassoTres[i]
        div = hex_atu // SIZE_BLOCO
        resto = hex_atu % SIZE_BLOCO
        hexac += str(vetorhex[div]) + str(vetorhex[resto])
        
    print(hexac)

main()


