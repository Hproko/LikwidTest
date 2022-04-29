/* Henrique Prokopenko GRR20186712
 * 	
 * 	Lib de funcoes de max e normas */

#include <math.h>



int Max_coluna(double *A, int i, int n){

    //maior = elemento da diagonal principal em modulo
    double maior = fabs(A[i * n + i]);
    

    int index = i;
    
    double aux;

    for(int j=i; j<n; j++){

        aux = fabs(A[j * n + i]);

        if (aux > maior){
            index = j;
            maior = aux;
        }
    }

   
    return index;
}


void troca_linha(double *A, double *b, int i, int ipivo, int n){

    double aux1, aux2;

    //troca linhas da matriz A
    for(int j=0; j<n; j++){
        aux1 = A[i*n+j];
        A[i*n+j] = A[ipivo*n+j];
        A[ipivo*n+j] = aux1;
    }


    //troca linha no vetor b
    if(!b){
        aux2 = b[i];
        b[i] = b[ipivo];
        b[ipivo] = aux2;
    }

}



double norma_delta(double *delta, int n){

    //maior = | delta[0] |
    double maior = fabs(delta[0]);
    double aux;

    for(int i=0; i<n; i++){

        aux = fabs(delta[i]);
        if(aux > maior)
            maior = aux;

    }

    return maior;


}


double max_erro(double *X, double *Xant, int n){

    
    double max = fabs(X[0] - Xant[0]);
    double aux;

    for(int i=1; i<n; i++){

        aux = fabs(X[i] - Xant[i]);

        if(aux > max)
            max = aux;
    }

    return max;
}
