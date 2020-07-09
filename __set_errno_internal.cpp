
#define __LIBC_HIDDEN__ __attribute__((visibility("hidden")))

int errno = 0;

extern "C" __LIBC_HIDDEN__ long __set_errno_internal(int n) {
    errno = n;
    return -1;
}
