#include <stdio.h>
#include <stdlib.h>

typedef struct ponto{
	int x,y;
}ponto;

int determinante(ponto triA, ponto triB, ponto triC);

int main(){
	int j, detABC, detABP, detAPC, detPBC, nTestes;
	ponto tri[3], p;
	char insideTriangle;

	while(scanf("%d %d", &p.x, &p.y) != EOF){
		for(j=0;j<3;j++){
			scanf("%d %d", &tri[j].x, &tri[j].y);
		}

		detABC = determinante(tri[0], tri[1], tri[2]);
		if(!detABC){ //Se det = 0, pontos alinhados e não formam triângulo
			
			insideTriangle = 'x';

		}else{
			
			detABP = determinante(tri[0], tri[1], p);
			detAPC = determinante(tri[0], p, tri[2]);
			detPBC = determinante(p, tri[1], tri[2]);
			
			if(detABC != (detABP + detAPC + detPBC))
				insideTriangle = '0';
			else
				insideTriangle = '1';
		}
		printf("%d %d %d %d %d %d %d %d = %c\n",p.x,p.y,tri[0].x,tri[0].y,tri[1].x,tri[1].y,tri[2].x,tri[2].y, insideTriangle);
	}

	return 0;
}

//Calcula a determinante das coordenadas
int determinante(ponto triA, ponto triB, ponto triC){
	int diagonalPrincipal, diagonalOposta;

	diagonalPrincipal = (triA.x*triB.y)+(triA.y*triC.x)+(triB.x*triC.y);
	diagonalOposta = (triB.y*triC.x)+(triA.x*triC.y)+(triA.y*triB.x);

	if(diagonalPrincipal>diagonalOposta){
		return diagonalPrincipal - diagonalOposta;
	}else{
		return diagonalOposta - diagonalPrincipal;
	}
}
