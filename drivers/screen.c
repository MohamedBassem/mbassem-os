#include "screen.h"

#include "../kernel/low_level.h"


void print(char* string) {
  while(*string) {
    print_char(*string, -1, -1, 0);
    string++;
  }
}


void print_char(char c, int row, int col, char attr) {
  unsigned char* vaddress = (unsigned char*) VIDEO_ADDRESS;

  if (!attr) {
    attr = WHITE_ON_BLACK;
  }

  int offset;
  if (row >= 0 && col >= 0) {
    offset = get_screen_offset(row, col);
  } else {
    offset = get_cursor();
  }

  if(c == '\n') {
    offset /= 2;
    offset += MAX_COLS;
    offset -= (offset % MAX_COLS);
    offset *= 2;
  } else {
    vaddress[offset] = c;
    vaddress[offset+1] = WHITE_ON_BLACK;
    offset += 2;
  }

  set_cursor(offset);
}

void clear_screen() {
  for(int i=0;i<MAX_ROWS;i++) {
    for(int j=0;j<MAX_COLS;j++) {
      print_char(' ', i, j, 0);
    }
  }
  set_cursor(0);
}

int get_screen_offset(int row, int col) {
  return (row * MAX_COLS + col) * 2;
}

int get_cursor() {
  port_byte_out(REG_SCREEN_CTRL, 14);
  int offset = port_byte_in(REG_SCREEN_DATA) << 8;
  port_byte_out(REG_SCREEN_CTRL, 15);
  offset += port_byte_in(REG_SCREEN_DATA);
  return offset * 2;
}

void set_cursor(int offset) {
  offset /= 2;
  port_byte_out(REG_SCREEN_CTRL, 14);
  port_byte_out(REG_SCREEN_DATA, offset >> 8);
  port_byte_out(REG_SCREEN_CTRL, 15);
  port_byte_out(REG_SCREEN_DATA, offset & 0xFF);
}
