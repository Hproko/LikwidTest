/*Henrique Prokopenko GRR20186712
 * 	
 * 	Lib de max e normas */




//Funcao que procura o maior valor da coluna em modulo em retorna o indice do maior
int Max_coluna(double **A, int i, int n);


//Troca linhas da matriz A e do vetor b
void troca_linha(double **A, double *b, int i, int ipivo, int n);


//funcao que retorna o maior valor em modulo do vetor delta
double norma_delta(double *delta, int n);


//retorna o maior erro em modulo, usada no metodo Gauss Seidel
double max_erro(double *X, double *Xant, int n);
