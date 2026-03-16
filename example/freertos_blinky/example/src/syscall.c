#include <sys/types.h>
#include <sys/stat.h>
#include <errno.h>

extern char _pvHeapStart; // from linker script

caddr_t _sbrk(int incr) {
    static char *heap_end = NULL;
    if (heap_end == NULL) heap_end = &_pvHeapStart;
    char *prev_heap_end = heap_end;
    heap_end += incr;
    return (caddr_t)prev_heap_end;
}

int _getpid(void) { return 1; }
int _kill(int pid, int sig) { errno = EINVAL; return -1; }
void _exit(int status) { for(;;); }
int _write(int fd, char *buf, int len) { return len; }
int _read(int fd, char *buf, int len) { return 0; }
int _close(int fd) { return -1; }
int _fstat(int fd, struct stat *st) { st->st_mode = S_IFCHR; return 0; }
int _isatty(int fd) { return 1; }
int _lseek(int fd, int offset, int whence) { return 0; }