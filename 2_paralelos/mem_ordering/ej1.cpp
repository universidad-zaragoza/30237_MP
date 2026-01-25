// Analizar el codigo. Teniendo en cuenta que tenemos un modelo de consistencia secuencial relajado en ARM, la ejecución podria fallar qunque yo no lo he conseguidoi por muchas veces que lo he intentado. si alguien lo consigue .... g++ -O0 -std=c++2a ej1.cpp -o ej1 -lpthread (orden para compilar)
// Ahora, vuelve a compilar el codigo con la siguiente orden g++ -O3 -std=c++2a ej1.cpp -o ej1 -lpthread. Cuando ejecutamos el comando, vemos que la ejecucion se bloquea. Que ocurre? Pista: visualiza el codigo ensamblador generado para el thread2.
// Ahora, cambia el codigo para que la varibale c sea declarada como una variable atomica. Que ocurre ahora? y el codigo ensamblador?
// -g -S -fverbose-asm
#include <thread>
#include <iostream>
#include <unistd.h>
#include <cstdlib>
#include <vector>
#include <atomic>

const int SIZE = 1024;
std::vector<int> v(SIZE);

int a=0,b=0;
int c=0;
//std::atomic<int> c{0};
int d=0,e=0;

void thread1() {
    //usleep(3000); //sleep time in microseconds

    for(int i = 0; i < SIZE; i++){
        v[i] = std::rand()%1001;
    }

    a=1;
    b=2;
    d=4;
    e=5;
    
    c = 1;
    //c.store(1, std::memory_order_seq_cst);

}

void thread2() {
    int la,lb,lc,ld,le;

    while (c!=1);
    //while (c.load(std::memory_order_seq_cst)!=1);

    la=a;
    lb=b;
    lc=c;
    ld=d;
    le=e;

    std::cout << "Thread 2! (después)la: " << la << ", lb: " << lb << ", lc: " << lc << ", ld: " <<ld << ", le: " << le << std::endl;
}

int main() {
    //std::cout << "a: " << a << ", b: " << b << ", c: " << c << ", d: " << d << ", e: " << e << std::endl;
   
    std::srand(7);
    for (unsigned int i = 0; i < 100; i++){
        a=0;
        b=0;
        c=0;
        d=0;
        e=0;

        std::thread t2(thread2);
        std::thread t1(thread1);

        t1.join();
        t2.join();
    
        if (!((a==1)&&(b==2)&&(c==1)&&(d==4)&&(e==5))){
            std::cout << "Reordenamiento visible " << v[503] << std::endl;
            break;
        }
    } 
    
    return 0;
}

