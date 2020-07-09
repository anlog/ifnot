
#include <asm/unistd.h>
#include <stdio.h>
#include <unistd.h>

int add(int a, int b) {
    return a+b;
}

int main() {
#ifdef __NR_sched_yield
  printf("sched_yield: %ld\n", syscall(__NR_sched_yield));
#endif
  return 0;
}
