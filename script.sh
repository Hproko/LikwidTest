#!/bin/bash



if ! [[ -d tabelas ]]
then
	mkdir tabelas
fi

if ! [[ -d outputs ]]
then
	mkdir outputs
fi

for N in 10 32 #50 64 100 128 200 250 256 300 400 512 600 1000 1024 2000 2048 3000 4096
do
	echo "Calculando rosenbrock $N variaveis"

	L3=$(likwid-perfctr -C 3 -g L3 -m ./newtonPC < entradas_rosenbrock/rosenbrock$N.in -o outputs/out$N.dat | grep "L3 bandwidth" | cut -d'|' -f3)
	
	echo $L3
done
