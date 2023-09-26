#include <stdio.h>

int main() {
     int begin = 0;
     printf("Hello riscv64 and qemu!\n");
     int a = 1;
     int b = 42;
     int c = a + b - 1;
     printf("%d\n", c);
     return 0;
}
