/* Henrique Prokopenko GRR20186712

        Biblioteca que utiliza funcoes da lib matheval*/




//Calcula as derivadas que sao guardadas como funcoes no vetor gradiente
void Calcula_Vgradiente(funcao_t *f);

//Calcula as derivadas que sao guardadas como funcoes na matriz Hessiana
void Calcula_Hessiana(funcao_t *f);

//Calcula a norma de fx    /  A funcao retorna o maior valor em modulo
double norma_grad(funcao_t *f, double *v);

//Utilizando funcao da lib matheval calcula o valor das funcoes da matriz Hessiana e guarda na matriz de coeficientes
void calc_matriz_coeficientes(double **A, funcao_t *f, double *v, int n);