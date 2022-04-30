/* Henrique Prokopenko GRR20186712

        Implementacao da biblioteca de utilitarios para execucao dos metodos de newton */



#include <matheval.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

#include "estrut_funcao.h"
#include "mathevalUtils.h"
#include "timestamp.h"






//recebe string de erro e sai do programa retornando 2
void sem_memoria(char *s){
    fprintf(stderr, "Erro ao alocar memória para %s\n", s);
    exit(2);
}


int entrada_funcoes(funcao_t *f){

    if(scanf("%d", &f->num_var) == EOF) //numero de variaveis
        return 0;

    if(scanf("%s%*c", f->func) == EOF) //recebe string da funcao de entrada
        return 0;

    f->aprox_inicial = malloc(f->num_var * sizeof(double));
    if(!f->aprox_inicial) sem_memoria("vetor aproximacao inicial");

    for(int i=0; i<f->num_var; i++){
        if(scanf("%lf", &f->aprox_inicial[i]) == EOF){ //valores de aproximacao inicial
            free(f->aprox_inicial);
            return 0;
        }
    }
    if(scanf("%lf", &f->eps) == EOF){ //epsilon
        free(f->aprox_inicial);
        return 0;
    }

    if(scanf("%d", &f->max_it) == EOF){ //num maximo de iteracoes
        free(f->aprox_inicial);
        return 0;
    }

    return 1;

}


void aloca_memoria(funcao_t *f, newton_t *n, newtonInex_t *n3){

    int k = f->num_var; 
    n->a = (double *)malloc((k-1) * sizeof(double));
    if(!n->a) sem_memoria("vetor a newton_t");

    n->c = (double *)malloc((k-1) * sizeof(double));
    if(!n->c) sem_memoria("vetor c newton_t");

    n->d = (double *)malloc(k * sizeof(double));
    if(!n->d)sem_memoria("vetor d newton_t");

    n->delta = (double *)malloc( k * sizeof(double));
    if(!n->delta)sem_memoria("vetor delta newton_t");

    n->resultados = (double *)malloc((f->max_it+1) * sizeof(double));
    if(!n->resultados) sem_memoria("vetor resultado newton_t");

    n->vetor_b = (double *)malloc(k * sizeof(double));
    if(!n->vetor_b)sem_memoria("vetor b newton_t");

    n->X = (double *)malloc(k * sizeof(double));
    if(!n->X) sem_memoria("vetor X newton_t");
   


    n3->a = (double *)malloc((k-1) * sizeof(double));
    if(!n3->a) sem_memoria("vetor a newtonInex");

    n3->c = (double *)malloc((k-1) * sizeof(double));
    if(!n3->c) sem_memoria("vetor c newtonInex");

    n3->d = (double *)malloc(k * sizeof(double));
    if(!n3->d)sem_memoria("vetor d newtonInex");

    n3->delta= (double *)malloc(k * sizeof(double));
    if(!n3->delta)sem_memoria("vetor delta newtonInex");

    n3->resultados = (double *)malloc((f->max_it+1)*sizeof(double));
    if(!n3->resultados)sem_memoria("vetor resultados newtonInex");

    n3->vetor_b = (double *)malloc(k*sizeof(double));
    if(!n3->vetor_b)sem_memoria("vetor b newtonInex");

    n3->X = (double *)malloc(k*sizeof(double));
    if(!n3->X)sem_memoria("vetor X newtonInex");

    n3->Xant = (double *)malloc(k*sizeof(double));
    if(!n3->Xant)sem_memoria("vetor Xant newtonInex");
}


void desaloca_memoria(funcao_t *f, newton_t *n, newtonInex_t *n3){

    free(f->aprox_inicial);
    
    free(n->a);
    free(n->c);
    free(n->d);
    free(n->delta);
    free(n->resultados);
    free(n->vetor_b);
    free(n->X);

    free(n3->a);
    free(n3->c);
    free(n3->d);
    free(n3->delta);
    free(n3->resultados);
    free(n3->vetor_b);
    free(n3->X);
    free(n3->Xant);


}


void inicia_estruturas(funcao_t *f, newton_t *n, newtonInex_t *n3){

    aloca_memoria(f, n, n3);

    // n2->HESS_STEPS = f->num_var;

    for(int i=0; i<f->num_var; i++){
        n->X[i] = f->aprox_inicial[i];
        // n2->X[i] = f->aprox_inicial[i];
        n3->X[i] = f->aprox_inicial[i];
    }

    n->num_resultados = 0;
    // n2->num_resultados = 0;
    n3->num_resultados = 0;


    n->TslEG = 0;
    // n2->TslLU = 0;
    n3->TslGS = 0;


}


void printa_valores(double *v, int i, int n, FILE* arq){

    if(i < n){
        if(isnan(v[i]) || isinf(v[i]))
            fprintf(arq, "%1.14e\t\t\t| ", v[i]);
        
        else   
            fprintf(arq, "%1.14e\t| ", v[i]);
        }
        else
            fprintf(arq, "\t\t\t| ");

}

void imprime_resultados(funcao_t *f, newton_t *n, newtonInex_t *n3, FILE *arq){



    fprintf(arq, "%d\n", f->num_var);

    fprintf(arq, "%s\n", f->func);

    fprintf(arq, "#Iteração \t| Newton Padrão \t| Newton Inexato\n");

    int k = f->max_it + 1;

    for(int i=0; i<k; i++){

        if(i >= n->num_resultados &&  i >= n3->num_resultados) break;

        fprintf(arq, "%d \t\t| ", i);

        printa_valores(n->resultados, i, n->num_resultados, arq);
        // printa_valores(n2->resultados, i, n2->num_resultados, arq);
        printa_valores(n3->resultados, i, n3->num_resultados, arq);
        fprintf(arq, "\n");

    }

    // imprimir os tempos
    fprintf(arq, "Tempo total \t| %1.14e\t| %1.14e\t|\n", n->TtotalEG, n3->TtotalGS);
    //fprintf(arq, "Tempo derivadas | %1.14e\t| %1.14e\t|\n", n->TderivadasEG, n3->TderivadasGS);
    fprintf(arq, "Tempo SL \t| %1.14e\t| %1.14e\t|\n", n->TslEG, n3->TslGS);

    fprintf(arq, "#\n\n");
}