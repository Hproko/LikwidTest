#!/bin/bash

cd codigo_Opt # compilando codigo otimizado
make
cd ..

cd codigo # compilando codigo nao otimizado
make
cd ..

if [[ -d entradas_rosenbrock ]]
then
	rm -rf entradas_rosenbrock
	./gera_rosenbrock.sh
fi

if ! [[ -d graficos ]]
then
	mkdir graficos
fi


if [[ -d tabelas ]]
then
	rm -r tabelas
fi

mkdir tabelas

if ! [[ -d outputs ]]
then
	mkdir outputs
fi

for N in 10 32 50 64 100 128 200 250 256 300 400 512 600 1000 1024 2000 2048 3000 4096
do
	echo "Calculando rosenbrock $N variaveis"

	echo "TIME and L3"

	echo "n_otimizado"

	likwid-perfctr -C 3 -g L3 -m -o L3TIME.txt ./codigo/newtonPC < entradas_rosenbrock/rosenbrock$N.in -o outputs/out$N.dat 
	
	echo "otimizado"

	likwid-perfctr -C 3 -g L3 -m -o L3TIMEopt.txt ./codigo_Opt/newtonPC < entradas_rosenbrock/rosenbrock$N.in -o outputs/outopt$N.dat

	L3=$(cat L3TIME.txt | grep "L3 bandwidth" | cut -d'|' -f3)

	L3OPT=$(cat L3TIMEopt.txt | grep "L3 bandwidth" | cut -d'|' -f3)

	TIMEOPT=$(cat L3TIMEopt.txt | grep "RDTSC Runtime" | cut -d'|' -f3)

	TIME=$(cat L3TIME.txt | grep "RDTSC Runtime" | cut -d'|' -f3)

	rm L3TIME.txt
	rm L3TIMEopt.txt
	
	echo "$N $(echo $L3 | cut -d' ' -f1) $(echo $L3OPT | cut -d' ' -f1)" >> tabelas/newtonPadraoL3.dat

	echo "$N $(echo $L3 | cut -d' ' -f2) $(echo $L3OPT | cut -d' ' -f2)" >> tabelas/MatrizHessNPL3.dat

	echo "$N $(echo $L3 | cut -d' ' -f3) $(echo $L3OPT | cut -d' ' -f3)" >> tabelas/VetGradNPL3.dat

	echo "$N $(echo $L3 | cut -d' ' -f4) $(echo $L3OPT | cut -d' ' -f4)" >> tabelas/SistLinearNPL3.dat
	
	echo "$N $(echo $L3 | cut -d' ' -f5) $(echo $L3OPT | cut -d' ' -f5)" >> tabelas/newtonInexatoL3.dat
	
	echo "$N $(echo $L3 | cut -d' ' -f6) $(echo $L3OPT | cut -d' ' -f6)" >> tabelas/VetGradNIL3.dat
	
	echo "$N $(echo $L3 | cut -d' ' -f7) $(echo $L3OPT | cut -d' ' -f7)" >> tabelas/MatrizHessNIL3.dat
	
	echo "$N $(echo $L3 | cut -d' ' -f8) $(echo $L3OPT | cut -d' ' -f8)" >> tabelas/SistLinearNIL3.dat


	echo "$N $(echo $TIME | cut -d' ' -f1) $(echo $TIMEOPT | cut -d' ' -f1)" >> tabelas/newtonPadraoTIME.dat

	echo "$N $(echo $TIME | cut -d' ' -f2) $(echo $TIMEOPT | cut -d' ' -f2)" >> tabelas/MatrizHessNPTIME.dat

	echo "$N $(echo $TIME | cut -d' ' -f3) $(echo $TIMEOPT | cut -d' ' -f3)" >> tabelas/VetGradNPTIME.dat

	echo "$N $(echo $TIME | cut -d' ' -f4) $(echo $TIMEOPT | cut -d' ' -f4)" >> tabelas/SistLinearNPTIME.dat
	
	echo "$N $(echo $TIME | cut -d' ' -f5) $(echo $TIMEOPT | cut -d' ' -f5)" >> tabelas/newtonInexatoTIME.dat
	
	echo "$N $(echo $TIME | cut -d' ' -f6) $(echo $TIMEOPT | cut -d' ' -f6)" >> tabelas/VetGradNITIME.dat
	
	echo "$N $(echo $TIME | cut -d' ' -f7) $(echo $TIMEOPT | cut -d' ' -f7)" >> tabelas/MatrizHessNITIME.dat
	
	echo "$N $(echo $TIME | cut -d' ' -f8) $(echo $TIMEOPT | cut -d' ' -f8)" >> tabelas/SistLinearNITIME.dat


	echo "L2 CACHE"

	echo "n otimizado"
	L2CACHE=$(likwid-perfctr -C 3 -g L2CACHE -m ./codigo/newtonPC < entradas_rosenbrock/rosenbrock$N.in -o outputs/out$N.dat | grep "L2 miss ratio" | cut -d'|' -f3)

	echo "otimizado"
	L2CACHEOPT=$(likwid-perfctr -C 3 -g L2CACHE -m ./codigo_Opt/newtonPC < entradas_rosenbrock/rosenbrock$N.in -o outputs/outopt$N.dat | grep "L2 miss ratio" | cut -d'|' -f3)
	
	
	echo "$N $(echo $L2CACHE | cut -d' ' -f1) $(echo $L2CACHEOPT | cut -d' ' -f1)" >> tabelas/newtonPadraoL2.dat

	echo "$N $(echo $L2CACHE | cut -d' ' -f2) $(echo $L2CACHEOPT | cut -d' ' -f2)" >> tabelas/MatrizHessNPL2.dat

	echo "$N $(echo $L2CACHE | cut -d' ' -f3) $(echo $L2CACHEOPT | cut -d' ' -f3)" >> tabelas/VetGradNPL2.dat

	echo "$N $(echo $L2CACHE | cut -d' ' -f4) $(echo $L2CACHEOPT | cut -d' ' -f4)" >> tabelas/SistLinearNPL2.dat
	
	echo "$N $(echo $L2CACHE | cut -d' ' -f5) $(echo $L2CACHEOPT | cut -d' ' -f5)" >> tabelas/newtonInexatoL2.dat
	
	echo "$N $(echo $L2CACHE | cut -d' ' -f6) $(echo $L2CACHEOPT | cut -d' ' -f6)" >> tabelas/VetGradNIL2.dat
	
	echo "$N $(echo $L2CACHE | cut -d' ' -f7) $(echo $L2CACHEOPT | cut -d' ' -f7)" >> tabelas/MatrizHessNIL2.dat
	
	echo "$N $(echo $L2CACHE | cut -d' ' -f8) $(echo $L2CACHEOPT | cut -d' ' -f8)" >> tabelas/SistLinearNIL2.dat
	
	echo "FLOPS"
	
	echo "n otimizado"
	likwid-perfctr -C 3 -g FLOPS_DP -m -o out.txt ./codigo/newtonPC < entradas_rosenbrock/rosenbrock$N.in -o outputs/out$N.dat
	
	echo "otimizado"
	likwid-perfctr -C 3 -g FLOPS_DP -m -o outopt.txt ./codigo_Opt/newtonPC < entradas_rosenbrock/rosenbrock$N.in -o outputs/outopt$N.dat

	FLOPS=$(cat out.txt | grep "MFLOP/s" | cut -d'|' -f3)
	FLOPSOPT=$(cat outopt.txt | grep "MFLOP/s" | cut -d'|' -f3)
	
	rm out.txt
	rm outopt.txt

	echo "$N $(echo $FLOPS | cut -d' ' -f1) $(echo $FLOPS | cut -d' ' -f2) $(echo $FLOPSOPT | cut -d' ' -f1) $(echo $FLOPSOPT | cut -d' ' -f2)" >> tabelas/newtonPadraoFLOP.dat

	echo "$N $(echo $FLOPS | cut -d' ' -f3) $(echo $FLOPS | cut -d' ' -f4) $(echo $FLOPSOPT | cut -d' ' -f3) $(echo $FLOPSOPT | cut -d' ' -f4)" >> tabelas/MatrizHessNPFLOP.dat

	echo "$N $(echo $FLOPS | cut -d' ' -f5) $(echo $FLOPS | cut -d' ' -f6) $(echo $FLOPSOPT | cut -d' ' -f5) $(echo $FLOPSOPT | cut -d' ' -f6)" >> tabelas/VetGradNPFLOP.dat

	echo "$N $(echo $FLOPS | cut -d' ' -f7) $(echo $FLOPS | cut -d' ' -f8) $(echo $FLOPSOPT | cut -d' ' -f7) $(echo $FLOPSOPT | cut -d' ' -f8)" >> tabelas/SistLinearNPFLOP.dat
	
	echo "$N $(echo $FLOPS | cut -d' ' -f9) $(echo $FLOPS | cut -d' ' -f10) $(echo $FLOPSOPT | cut -d' ' -f9) $(echo $FLOPSOPT | cut -d' ' -f10)" >> tabelas/newtonInexatoFLOP.dat
	
	echo "$N $(echo $FLOPS | cut -d' ' -f11) $(echo $FLOPS | cut -d' ' -f12) $(echo $FLOPSOPT | cut -d' ' -f11) $(echo $FLOPSOPT | cut -d' ' -f12)" >> tabelas/VetGradNIFLOP.dat
	
	echo "$N $(echo $FLOPS | cut -d' ' -f13) $(echo $FLOPS | cut -d' ' -f14) $(echo $FLOPSOPT | cut -d' ' -f13) $(echo $FLOPSOPT | cut -d' ' -f14)" >> tabelas/MatrizHessNIFLOP.dat
	
	echo "$N $(echo $FLOPS | cut -d' ' -f15) $(echo $FLOPS | cut -d' ' -f16) $(echo $FLOPSOPT | cut -d' ' -f15) $(echo $FLOPSOPT | cut -d' ' -f16)" >> tabelas/SistLinearNIFLOP.dat



done


./plot.sh


