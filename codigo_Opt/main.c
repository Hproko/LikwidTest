/*Henrique Prokopenko GRR20186712
    
    Programa principal 
*/


#include <stdio.h>
#include <matheval.h>
#include <stdlib.h>
#include <dirent.h>
#include <unistd.h>
#include <likwid.h>

#include "estrut_funcao.h"
#include "utils.h"
#include "metodos.h"


int main(int argc, char **argv){
    
    char *arq_saida = "";
    
    FILE *arq = stdout;

    funcao_t func;

    newton_t newt;


    newtonInex_t newtonInex;


    LIKWID_MARKER_INIT;

    //Caso o usuario tenha executado com a opcao '-o' o programa escreve o resultado no arquivo passado
    if(getopt(argc, argv, "o:") != -1){
        arq_saida = optarg;
        arq = fopen(arq_saida, "w");

        if(!arq){
            fprintf(stderr, "Nao foi possivel abrir arquivo\n");
            return -3;
        }
    }

    //enquanto receber entradas executa os metodos de newton
    while(entrada_funcoes(&func)){

        inicia_estruturas(&func, &newt, &newtonInex);

        executa_metodos(&func, &newt, &newtonInex);

        imprime_resultados(&func, &newt, &newtonInex, arq);

        desaloca_memoria(&func, &newt, &newtonInex);
    
    }
    
    fclose(arq);
    

    LIKWID_MARKER_CLOSE;
    
    return 0;
    

}
