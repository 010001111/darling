#define __SYSCALL_32BIT_ARG_BYTES 20
#include "SYS.h"

#ifndef SYS_psynch_rw_downgrade
#error "SYS_psynch_rw_downgrade not defined. The header files libsyscall is building against do not match syscalls.master."
#endif

#if defined(__i386__)
__SYSCALL2(__psynch_rw_downgrade, psynch_rw_downgrade, 5, cerror_nocancel)
#endif

