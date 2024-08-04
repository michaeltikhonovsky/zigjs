#include "math.h"
#include <stdio.h>

int main(void) {

  int a = 21;
  int b = 22;
  int c = add(a, b);

  printf("c: %d\n", c);
  printf("c increment: %d\n", increment(c));

  return 0;
}
