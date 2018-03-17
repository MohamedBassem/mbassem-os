#include "../drivers/screen.h"

void main() {
  clear_screen();
  for(int i=0;i<25;i++) {
    for(int j=0;j<=i;j++) {
      print("*");
    }
    print("\n");
  }
}
