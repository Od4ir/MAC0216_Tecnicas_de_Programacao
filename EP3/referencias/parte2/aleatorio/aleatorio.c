#include "aleatorio.h"

/*
 * Função: RealAleatorio
 * --------------------
 * Gera um número real pseudo-aleatório em um dado intervalo
 *
 * parâmetro 1: (double) limite inferior do intervalo
 * parâmetro 2: (double) limite superior do intervalo
 * retorno: (double) o número real pseudo-aleatório dentro do
 * intervalo
 * 
 * Esta função primeiro obtém um inteiro aleatório
 * no intervalo [0..RAND_MAX] e depois converte-o
 * em um número no intervalo [min..max] aplicando
 * os seguintes passos:
 * (1) Gera um número real entre 0 e 1.
 * (2) Escala-o para o tamanho apropriado de intervalo.
 * (3) Traduz para o ponto de início apropriado.
*/

double RealAleatorio(double min, double max) {
   double d;

   d = (double) rand() / ((double) RAND_MAX + 1);
   return (min + d * (max - min));
}
