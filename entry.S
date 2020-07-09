#include "entry.h"

#ifndef ALIAS_SYMBOL
# define ALIAS_SYMBOL(alias, original) \
    .globl alias; \
    .equ alias, original
#endif

ENTRY(syscall)
    # All arguments are passed via registers.
    # (Not all will be valid, depending on the syscall.)
    mov     %edi, %eax
    mov     %rsi, %rdi
    mov     %rdx, %rsi
    mov     %rcx, %rdx
    mov     %r8,  %r10
    mov     %r9,  %r8
    mov     8(%rsp), %r9

    # Make the system call.
    syscall
    cmpq    $-MAX_ERRNO, %rax
    jb      1f
    negl    %eax
    movl    %eax, %edi
    call    __set_errno_internal
1:
    ret
END(syscall)

ENTRY(sched_yield)
    movl    $__NR_sched_yield, %eax
    syscall
    cmpq    $-MAX_ERRNO, %rax
    jb      1f
    negl    %eax
    movl    %eax, %edi
    call    __set_errno_internal
1:
    ret
END(sched_yield)

ENTRY(write)
    movl    $__NR_write, %eax
    syscall
    cmpq    $-MAX_ERRNO, %rax
    jb      1f
    negl    %eax
    movl    %eax, %edi
    call    __set_errno_internal
1:
    ret
END(write)

ENTRY(_exit)
    movl    $__NR_exit_group, %eax
    syscall
    cmpq    $-MAX_ERRNO, %rax
    jb      1f
    negl    %eax
    movl    %eax, %edi
    call    __set_errno_internal
1:
    ret
END(_exit)

ALIAS_SYMBOL(_Exit, _exit)

ENTRY(__exit)
    movl    $__NR_exit, %eax
    syscall
    cmpq    $-MAX_ERRNO, %rax
    jb      1f
    negl    %eax
    movl    %eax, %edi
    call    __set_errno_internal
1:
    ret
END(__exit)
.hidden __exit

