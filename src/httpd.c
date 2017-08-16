#include <unistd.h>
void main(void){
  char *args[] = {"80","httpr","/var/www"};
  execvp("tcpd",args );
}