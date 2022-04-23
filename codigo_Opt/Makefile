CFLAGS = -I/usr/include -O3 -mavx -march=native -DLIKWID_PERFMON -I${LIKWID_INCLUDE}
LFLAGS = -lm -L/usr/lib -lmatheval -L${LIKWID_LIB} -llikwid -lm

OBJS = utils.o metodos.o mathevalUtils.o  \
	timestamp.o MaxNormas.o main.o \
	Rosenbrock.o

             

all: newtonPC



newtonPC: $(OBJS)
	  gcc $(OBJS) -o newtonPC $(LFLAGS) 



main.o: main.c   
	gcc -c main.c $(CFLAGS)

utils.o: utils.c utils.h
	gcc -c utils.c $(CFLAGS)

metodos.o: metodos.c metodos.h
	gcc -c metodos.c $(CFLAGS)

mathevalUtils.o: mathevalUtils.c mathevalUtils.h
	gcc -c mathevalUtils.c $(CFLAGS)


timestamp.o: timestamp.c timestamp.h
	gcc -c timestamp.c $(CFLAGS)


MaxNormas.o: MaxNormas.c MaxNormas.h
	gcc -c MaxNormas.c $(CFLAGS)

Rosenbrock.o: Rosenbrock.c Rosenbrock.h
	gcc -c Rosenbrock.c $(CFLAGS)


clean:   
	rm -f *.o *.out 


purge : clean
	rm -f newtonPC
