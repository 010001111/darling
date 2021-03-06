#define __SYSCALL_32BIT_ARG_BYTES 24
#include "SYS.h"

#ifndef SYS_recvfrom_nocancel
#error "SYS_recvfrom_nocancel not defined. The header files libsyscall is building against do not match syscalls.master."
#endif

#if defined(__i386__)
__SYSCALL2(__recvfrom_nocancel, recvfrom_nocancel, 6, cerror_nocancel)
#endif

#if defined(__i386__)
	.globl	recvfrom$NOCANCEL$UNIX2003
		recvfrom$NOCANCEL$UNIX2003 = __recvfrom_nocancel
#endif

