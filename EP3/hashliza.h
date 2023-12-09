/* --------- FUNÇÕES PRINCIPAIS: --------- */
#define SIZE_BLOCO 16

/// @brief Função que recebe uma string no formato (char *) e devolve uma nova string seguindo os procedimentos do Passo 1 do EP1;
/// @param stringEntrada: Uma string (char *) de tamanho qualquer;
/// @return Uma nova string (char *) gerada a partir das transformações do Passo 1 do EP1 de tamanho múltiplo de SIZE_BLOCO;
char * ep1Passo1Preenche(char * );

/// @brief Função que recebe uma string gerada na função do Passo 1, junto com um vetor de inteiros sem repetição de 0 a 255 e devolve uma nova string (char *) seguindo os procedimentos do Passo 2 do EP1; 
/// @param saidaPassoUm: Uma string gerada no Passo 1;
/// @param vetorMagico: Um vetor de inteiros sem repetição com valores de 0 a 255;
/// @param tamanho: O tamanho da string 'saidaPassoUm';
/// @return Uma nova string (char *) gerada a partir das transformações do Passo 2 do EP1 ou NULL se a entrada for NULL;
char * ep1Passo2XOR(char *, int *, int *); 

/// @brief Função que recebe uma string gerada no Passo 2, junto com um vetor de inteiros sem repetição de 0 a 255 e devolve uma nova string de 3 * SIZE_BLOCO + 1 caracteres;
/// @param saidaPassoDois: Uma string gerada no Passo 2;
/// @param vetorMagico: Um vetor de inteiros sem repetição com valores de 0 a 255;
/// @param tamanho: O tamanho da string 'saidaPassoDois';
/// @return Uma nova string (char *) de tamanho 49 caracteres ou NULL caso um dos parâmetros de entrada seja inadequado;
char * ep1Passo3Comprime(char *, int *, int); 

/// @brief Função que recebe uma string gerada no Passo 3 e devolve os SIZE_BLOCO primeiros caracteres dessa string;
/// @param saidaPassoTres: Uma string gerada no Passo 3;
/// @return Um recorte dos 'SIZE_BLOCO's caracteres da string da entrada ou NULL se a string de entrada for NULL;
char * ep1Passo4Hash(char *);

/// @brief Função que recebe uma string do Passo 4 de tamanho SIZE_BLOCO e devolve os valores em código hexadecimal;
/// @param saidaEmHash: Uma string gerada no Passo 4;
/// @return Uma string com os valores da string dada como entrada convertida em hexadecimal;
char * ep1Passo4HashEmHexa(char *);

/// @brief Função que recebe um inteiro e o utiliza como 'seed' da função 'srand()' para gerar valores aleatórios e compor um vetor com valores de 0 a 255 aleatorizado;
/// @param seed: Semente para geração dos números aleatórios;
/// @return Um vetor de inteiros de 0 a 255 aleatorizado;
int * ep3CriaVetorMagico(int);

/* --------- FUNÇÕES AUXILIARES: --------- */

/// @brief Função que recebe um vetor de inteiros e verifica se esse vetor possui todos os valores entre 0 e 255 sem repetição alguma;
/// @param  vetor: Um vetor de inteiros (int *);
/// @return Um valor inteiro - Sendo 0 se a entrada é inválida de acordo com os parâmetros e 1 se a entrada é válida;
int vetor_magico_valido(int *); 