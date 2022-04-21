#!/bin/bash



if ! [[ -d tabelas ]]
then
	mkdir tabelas
fi

if ! [[ -d outputs ]]
then
	mkdir outputs
fi

for N in 10 32 50 64 100 128 200 250 256 300 400 512 600 1000 1024 2000 2048 3000 4096
do
	echo "Calculando rosenbrock $N variaveis"

	L3=$(likwid-perfctr -C 3 -g L3 -m ./newtonPC < entradas_rosenbrock/rosenbrock$N.in -o outputs/out$N.dat | grep "L3 bandwidth" | cut -d'|' -f3)
	
	echo "$N $(echo $L3 | cut -d' ' -f1)" >> tabelas/newtonPadraoL3.dat

	echo "$N $(echo $L3 | cut -d' ' -f2)" >> tabelas/MatrizHessNPL3.dat

	echo "$N $(echo $L3 | cut -d' ' -f3)" >> tabelas/VetGradNPL3.dat

	echo "$N $(echo $L3 | cut -d' ' -f4)" >> tabelas/SistLinearNPL3.dat
	
	echo "$N $(echo $L3 | cut -d' ' -f5)" >> tabelas/newtonInexatoL3.dat
	
	echo "$N $(echo $L3 | cut -d' ' -f6)" >> tabelas/VetGradNIL3.dat
	
	echo "$N $(echo $L3 | cut -d' ' -f7)" >> tabelas/MatrizHessNIL3.dat
	
	echo "$N $(echo $L3 | cut -d' ' -f8)" >> tabelas/SistLinearNIL3.dat

	L2CACHE=$(likwid-perfctr -C 3 -g L2CACHE -m ./newtonPC < entradas_rosenbrock/rosenbrock$N.in -o outputs/out$N.dat | grep "L2 miss ratio" | cut -d'|' -f3)


	TIME=$(likwid-perfctr -C 3 -g L3 -m ./newtonPC < entradas_rosenbrock/rosenbrock$N.in -o outputs/out$N.dat| grep "RDTSC Runtime" | cut -d'|' -f3)

	

	likwid-perfctr -C 3 -g FLOPS_DP -m -o out.txt ./newtonPC < entradas_rosenbrock/rosenbrock$N.in -o outputs/out$N.dat

	FLOPS=$(cat out.txt | grep "MFLOP/s" | cut -d'|' -f3)
	
	rm out.txt


done
