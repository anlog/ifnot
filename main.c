
#include "entry.h"

#define __noreturn __attribute__((__noreturn__))

int sched_yield();
int write(int fd, void *buf, int count);
long syscall(long number, ...);
__noreturn void _exit(int __status);

int main() {
    int ret = sched_yield();
    char buf[3];
    buf[0] = '=';
    buf[1] = 0x30 + ret;
    buf[2] = '\0';
    write(1, buf, sizeof(buf));

    //syscall(__NR_write, 1, "abc", 3);
    return 0;
}

void _start() {
    main();
    _exit(-1);
}
