/*Henrique Prokopenko GRR20186712

        Biblioteca de funcoes uteis na execucao dos metodos de newton*/





//Recebe as entradas dos programa
//Retorna 1 caso ainda tenha entrada
//Retorna 0 caso chegou ao fim do arquivo
int entrada_funcoes(funcao_t *f);


//Aloca memoria para todas as estruturas do programa
void aloca_memoria(funcao_t *f, newton_t *n, newtonInex_t *n3);

//Desaloca toda memoria alocada incluindo as funcoes da libmatheval
void desaloca_memoria(funcao_t *f, newton_t *n, newtonInex_t *n3);

//Aloca memoria, seta valores e calcula as derivadas do vetor gradiente e da matriz Hessiana
void inicia_estruturas(funcao_t *f, newton_t *n, newtonInex_t *n3);


//Imprime os valores de fx e dos tempos de execucao
void imprime_resultados(funcao_t *f, newton_t *n, newtonInex_t *n3, FILE* arq);

