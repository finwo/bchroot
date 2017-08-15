#include <dirent.h> // DIR, opendir, readdir, closedir
#include <stdlib.h> // execlp
#include <string.h> // strlen, strcat
#include <unistd.h> // calloc

#define SDIR "/etc/sv"

typedef struct {
  void *next;
  int pid;
  char *cmd;
} Child;

Child *childs = 0;

int main(void) {
  DIR *d = opendir(SDIR);
  if(!d) return 1;
  struct dirent *e;
  Child *child;
  int pid=0, tmp;
  while(e=readdir(d)) {
    if( *e->d_name == '.'    ) continue;
    if( e->d_type  == DT_DIR ) continue;
    child = calloc( 1, sizeof(Child) );
    child->next = childs;
    child->cmd  = calloc( strlen(SDIR) + strlen(e->d_name) + 2, sizeof(char) );
    strcat(child->cmd, SDIR);
    strcat(child->cmd, "/");
    strcat(child->cmd, e->d_name);
    childs=child;
  }
  closedir(d);
  do {
    if(pid<0) return 2;
    child=childs;
    while(child) {
      if(child->pid==pid) {
        tmp=fork();
        if(tmp) {
          child->pid=tmp;
        } else {
          execlp(child->cmd,child->cmd,0);
          break;
        }
      }
      child=child->next;
    }
  } while(pid=wait(NULL));
  return 0;
}
