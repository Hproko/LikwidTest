/*Henrique Prokopenko GRR20186712

        estruturas usadas nas execucoes dos metodos de newton

*/

#define EPS 0.000001


typedef struct{

    void *f;   //funcao 
    
    int num_var; //numero de variaveis

    char func[1000000]; //String da funcao

    double *aprox_inicial; //vetor de aproximacoes iniciais

    double eps; //epsilon

    int max_it; //maximo de iteracoes

    char **variaveis;// Nome das variaveis da funcao

    void **vetor_gradiente; //vetor de funcoes do vetor gradiente

    void ***Hessiana; //matriz de funcoes da matriz Hessiana

}funcao_t;


typedef struct{

    double *delta; //vetor do delta de x
    
    double *vetor_b; //vetor de variaveis independentes

    double **matriz_coeficientes; 

    double *X; //vetor de valores de x (x1, x2, x3, ..., xn)

    double *resultados; //vetor de resultados

    int num_resultados; //qntd de resultados obtidos

    double TtotalEG; //tempo total do metodo de newton

    double TderivadasEG; //tempo para calcular vetor gradiente e matriz Hessiana

    double TslEG; //tempo para resolver todos os sistemas lineares

}newton_t;


typedef struct{

    double **matriz_coeficientes;

    double **L; //matriz L

    double **U; //matriz U

    double *b; //vetor de variaveis independentes

    double *y; //vetor de U * delta = y

    double *delta; //vetor do delta de x

    double *X; //vetor dos valores de x (x1, x2, x3, ..., xn)

    double *resultados; //vetor de resultados

    int num_resultados; //qntd de resultados obtidos

    int HESS_STEPS; //HESS_STEPS é igual ao número de variáveis (Fatoracao LU é feita a cada HESS_STEPS)

    double TtotalLU; //tempo total do metodo de newton inexato

    double TderivadasLU; //tempo de calcular vetor gradiente e matriz Hessiana

    double TslLU; //tempo para resolver todos os sistemas lineares
    
}newtonMod_t;


typedef struct{

    double **matriz_coeficientes;

    double *delta; 

    double *b; //variaveis independentes

    double *X; //valores de x

    double *Xant; //guarda o valor do delta anterior para o metodo de gauss seidel
     
    double *resultados; //vetor de resultados

    int num_resultados; //qntd de resultados

    double TtotalGS; //tempo total do metodo newton inexato

    double TderivadasGS; //tempo de calcular vetor gradiente e matriz Hessiana

    double TslGS; //tempo para resolver todos os sistemas lineares 

}newtonInex_t;