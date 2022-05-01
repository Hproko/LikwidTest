#Henrique Prokopenko GRR20186712



# Matriz Hessiana NI

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/MatrizHessNIFLOP.png";
            set title "FLOPS matriz hessiana - Newton Inexato";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "FLOPS [MFLOPS/s]"; 
            plot "tabelas/MatrizHessNIFLOP.dat" using 1:2 with linespoints t"FLOPS - não otimizado",
				 "tabelas/MatrizHessNIFLOP.dat" using 1:3 with linespoints t"FLOPS AVX - não otimizado",
				 "tabelas/MatrizHessNIFLOP.dat" using 1:4 with linespoints t"FLOPS - otimizado",
				 "tabelas/MatrizHessNIFLOP.dat" using 1:5 with linespoints t"FLOPS AVX - otimizado"
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/MatrizHessNIL2.png";
            set title "L2 miss ratio matriz hessiana - Newton Inexato";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "L2 miss ratio"; 
            plot "tabelas/MatrizHessNIL2.dat" using 1:2 with linespoints t"L2 - não otimizado",
				 "tabelas/MatrizHessNIL2.dat" using 1:3 with linespoints t"L2 - otimizado"
			
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/MatrizHessNIL3.png";
            set title "L3 bandwidth matriz hessiana - Newton Inexato";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "L3 bandwidth [MBYTES/s]"; 
            plot "tabelas/MatrizHessNIL3.dat" using 1:2 with linespoints t"L3 bandwidth - não otimizado",
				 "tabelas/MatrizHessNIL3.dat" using 1:3 with linespoints t"L3 bandwidth - otimizado"
			
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/MatrizHessNITIME.png";
            set title "Tempo de Execução matriz hessiana - Newton Inexato";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "Tempo [ms]";
			set logscale y 2; 
            plot "tabelas/MatrizHessNITIME.dat" using 1:(1000 * $2) with linespoints t"Tempo - não otimizado",
				 "tabelas/MatrizHessNITIME.dat" using 1:(1000 * $3) with linespoints t"Tempo - otimizado"
			
'

#Matriz Hessiana NP

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/MatrizHessNPFLOP.png";
            set title "FLOPS matriz hessiana - Newton Padrao";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "FLOPS [MFLOPS/s]"; 
            plot "tabelas/MatrizHessNPFLOP.dat" using 1:2 with linespoints t"FLOPS - não otimizado",
				 "tabelas/MatrizHessNPFLOP.dat" using 1:3 with linespoints t"FLOPS AVX - não otimizado",
				 "tabelas/MatrizHessNPFLOP.dat" using 1:4 with linespoints t"FLOPS - otimizado",
				 "tabelas/MatrizHessNPFLOP.dat" using 1:5 with linespoints t"FLOPS AVX - otimizado"
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/MatrizHessNPL2.png";
            set title "L2 miss ratio matriz hessiana - Newton Padrao";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "L2 miss ratio"; 
            plot "tabelas/MatrizHessNPL2.dat" using 1:2 with linespoints t"L2 - não otimizado",
				 "tabelas/MatrizHessNPL2.dat" using 1:3 with linespoints t"L2 - otimizado"
			
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/MatrizHessNPL3.png";
            set title "L3 bandwidth matriz hessiana - Newton Padrao";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "L3 bandwidth [MBYTES/s]"; 
            plot "tabelas/MatrizHessNPL3.dat" using 1:2 with linespoints t"L3 bandwidth - não otimizado",
				 "tabelas/MatrizHessNPL3.dat" using 1:3 with linespoints t"L3 bandwidth - otimizado"
			
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/MatrizHessNPTIME.png";
            set title "Tempo de Execução matriz hessiana - Newton Padrao";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "Tempo [ms]";
			set logscale y 2; 
            plot "tabelas/MatrizHessNPTIME.dat" using 1:(1000 * $2) with linespoints t"Tempo - não otimizado",
				 "tabelas/MatrizHessNPTIME.dat" using 1:(1000 * $3) with linespoints t"Tempo - otimizado"
			
'

#Vetor Gradiente NP
gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/VetGradNPFLOP.png";
            set title "FLOPS Vetor Gradiente - Newton Padrao";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "FLOPS [MFLOPS/s]"; 
            plot "tabelas/VetGradNPFLOP.dat" using 1:2 with linespoints t"FLOPS - não otimizado",
				 "tabelas/VetGradNPFLOP.dat" using 1:3 with linespoints t"FLOPS AVX - não otimizado",
				 "tabelas/VetGradNPFLOP.dat" using 1:4 with linespoints t"FLOPS - otimizado",
				 "tabelas/VetGradNPFLOP.dat" using 1:5 with linespoints t"FLOPS AVX - otimizado"
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/VetGradNPL2.png";
            set title "L2 miss ratio Vetor Gradiente - Newton Padrao";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "L2 miss ratio"; 
            plot "tabelas/VetGradNPL2.dat" using 1:2 with linespoints t"L2 - não otimizado",
				 "tabelas/VetGradNPL2.dat" using 1:3 with linespoints t"L2 - otimizado"
			
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/VetGradNPL3.png";
            set title "L3 bandwidth Vetor Gradiente - Newton Padrao";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "L3 bandwidth [MBYTES/s]"; 
            plot "tabelas/VetGradNPL3.dat" using 1:2 with linespoints t"L3 bandwidth - não otimizado",
				 "tabelas/VetGradNPL3.dat" using 1:3 with linespoints t"L3 bandwidth - otimizado"
			
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/VetGradNPTIME.png";
            set title "Tempo de Execução Vetor Gradiente - Newton Padrao";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "Tempo [ms]";
			set logscale y 2; 
            plot "tabelas/VetGradNPTIME.dat" using 1:(1000 * $2) with linespoints t"Tempo - não otimizado",
				 "tabelas/VetGradNPTIME.dat" using 1:(1000 * $3) with linespoints t"Tempo - otimizado"
			
'
#Vetor Gradiente NI

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/VetGradNIFLOP.png";
            set title "FLOPS Vetor Gradiente - Newton Inexato";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "FLOPS [MFLOPS/s]"; 
            plot "tabelas/VetGradNIFLOP.dat" using 1:2 with linespoints t"FLOPS - não otimizado",
				 "tabelas/VetGradNIFLOP.dat" using 1:3 with linespoints t"FLOPS AVX - não otimizado",
				 "tabelas/VetGradNIFLOP.dat" using 1:4 with linespoints t"FLOPS - otimizado",
				 "tabelas/VetGradNIFLOP.dat" using 1:5 with linespoints t"FLOPS AVX - otimizado"
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/VetGradNIL2.png";
            set title "L2 miss ratio Vetor Gradiente - Newton Inexato";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "L2 miss ratio"; 
            plot "tabelas/VetGradNIL2.dat" using 1:2 with linespoints t"L2 - não otimizado",
				 "tabelas/VetGradNIL2.dat" using 1:3 with linespoints t"L2 - otimizado"
			
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/VetGradNIL3.png";
            set title "L3 bandwidth Vetor Gradiente - Newton Inexato";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "L3 bandwidth [MBYTES/s]"; 
            plot "tabelas/VetGradNIL3.dat" using 1:2 with linespoints t"L3 bandwidth - não otimizado",
				 "tabelas/VetGradNIL3.dat" using 1:3 with linespoints t"L3 bandwidth - otimizado"
			
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/VetGradNITIME.png";
            set title "Tempo de Execução Vetor Gradiente - Newton Inexato";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "Tempo [ms]";
			set logscale y 2; 
            plot "tabelas/VetGradNITIME.dat" using 1:(1000 * $2) with linespoints t"Tempo - não otimizado",
				 "tabelas/VetGradNITIME.dat" using 1:(1000 * $3) with linespoints t"Tempo - otimizado"
			
'

#Sistema Linear NP

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/SistLinearNPFLOP.png";
            set title "FLOPS Sistema Linear - Newton Padrao";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "FLOPS [MFLOPS/s]"; 
            plot "tabelas/SistLinearNPFLOP.dat" using 1:2 with linespoints t"FLOPS - não otimizado",
				 "tabelas/SistLinearNPFLOP.dat" using 1:3 with linespoints t"FLOPS AVX - não otimizado",
				 "tabelas/SistLinearNPFLOP.dat" using 1:4 with linespoints t"FLOPS - otimizado",
				 "tabelas/SistLinearNPFLOP.dat" using 1:5 with linespoints t"FLOPS AVX - otimizado"
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/SistLinearNPL2.png";
            set title "L2 miss ratio Sistema Linear - Newton Padrao";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "L2 miss ratio"; 
            plot "tabelas/SistLinearNPL2.dat" using 1:2 with linespoints t"L2 - não otimizado",
				 "tabelas/SistLinearNPL2.dat" using 1:3 with linespoints t"L2 - otimizado"
			
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/SistLinearNPL3.png";
            set title "L3 bandwidth Sistema Linear - Newton Padrao";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "L3 bandwidth [MBYTES/s]"; 
            plot "tabelas/SistLinearNPL3.dat" using 1:2 with linespoints t"L3 bandwidth - não otimizado",
				 "tabelas/SistLinearNPL3.dat" using 1:3 with linespoints t"L3 bandwidth - otimizado"
			
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/SistLinearNPTIME.png";
            set title "Tempo de Execução Sistema Linear - Newton Padrao";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "Tempo [ms]";
			set logscale y 2; 
            plot "tabelas/SistLinearNPTIME.dat" using 1:(1000 * $2) with linespoints t"Tempo - não otimizado",
				 "tabelas/SistLinearNPTIME.dat" using 1:(1000 * $3) with linespoints t"Tempo - otimizado"
			
'
#Sistema Linear NI

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/SistLinearNIFLOP.png";
            set title "FLOPS Sistema Linear - Newton Inexato";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "FLOPS [MFLOPS/s]"; 
            plot "tabelas/SistLinearNIFLOP.dat" using 1:2 with linespoints t"FLOPS - não otimizado",
				 "tabelas/SistLinearNIFLOP.dat" using 1:3 with linespoints t"FLOPS AVX - não otimizado",
				 "tabelas/SistLinearNIFLOP.dat" using 1:4 with linespoints t"FLOPS - otimizado",
				 "tabelas/SistLinearNIFLOP.dat" using 1:5 with linespoints t"FLOPS AVX - otimizado"
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/SistLinearNIL2.png";
            set title "L2 miss ratio Sistema Linear  - Newton Inexato";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "L2 miss ratio"; 
            plot "tabelas/SistLinearNIL2.dat" using 1:2 with linespoints t"L2 - não otimizado",
				 "tabelas/SistLinearNIL2.dat" using 1:3 with linespoints t"L2 - otimizado"
			
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/SistLinearNIL3.png";
            set title "L3 bandwidth Sistema Linear - Newton Inexato";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "L3 bandwidth [MBYTES/s]"; 
            plot "tabelas/SistLinearNIL3.dat" using 1:2 with linespoints t"L3 bandwidth - não otimizado",
				 "tabelas/SistLinearNIL3.dat" using 1:3 with linespoints t"L3 bandwidth - otimizado"
			
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/SistLinearNITIME.png";
            set title "Tempo de Execução Sistema Linear - Newton Inexato";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "Tempo [ms]";
			set logscale y 2; 
            plot "tabelas/SistLinearNITIME.dat" using 1:(1000 * $2) with linespoints t"Tempo - não otimizado",
				 "tabelas/SistLinearNITIME.dat" using 1:(1000 * $3) with linespoints t"Tempo - otimizado"
			
'



#Newton Padrao

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/newtonPadraoFLOP.png";
            set title "FLOPS - Newton Padrao";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "FLOPS [MFLOPS/s]"; 
            plot "tabelas/newtonPadraoFLOP.dat" using 1:2 with linespoints t"FLOPS - não otimizado",
				 "tabelas/newtonPadraoFLOP.dat" using 1:3 with linespoints t"FLOPS AVX - não otimizado",
				 "tabelas/newtonPadraoFLOP.dat" using 1:4 with linespoints t"FLOPS - otimizado",
				 "tabelas/newtonPadraoFLOP.dat" using 1:5 with linespoints t"FLOPS AVX - otimizado"
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/newtonPadraoL2.png";
            set title "L2 miss ratio - Newton Padrao";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "L2 miss ratio"; 
            plot "tabelas/newtonPadraoL2.dat" using 1:2 with linespoints t"L2 - não otimizado",
				 "tabelas/newtonPadraoL2.dat" using 1:3 with linespoints t"L2 - otimizado"
			
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/newtonPadraoL3.png";
            set title "L3 bandwidth - Newton Padrao";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "L3 bandwidth [MBYTES/s]"; 
            plot "tabelas/newtonPadraoL3.dat" using 1:2 with linespoints t"L3 bandwidth - não otimizado",
				 "tabelas/newtonPadraoL3.dat" using 1:3 with linespoints t"L3 bandwidth - otimizado"
			
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/newtonPadraoTIME.png";
            set title "Tempo de Execução - Newton Padrao";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "Tempo [ms]";
			set logscale y 2; 
            plot "tabelas/newtonPadraoTIME.dat" using 1:(1000 * $2) with linespoints t"Tempo - não otimizado",
				 "tabelas/newtonPadraoTIME.dat" using 1:(1000 * $3) with linespoints t"Tempo - otimizado"
			
'
#Newton Inexato

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/newtonInexatoFLOP.png";
            set title "FLOPS - Newton Inexato";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "FLOPS [MFLOPS/s]"; 
            plot "tabelas/newtonInexatoFLOP.dat" using 1:2 with linespoints t"FLOPS - não otimizado",
				 "tabelas/newtonInexatoFLOP.dat" using 1:3 with linespoints t"FLOPS AVX - não otimizado",
				 "tabelas/newtonInexatoFLOP.dat" using 1:4 with linespoints t"FLOPS - otimizado",
				 "tabelas/newtonInexatoFLOP.dat" using 1:5 with linespoints t"FLOPS AVX - otimizado"
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/newtonInexatoL2.png";
            set title "L2 miss ratio - Newton Inexato";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "L2 miss ratio"; 
            plot "tabelas/newtonInexatoL2.dat" using 1:2 with linespoints t"L2 - não otimizado",
				 "tabelas/newtonInexatoL2.dat" using 1:3 with linespoints t"L2 - otimizado"
			
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/newtonInexatoL3.png";
            set title "L3 bandwidth - Newton Inexato";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "L3 bandwidth [MBYTES/s]"; 
            plot "tabelas/newtonInexatoL3.dat" using 1:2 with linespoints t"L3 bandwidth - não otimizado",
				 "tabelas/newtonInexatoL3.dat" using 1:3 with linespoints t"L3 bandwidth - otimizado"
			
'

gnuplot -e '
            reset;
            set terminal png size 900,600;
            set output "graficos/newtonInexatoTIME.png";
            set title "Tempo de Execução - Newton Inexato";
            set key outside right;
            set xlabel "Numero de variáveis";
            set ylabel "Tempo [ms]";
			set logscale y 2; 
            plot "tabelas/newtonInexatoTIME.dat" using 1:(1000 * $2) with linespoints t"Tempo - não otimizado",
		"tabelas/newtonInexatoTIME.dat" using 1:(1000 * $3) with linespoints t"Tempo - otimizado"
			
'
