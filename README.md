Henrique Prokopenko GRR2086712


Trabalho para a disciplina de introdução a computação científica


INTRUÇÕES

Lembre-se de definir as variáveis de ambiente LIKWID_INCLUDE e LIKWID_LIB 
    LIKWID_INCLUDE="PathToLikwid/include"
    LIKWID_LIB="PathToLikwid/lib"



Lembre-se de FIXAR a frequência do processador com:
    echo "performance" > /sys/devices/system/cpu/cpufreq/policy3/scaling_governor

Após o fim da execução retornar a frequência original com:
     echo "powersave" > /sys/devices/system/cpu/cpufreq/policy3/scaling_governor



Para compilar basta acessar o diretorio codigo/ e codigo_Opt/ - compilar com make
ou basta executar ./script.sh que ele compila os dois códigos e inicia os experimentos

o script script.sh 
    - compila os códigos
    - cria os diretórios necessários
    - gera os arquivos necessários para a execução
    - coleta todos os resultados do likwid
    - chama o script plot.sh para gerar os gráficos

    * As saídas dos programas são guardadas no diretório outputs
    * Os gráficos são guardados no diretório gráficos
    * Os dados coletados do likwid são guardados no diretório tabelas
    * O script gera_rosebrock.sh cria um arquivo para cada função de rosenbrock

