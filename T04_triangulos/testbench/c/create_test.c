#include <stdio.h>
#include <stdlib.h>
#include <time.h>

//Numero de casos de teste a ser gerado
#define CASES_TEST 100

//Tamanho da matriz de teste, valores maximos que X e Y, respectivamente irão assumir
#define RESOLUTION_X 640
#define RESOLUTION_Y 480

//Cria casos de teste randômicos
main() {
	int i;

	//Cria os N casos de teste
	for(i=0;i<CASES_TEST;i++){
		//A cada caso de teste, 8 valores, correspondendo, respectivamente a X e Y de cada ponto
		//Seguindo a ordem: P, A, B, C
		printf("%d %d %d %d %d %d %d %d\n", (rand() % RESOLUTION_X), (rand() % RESOLUTION_Y), (rand() % RESOLUTION_X), (rand() % RESOLUTION_Y), (rand() % RESOLUTION_X), (rand() % RESOLUTION_Y), (rand() % RESOLUTION_X), (rand() % RESOLUTION_Y));
	}

   return 0;
}
