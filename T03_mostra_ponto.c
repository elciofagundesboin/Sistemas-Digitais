#include<stdio.h>
#include<stdlib.h>
#include<time.h>

int calc_det(int pA[], int pB[], int pC[]){
	
	int diagPrinc, diagOp;
	
	diagPrinc = (pA[0]*pB[1])+(pA[1]*pC[0])+(pB[0]*pC[1]);
	diagOp = (pB[1]*pC[0])+(pA[0]*pC[1])+(pA[1]*pB[0]);
	
	if (diagPrinc>diagOp){
		return diagPrinc-diagOp;
	}else{
		return diagOp-diagPrinc;
	}
}

int main(){
	int A[2], B[2], C[2], P[2], detABC, detABP, detACP, detBCP, x, y, p2[2];

	srand((unsigned) time(NULL));
	
	A[0] = rand()%150;
	A[1] = rand()%50;
	B[0] = rand()%150;
	B[1] = rand()%50;
	C[0] = rand()%150;
	C[1] = rand()%50;
	
	P[0] = rand()%150;
	P[1] = rand()%50;
	
	
	detABC = calc_det(A, B, C);
	if(!detABC){
		return 0;
	}
	
	printf("A: %d, %d;\tB: %d, %d;\tC: %d, %d;\tP: %d, %d\n\n", A[0], A[1], B[0], B[1], C[0], C[1], P[0], P[1]);
	
	
	detABP = calc_det(A, B, P);
	detACP = calc_det(A, C, P);
	detBCP = calc_det(B, C, P);
	
	if(detABC != (detABP + detACP + detBCP)){
		printf("P nao pertence a ABC\n\n");
	}else{
		printf("P pertence a ABC\n\n");
	}
	
	for(y=50; y>0; y--){
		for(x=0; x<150; x++){
			p2[0] = x;
			p2[1] = y;
			
			detABP = calc_det(A, B, p2);
			detACP = calc_det(A, C, p2);
			detBCP = calc_det(B, C, p2);
			
			if((x==P[0]) && (y==P[1])){
				printf("-");
			}else{
				if(detABC != (detABP + detACP + detBCP)){
					printf("X");
				}else{
					printf(" ");
				}
			}
		}
		printf("\n");
	}
	system("pause");
	system("cls");
	return main();
	
	return 0;
}
