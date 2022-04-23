/* Henrique Prokopenko GRR20186712

    Biblioteca de metodos de newton e metodos de resolucao de sistemas lineares
*/

//Eliminacao de Gauss realiza a triangularizaçao do sistema linear
//Utiliza pivoteamento parcial
//A = matriz de coeficientes
//b = vetor b
//n é a quantidade de variaveis
void eliminacao_Gauss(double **A, double *b, int n);


//Metodos de gauss seidel resolve o sistema linear atraves de iteracoes 
//Isolando as variaveis em cada equacao do sistema linear
//A funcao recebe um ponteiro para um newtonInex_t e o numero de variaveis do sistema
void Gauss_Seidel(double * restrict delta, double * restrict Xant, double * restrict b, double * restrict Mcoeficientes, int n);


//fatLU recebe uma matriz A e realiza a fatoracao e guarda as matrizes resultantes em L e U
//Tambem utiliza pivoteamento parcial
//A = matriz de coeficientes | b = vetor b | n = numero de variaveis do sistema
void fatLU(double **A, double **L, double **U, double *b, int n);


//A retrossubs resolve sistemas triangularizados e guarda o resultado no vetor x
//A = matriz de coeficientes | b = vetor b | n = numero de variaveis do sistema
void retrossubs(double **A, double *b, double *x, int n);


//Metodo de newton que resolve os sistemas pela eliminacao de gauss
void newton(funcao_t *f, newton_t *newt);


//Metodo de newton que resolve os sistemas pela fatoracao LU
void newton_Modificado(funcao_t *f, newtonMod_t *n);


//Metodo de newton que resolve os sistemas pelo metodo Gauss-Seidel
void newton_Inexato(funcao_t *f, newtonInex_t *n);


//executa todos os metodos de newton e calcula os tempos de execucao de cada um
void executa_metodos(funcao_t *f, newton_t *n1, newtonMod_t *n2, newtonInex_t *n3);