//En este caso conseguimos que falle, como lo arreglariamos?
#include <atomic>
#include <thread>
#include <iostream>

std::atomic<int> x{0}, y{0};
int r1, r2;

void thread1() {
   x.store(1, std::memory_order_relaxed);
   r1 = y.load(std::memory_order_relaxed);
}

void thread2() {
   y.store(1, std::memory_order_relaxed);
   r2 = x.load(std::memory_order_relaxed);
}

int main() {
   for (int i = 0; i < 1000000; ++i) {
      x = 0; y = 0; r1 = r2 = -1;

      std::thread t1(thread1), t2(thread2);
      t1.join(); t2.join();

      if (r1 == 0 && r2 == 0) {
         std::cout << "Reordenamiento visible en iteración " << i << "\n";
         break;
      }
   }
}
