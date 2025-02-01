#ifndef NESLIB_H
#define NESLIB_H

#define BLUE            0x01
#define PURPLE          0x14
#define LIGHT_PURPLE    0x24
#define ORANGE          0x27
#define PINK            0x25 
#define GREEN           0x2a
#define SKY_BLUE        0x2c
#define RED             0x16
#define BLACK           0x0F
#define SKY_BLUE_LIGHT  0x3c

#define PALETTE_FG0 0
#define PALETTE_FG1 1
#define PALETTE_FG2 2
#define PALETTE_FG3 3
#define PALETTE_BG0 4
#define PALETTE_BG1 5
#define PALETTE_BG2 6
#define PALETTE_BG3 7


extern void __cdecl__ load_palette(unsigned char palette, unsigned char color1, unsigned char color2, unsigned char color3, unsigned char color4);


#endif
