#include <stdio.h>
void main( int argc, char **argv ) {
  int i;
  for(i=1;i<argc;i++) {
    if(i>1){printf(" ");}
    printf("%s",*(argv+i));
  }
  printf("\n");
}
