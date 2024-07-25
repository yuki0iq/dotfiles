#include <errno.h>
#include <linux/prctl.h>
#include <signal.h>
#include <sys/prctl.h>
#include <unistd.h>

extern char **environ;

int main(int argc, char **argv) {
    prctl(PR_SET_PDEATHSIG, SIGKILL);
    execve(argv[1], argv + 1, environ);
    return errno;
}
