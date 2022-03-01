# Makefile para compilar los distintos fuentes de la práctica.
# To compile the program, just type make in the sample directory.
# 

CC=gcc
FLAGS=-std=gnu17 -g -O3 -ffast-math -march=native -Wall -Wextra -Wshadow -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-parameter
# FLAGS=-std=c99
REPORT_FLAGS=-fopt-info-vec-optimized
# REPORT_FLAGS=-fopt-info-vec-all -fopt-info-loop-optimized
# REPORT_FLAGS=-fopt-info-vec-optimized

#
# The -ljpeg flag is used to tell the compiler to use the libjpeg library to compile and link
# your program against. If omitted, you will get a few "unresolved symbol" errors.
#
# 

# $<: name of the first prerequisite
# $@: file name of the target of the rule
# http://www.gnu.org/software/make/manual/make.html#Automatic-Variables

all: test_rgb2gray

#
# dependency to force the creation of $(REPDIR) and $(ASMDIR) directories
# @: suppress the echoing of the command
#
REPDIR := reports
$(REPDIR):
	@mkdir -p $@	

ASMDIR := assembler
$(ASMDIR):
	@mkdir -p $@	

jpeg_handler.o: jpeg_handler.c
	$(CC) $(FLAGS)  -c $<  -o $@ 

dummy.o: dummy.c
	$(CC) $(FLAGS)  -c $< -o $@ 

rgb2gray.o: rgb2gray.c | $(REPDIR) $(ASMDIR)
	$(CC)  $(FLAGS)  $(REPORT_FLAGS)  -c $<  -o $@ \
      -Wa,-adghln=$(ASMDIR)/rgb2gray.$(CC).s \
	  2>&1 | tee $(REPDIR)/rgb2gray.$(CC).report.txt

misc.o: misc.c | $(REPDIR) $(ASMDIR)
	$(CC)  $(FLAGS)  $(REPORT_FLAGS)  -c $<  -o $@ \
      -Wa,-adghln=$(ASMDIR)/misc.$(CC).s \
	  2>&1 | tee $(REPDIR)/misc.$(CC).report.txt

# $^: names of all the prerequisites
# http://www.gnu.org/software/make/manual/make.html#Automatic-Variables
test_rgb2gray: rgb2gray.o misc.o jpeg_handler.o dummy.o test_rgb2gray.c 
	$(CC) $(FLAGS)  $^  -no-pie -Llib -ljpeg -lm -o $@

clean:
	rm -rf *.o test_rgb2gray
