/*
 * FillScreen Example
 * To manually build:
 *  Use Makefile after compile the lib:
 *  cd ../..
 *  make all
 *  cd examples/fillscreen
 *  make
 */

#include <neslib.h>

int main(){
    unsigned char i=0;
    load_palette(PALETTE_BG0, GREEN, ORANGE, PINK, RED);
    while(1);
    
	return 0;
}
