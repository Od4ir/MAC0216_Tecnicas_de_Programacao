#ifndef _HASHLIZA_H_
#define _HASHLIZA_H_

#include <string.h>
#include <math.h>

/*!
 * \brief Função que realiza o Passo 1 do EP1 (Essa explicação está
 * bem ruim)
 * \param stringEntrada: Uma string de qualquer tamanho
 * \return Devolve a string passada como entrada modificada de modo a
 * ter um tamanho que seja múltiplo de 16 bytes. Se ela já for
 * múltiplo, o retorno é a mesma string. Se não for múltiplo, as novas
 * posições adicionadas são preenchidas com o quanto falta para ser
 * múltiplo
 */
char * ep1Passo1Preenche(char * stringEntrada);

#endif // _HASHLIZA_H_
