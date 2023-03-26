gcc mi_fa-alumno.s -c
gcc mi_mutex-alumno.s -c 
gcc mi_mutex_sleep-alumno.s -c 
g++ ej3.cpp mi_fa-alumno.o mi_mutex-alumno.o -o ej3 -lpthread
g++ ej3.cpp mi_fa-alumno.o mi_mutex_sleep-alumno.o -o ej3_sleep -lpthread
