/* Henrique Prokopenko GRR20186712

        implementacao da biblioteca que usa funcoes da libmatheval*/

#include <matheval.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

#include "Rosenbrock.h"
#include "estrut_funcao.h"


void Calcula_Vgradiente(funcao_t *f){

    int n = f->num_var;

    for(int i=0;i<n;i++){
            f->vetor_gradiente[i] = evaluator_derivative(f->f, f->variaveis[i]);
    }
}



void Calcula_Hessiana(funcao_t *f){

    int n = f->num_var;

    for(int i=0;i<n;i++)
        for(int j=0;j<n;j++){
            f->Hessiana[i][j] = evaluator_derivative(f->vetor_gradiente[i], f->variaveis[j]);
        }
}


double norma_grad(funcao_t *f, double *v){

    int n = f->num_var;

    //maior = valor em modulo da primeira funcao do vetor gradiente
    double maior = fabs(rosenbrock_dx(0, v, n));
    
    double aux;

    for(int i=1; i<n; i++){
        
        //aux = valor em modulo de cada funcao do vetor gradiente
        aux = fabs(rosenbrock_dx(i, v, n));

        if(aux > maior)
            maior = aux;

    }

    return maior;

}



void calc_matriz_coeficientes(double * restrict v, int n, double * restrict a, double * restrict d, double * restrict c){

    for(int i=0; i<n; i++)
        d[i] = rosenbrock_dxdy(i, i, v, n);

    for(int i=0; i<n-1; i++){
        c[i] = rosenbrock_dxdy(i, i+1, v, n); 
        a[i] = rosenbrock_dxdy(i+1, i, v, n);
    }
}


