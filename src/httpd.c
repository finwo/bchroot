#include <unistd.h>
void main(void){
  char *args[] = {"tcpd","8080","httpr","/var/www"};
  execvp(*args,args);
}
