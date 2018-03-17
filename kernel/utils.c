#include "utils.h"

void mem_copy(char* src, char* dst, int num_bytes) {
  for(int i=0;i<num_bytes;i++,src++,dst++) {
    *dst = *src;
  }
}

