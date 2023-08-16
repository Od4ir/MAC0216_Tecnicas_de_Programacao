TAM = 16

def main():
    string_entrada = input("Digite uma string: ")
    tamanho_entrada = len(string_entrada)

    num_blocos = int(tamanho_entrada / TAM)
    resto = tamanho_entrada % TAM

    if num_blocos * TAM < tamanho_entrada:
        num_blocos = num_blocos + 1
    new_pos = TAM * num_blocos - tamanho_entrada


    # num_blocos - Indica quantos blocos de 16 bytes serão necessários para guardar a string;
    # resto - Indica quantos espaços em um dos blocos serão preenchidos com alguma informação aleatória;

    
    print(num_blocos)
    print(tamanho_entrada)
    print(new_pos)


main()