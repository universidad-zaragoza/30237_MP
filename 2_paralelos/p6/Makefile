CC=gcc

# floating point precision (PRECISION) 
#    0 corresponds to single precision
#    1 corresponds to double precision
FLAGS=-std=gnu99 -g -O3 -DPRECISION=0 -DLEN=32768
# FLAGS=-std=c99 -g -O3 -DPRECISION=0 -DLEN=32768  # -Ofast -mtune=native
LIBS=-lm

GCC_FLAGS=-march=native -Wall -Wextra -Wshadow
#GCC_FLAGS=-mavx
#GCC_FLAGS=-Q -v -mavx
VEC_REPORT_FLAG=-fopt-info-vec-optimized
# VEC_REPORT_FLAG=-fopt-info-vec-optimized -fopt-info-vec-missed
NOVECTOR_FLAG=-fno-tree-vectorize

src=axpby.c

all: $(src)

dummy.o: dummy.c
	$(CC) $(FLAGS)  -c dummy.c -o dummy.o 

# gcc: -ftree-vectorize se activa con -O3
# -march=native
# nota: las compilaciones con -fno-tree-vectorize no generan informe

$(src): dummy.o $(src).c
	$(CC) $(FLAGS) $(GCC_FLAGS) $(VEC_REPORT_FLAG) dummy.o $(src).c $(LIBS) -o $(src)
#	$(CC) $(FLAGS) $(GCC_FLAGS) $(VEC_REPORT_FLAG) $(NOVECTOR_FLAG) dummy.o s001.c $(LIBS) -o s001.pt.noavx

clean:
	rm -rf *.o $(src)

