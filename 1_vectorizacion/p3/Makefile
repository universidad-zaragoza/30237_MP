# Makefile para compilar los distintos fuentes de la práctica.
# To compile the program, just type make in the sample directory.
# 

CC=gcc
FLAGS=-std=c11 -g -O3 -march=native -Wall -Wextra -Wshadow
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

all: test_RGB2YCbCr
#all: test_rgb2gray image_info

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

RGB2YCbCr.o: RGB2YCbCr.c | $(REPDIR) $(ASMDIR)
	$(CC)  $(FLAGS)  $(REPORT_FLAGS)  -c $<  -o $@ \
      -Wa,-adghln=$(ASMDIR)/RGB2YCbCr.$(CC).s \
	  2>&1 | tee $(REPDIR)/RGB2YCbCr.$(CC).report.txt

misc.o: misc.c | $(REPDIR) $(ASMDIR)
	$(CC)  $(FLAGS)  $(REPORT_FLAGS)  -c $<  -o $@ \
      -Wa,-adghln=$(ASMDIR)/misc.$(CC).s \
	  2>&1 | tee $(REPDIR)/misc.$(CC).report.txt

# $^: names of all the prerequisites
# http://www.gnu.org/software/make/manual/make.html#Automatic-Variables
# test_sepia_filter: sepia_filter.o saturation.o scale.o misc.o  jpeg_handler.o dummy.o test_sepia_filter.c
test_RGB2YCbCr: RGB2YCbCr.o misc.o jpeg_handler.o dummy.o test_RGB2YCbCr.c 
	$(CC) $(FLAGS)  $^  -no-pie -Llib -ljpeg -lm -o $@

image_info: misc.o jpeg_handler.o dummy.o image_info.c
	$(CC) $(FLAGS)  $^  -Llib -ljpeg -lm -o $@

clean:
	rm -rf *.o test_RGB2YCbCr
