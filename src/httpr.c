// Based on NWEB
// https://github.com/ankushagarwal/nweb

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int strpos( char *haystack, char *needle ) {
  char *p = strstr(haystack, needle);
  if(p) return p-haystack;
  return -1;
}
char * strap( char *buffer, char *append ) {
  char *out = realloc( buffer, strlen(buffer) + strlen(append) + 1 );
  return strcat( out, append );
}
char * readline() {
  char *buffer = malloc(1);
  char *cb = calloc(2,sizeof(char));
  int c;
  while(c=getchar()) {
    switch(c) {
      case '\r': continue;
      case '\n': free(cb); return buffer;
      default:
        *cb = c;
        buffer = strap( buffer, cb );
        break;
    }
  }
  free(cb);
  return buffer;
}

struct {
  char *ext;
  char *filetype;
} extensions[] = {
  { "htm" , "text/html" },
  { "html", "text/html" },
  {0,0}
};

int main() {
  char *request = readline();
  char *method  = 0;
  char *path    = 0;
  char *version = 0;
  sscanf(request,"%m[A-Z] %m[!-_a-~] HTTP/%m[0-9.]",&method,&path,&version);
  printf("HTTP/1.0 200 OK\r\n\r\n%s\r\n", request);
  printf("METHOD : %s\r\n", method);
  printf("PATH   : %s\r\n", path);
  printf("VERSION: %s\r\n", version);
}
