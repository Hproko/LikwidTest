/* Henrique Prokopenko GRR20186712
    
    Implementacao da biblioteca de metodos de newton
*/

#include <stdio.h>
#include <stdlib.h>
#include <matheval.h>
#include <math.h>
#include <likwid.h>


#include "estrut_funcao.h"
#include "utils.h"
#include "mathevalUtils.h"
#include "timestamp.h"
#include "MaxNormas.h"
#include "Rosenbrock.h"


void eliminacao_Gauss(double * restrict b, int n, double * restrict a, double * restrict c, double * restrict d){


    for(int i=0; i<n-1; i++){
        double m = a[i] / d[i];

        a[i] = 0.0;
        d[i+1] -= c[i] *m;
        b[i+1] -= b[i] *m;
    }
}

void Gauss_Seidel(double * restrict delta, double * restrict Xant, double * restrict b, int n,
                    double * restrict a, double * restrict c, double * restrict d){

    memset(delta, 0, n * sizeof(double));
    for(int i=0; i<50; i++){

        Xant[0] = delta[0];
        delta[0] = (b[0] - c[0] * delta[1])/d[0];
        
        for(int k=1; k<n-1; k++){
            Xant[k] = delta[k];
            delta[k] = (b[k] - a[k-1] * delta[k-1] - c[k] * delta[k+1])/d[k];
        }
        
        Xant[n-1] = delta[n-1]; 
        delta[n-1] = (b[n-1] - a[n-2] * delta[n-2])/d[n-1];

        if(max_erro(delta, Xant, n) < EPS)
            return;

    
    }
}



void retrossubs(double * restrict b, double * restrict x, int n, double * restrict a, double * restrict c, double * restrict d){
	

    x[n-1] = b[n-1] / d[n-1];
    for(int i=n-2; i >= 0; --i)
        x[i] = (b[i] - c[i] * x[i+1])/d[i];
}


void newton(funcao_t *f, newton_t *newt){

    double Tsl;

    int n = f->num_var; //n guarda o numero de variaveis

    //calcula fx para xº
    newt->resultados[newt->num_resultados] =  rosenbrock(newt->X, n);

    newt->num_resultados++;

    for(int i=0; i<f->max_it; i++){

        if(norma_grad(f, newt->X) < f->eps) return;

        LIKWID_MARKER_START("Calc_Matriz_Hess_NP");
        calc_matriz_coeficientes(newt->X, n, newt->a, newt->d, newt->c);
        LIKWID_MARKER_STOP("Calc_Matriz_Hess_NP");

        // imprimeMatriz(newt->matriz_coeficientes, n);
        LIKWID_MARKER_START("Calc_Vet_Grad_NP");
        //Calculo dos elementos do vetor b
        for(int i=0;i<n;i++)
            newt->vetor_b[i] = - rosenbrock_dx(i, newt->X, n);
        LIKWID_MARKER_STOP("Calc_Vet_Grad_NP");
    
        Tsl = timestamp();


        LIKWID_MARKER_START("Calc_Sist_Linear_NP");
        //Resolve sistema linear
        eliminacao_Gauss(newt->vetor_b, n, newt->a, newt->c, newt->d);
        retrossubs(newt->vetor_b, newt->delta, n, newt->a, newt->c, newt->d);
        LIKWID_MARKER_STOP("Calc_Sist_Linear_NP");
        
        Tsl = timestamp() - Tsl;

        newt->TslEG += Tsl; //Soma tempo de resolucao do sistema linear

        //Calcula o valor do novo X(i)
        for(int k=0; k<n; k++)
            newt->X[k] += newt->delta[k];

        newt->resultados[newt->num_resultados] = rosenbrock(newt->X, n);
        newt->num_resultados++;
       
        if(norma_delta(newt->delta, n) < f->eps)
            return;
    }
}




void newton_Inexato(funcao_t *f, newtonInex_t *newt){

    double Tsl;

    int n = f->num_var;//n = numero de variaveis

    //resultados = fx(x0)
    newt->resultados[newt->num_resultados] = rosenbrock(newt->X, n);
    newt->num_resultados++;

    for(int i=0; i<f->max_it; i++){

        if(norma_grad(f, newt->X) < f->eps) return;

        LIKWID_MARKER_START("Calc_vet_grad_NI");
        for(int i=0; i<n; i++)//calculo do vetor gradiente para os valores de x
            newt->vetor_b[i] = - rosenbrock_dx(i, newt->X, n);
        LIKWID_MARKER_STOP("Calc_vet_grad_NI");

        LIKWID_MARKER_START("Calc_matriz_hess_NI");
        calc_matriz_coeficientes(newt->X, n, newt->a, newt->d, newt->c);
        LIKWID_MARKER_STOP("Calc_matriz_hess_NI");

        Tsl = timestamp();

        LIKWID_MARKER_START("Calc_Sist_Linear_NI");
        //resolve o sistema linear
        Gauss_Seidel(newt->delta, newt->Xant, newt->vetor_b, n, newt->a, newt->c, newt->d);
        LIKWID_MARKER_STOP("Calc_Sist_Linear_NI");

        Tsl = timestamp() - Tsl;

        newt->TslGS += Tsl; //soma dos tempos do sistema linear

        for(int k=0; k<n; k++)//X(i+1) = X(i) + delta
            newt->X[k] += newt->delta[k];
        

        //resultados = fx(xi)
        newt->resultados[newt->num_resultados] = rosenbrock(newt->X, n);
        newt->num_resultados++;

        if(norma_delta(newt->delta, n) < f->eps)
            return;

    }

}


void executa_metodos(funcao_t *f, newton_t *n1, newtonInex_t *n3){

    n1->TtotalEG = timestamp();

    LIKWID_MARKER_START("Newton_Padrao");
    newton(f, n1);
    LIKWID_MARKER_STOP("Newton_Padrao");

    n1->TtotalEG = timestamp() - n1->TtotalEG;


    n3->TtotalGS = timestamp();

    LIKWID_MARKER_START("Newton_Inexato");
    newton_Inexato(f, n3);
    LIKWID_MARKER_STOP("Newton_Inexato");

    n3->TtotalGS = timestamp() - n3->TtotalGS;

}