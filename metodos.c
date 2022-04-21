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


void eliminacao_Gauss(double **A, double *b, int n){


    for(int i=0; i<n; i++){
        
        //pivoteamento parcial
        int ipivo = Max_coluna(A, i, n);
        if(i != ipivo)
            troca_linha(A, b, i, ipivo, n);

        for(int k=i+1; k < n; k++){

            double m = A[k][i] / A[i][i];
            
            A[k][i] = 0.0;
            
            for(int j=i+1; j<n; j++)//subtrai as linhas do sistema
                A[k][j] -= A[i][j] * m;

            b[k] -= b[i] * m;
   
        }       
    }
}

void Gauss_Seidel(newtonInex_t *newt, int n){


    for(int i=0; i<50; i++){

        for(int k=0; k<n; k++)//Guarda o valor do x anterior
            newt->Xant[k] = newt->delta[k];

        for(int k=0; k<n; k++){
            newt->delta[k] = newt->b[k];

            for(int j=0; j<n; j++){ //passa subtraindo para o outro lado da igualdade 

                if(k != j)
                    newt->delta[k] -= newt->delta[j] * newt->matriz_coeficientes[k][j];
            }

            //Por fim divide pelo seu proprio coeficiente
            newt->delta[k] /= newt->matriz_coeficientes[k][k];

        }

        if(max_erro(newt->delta, newt->Xant, n) < EPS)
            return;

    }
}

void fatLU(double **A, double **L, double **U, double *b, int n){


    //Copia matriz A na matriz U
     for(int i=0; i<n; i++)
         for(int j=0; j<n; j++)
             U[i][j] = A[i][j];


    for(int i=0; i<n; i++){
        
        //pivoteamento parcial
        int ipivo = Max_coluna(U, i, n);
        
        if(i != ipivo){
            troca_linha(U, b, i, ipivo, n);
            troca_linha(L, NULL, i, ipivo, n);
        }

        for(int k=i+1; k < n; k++){

            double m = U[k][i] / U[i][i];
            
            L[k][i] = m; //resultado da divisao entra na matriz L

            U[k][i] = 0.0;
            
            for(int j=i+1;j<n;j++)
                U[k][j] -= U[i][j] * m;

            b[k] -= b[i] * m;  
        }       
    }

    //Set 1 na diagonal da matriz L
    for(int i=0; i<n; i++)
        L[i][i] = 1.0;
}


void retrossubs(double **A, double *b, double *x, int n){
	for(int i=n-1; i >= 0; i--){
		//printf("x = %f\n",b[i]);
		
		
		x[i] =  b[i]; //Atribui em x uma variavel independente
		
		for(int j = i+1; j< n; j++){
			x[i] -= A[i][j] * x[j]; // multiplica o x por seu coeficiente e passa subtraindo para o outro lado
		//	printf("x -= %f * %f\n", A[i][j], x[j]);
		}

		x[i] /= A[i][i]; // passa o coeficiente dividindo para o outro lado da equacao
		//printf("x /= %f\n", A[i][i]);
	}
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
        calc_matriz_coeficientes(newt->matriz_coeficientes, f, newt->X, n);
        LIKWID_MARKER_STOP("Calc_Matriz_Hess_NP");

        LIKWID_MARKER_START("Calc_Vet_Grad_NP");
        //Calculo dos elementos do vetor b
        for(int i=0;i<n;i++)
            newt->vetor_b[i] = - rosenbrock_dx(i, newt->X, n);
        LIKWID_MARKER_STOP("Calc_Vet_Grad_NP");
    
        Tsl = timestamp();


        LIKWID_MARKER_START("Calc_Sist_Linear_NP");
        //Resolve sistema linear
        eliminacao_Gauss(newt->matriz_coeficientes, newt->vetor_b, n);
        retrossubs(newt->matriz_coeficientes, newt->vetor_b, newt->delta, n);
        LIKWID_MARKER_STOP("Calc_Sist_Linear_NP");
        
        Tsl = timestamp() - Tsl;

        newt->TslEG += Tsl; //Soma tempo de resolucao do sistema linear

        //Calcula o valor do novo X(i)
        for(int k =0; k<n; k++)
            newt->X[k] += newt->delta[k];

        newt->resultados[newt->num_resultados] = rosenbrock(newt->X, n);
        newt->num_resultados++;
       
        if(norma_delta(newt->delta, n) < f->eps)
            return;
    }
}


void newton_Modificado(funcao_t *f, newtonMod_t *n){

    double Tsl;

    int k = f->num_var;//n = numero de variaveis

    //calcula fx para fx(x0)
    n->resultados[n->num_resultados] = evaluator_evaluate(f->f, f->num_var, f->variaveis, n->X);
    n->num_resultados++;

    for(int i=0; i<f->max_it; i++){

        if(norma_grad(f, n->X) < f->eps) return; 
        
        for(int i=0; i<k; i++)//Calcula o valor das derivadas para os valores de x e guarda no vetor b
            n->b[i] = - evaluator_evaluate(f->vetor_gradiente[i], k, f->variaveis, n->X);


        if(i % n->HESS_STEPS == 0){
            calc_matriz_coeficientes(n->matriz_coeficientes, f, n->X, k);
        }

        Tsl = timestamp();


        //Resolve sistema linear
        fatLU(n->matriz_coeficientes, n->L, n->U, n->b, k);
        retrossubs(n->L, n->b, n->y, k); //Resolve Ly = b
        retrossubs(n->U, n->y, n->delta, k); //Resolve Ux = y


        Tsl = timestamp() - Tsl;

        n->TslLU += Tsl;

        //Calcula o valor do novo X(i)
        for(int i =0; i<k; i++)
            n->X[i] += n->delta[i];

        n->resultados[n->num_resultados] = evaluator_evaluate(f->f, f->num_var, f->variaveis, n->X);       
        n->num_resultados++;

        if(norma_delta(n->delta, k) < f->eps)
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

        
        for(int i=0; i<n; i++)//calculo do vetor gradiente para os valores de x
            newt->b[i] = - rosenbrock_dx(i, newt->X, n);

        calc_matriz_coeficientes(newt->matriz_coeficientes, f, newt->X, n);
        
        Tsl = timestamp();

        //resolve o sistema linear
        Gauss_Seidel(newt, n);

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


void executa_metodos(funcao_t *f, newton_t *n1, newtonMod_t *n2, newtonInex_t *n3){

    n1->TtotalEG = timestamp();

    LIKWID_MARKER_START("Newton_Padrao");
    newton(f, n1);
    LIKWID_MARKER_STOP("Newton_Padrao");

    n1->TtotalEG = timestamp() - n1->TtotalEG;

    // n2->TtotalLU = timestamp();

    // newton_Modificado(f, n2);

    // n2->TtotalLU = timestamp() - n2->TtotalLU;

    n3->TtotalGS = timestamp();

    newton_Inexato(f, n3);

    n3->TtotalGS = timestamp() - n3->TtotalGS;

}