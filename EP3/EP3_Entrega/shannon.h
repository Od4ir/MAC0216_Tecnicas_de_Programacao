#ifndef _SHANNON_H_
#define _SHANNON_H_

/*!
 * \brief Função que calcula a entropia de Shannon de uma string de
 * acordo com o apresentado em https://youtu.be/maJ0oG-JzGw;
 * \param stringEntrada: Uma string de qualquer tamanho;
 * \param base: A base do logaritmo a ser usada no cálculo da entropia;
 * \return O valor da entropia de Shannon;
 */
long double ep3CalculaEntropiaShannon(char * stringEntrada, int base);

#endif // _SHANNON_H_