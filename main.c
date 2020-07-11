
#include "entry.h"

#define __noreturn __attribute__((__noreturn__))

int sched_yield();
int write(int fd, void *buf, int count);
long syscall(long number, ...);
__noreturn void _exit(int __status);

int main() {
    int ret = sched_yield();
    short tid = syscall(__NR_gettid);
    // max 65536
    int i = 0, t = tid;
    int s[5];
    while(t != 0) {
        i++; s[i] = t % 10; t = t /10;
    }

    char buf[2 + i];
    buf[0] = 0x30 + ret;
    buf[1] = '-';
    int j = 0;
    while(i >= 0) {
        buf[2 + j++] = 0x30 + s[i--];
    }
    write(1, buf, sizeof(buf));

    //syscall(__NR_write, 1, "abc", 3);
    return 0;
}

void _start() {
    main();
    _exit(-1);
}
