Compilar usando: make

use make purge para remover arquivos .o e o executavel

Executar com: /newtonPc < arquivodeentrada (-o arquivodesaida)



O programa newtonPc usa variações do método de newton para encontrar pontos críticos nas funçoes dadas pela entrada,
são três métodos de newton ao todo, cada um deles usa uma estrutura tipo funcao e uma estrutura especifica para cada método,
as estrutura especificas contam com variáveis, vetores e matrizes necessários para a execução do método e mais algumas 
variáveis que guardam o tempo de execução das operações.


Módulos:
	
mathevalUtils 	Utiliza funcoes da lib matheval para calcular derivadas do vetor gradiente e da matriz e Hessiana, 
		calcula também a matriz de coeficientes

MaxNormas	Funcoes max (coluna) e normas(Delta, fx, ...), funcao de troca de linha

metodos		Implementa os metodos de newton e os metodos de resolucao de sistemas lineares

timestamp	Contém a função timestamp(), usada para medir o tempo de execução de trechos de código

utils		Contém funções necessárias como inicialização de estruturas, alocação, desalocação e impressão de resultados 





códigos do programa:

    0 - programa executou corretamente

    1 - Erro ao criar funcao usando libmatheval

    2 - Erro ao alocar memoria para alguma estrutura
