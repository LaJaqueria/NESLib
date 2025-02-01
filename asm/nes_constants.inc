; ---------------------------------------------------------------------------
; NES HARDWARE
; ---------------------------------------------------------------------------
PPUCTRL   = $2000
PPUMASK   = $2001
PPUSTATUS = $2002
PPUADDR   = $2006
PPUDATA   = $2007
PPUSCROLL = $2005
OAMADDR   = $2003
OAMDMA    = $4014

; NES Colors
BLUE     = $01
PURPLE   = $14
LIGHT_PURPLE = $24
ORANGE   = $27
PINK     = $25 
GREEN    = $2a
SKY_BLUE = $2c
RED      = $16
BLACK    = $0F
SKY_BLUE_LIGHT  = $3c

;Palettes -> PPU memory from $3f00 to $3f20
PPUPALETTES = $3F00
PPU_BG_PALETTE_0 = $3F00 ; 4 colors in each palette. First one is universal background in all of them.
PPU_BG_PALETTE_1 = $3F04
PPU_BG_PALETTE_2 = $3F08
PPU_BG_PALETTE_3 = $3F0C
PPU_FG_PALETTE_0 = $3f10
PPU_FG_PALETTE_1 = $3f14
PPU_FG_PALETTE_2 = $3f18
PPU_FG_PALETTE_3 = $3f1c

; PPU Tilemaps
PPU_SCREEN_1_MAP=$2000 ; 960 tiles of 1 byte + 64 bytes attribute table
PPU_SCREEN_1_ATTR=$23C0 ; 64 bytes attribute table
PPU_SCREEN_2_MAP=$2400
PPU_SCREEN_2_ATTR=$27C0
PPU_SCREEN_3_MAP=$2800
PPU_SCREEN_3_ATTR=$2BC0
PPU_SCREEN_4_MAP=$2C00
PPU_SCREEN_4_ATTR=$2FC0

; Gamepad ports
PORT1 = $4016
PORT2 = $4017

; Gamepad Buttons
BTN_RIGHT   = %00000001
BTN_LEFT    = %00000010
BTN_DOWN    = %00000100
BTN_UP      = %00001000
BTN_START   = %00010000
BTN_SELECT  = %00100000
BTN_B       = %01000000
BTN_A       = %10000000

; ---------------------------------------------------------------------------
; NES LIB PAGE ZERO CONSTANTS ($00-$CF)
; ---------------------------------------------------------------------------
IRQ_ADDR = $01 ; $02
NMI_ADDR = $03 ; $04
GAMEPAD1  = $05
GAMEPAD2  = $06
SCROLLX   = $07
SCROLLY   = $08
DATA_POINTER = $09 ; $0A

TEMP01 = $0B
TEMP02 = $0C
TEMP03 = $0D
TEMP04 = $0E
TEMP05 = $0F
TEMP06 = $10
TEMP07 = $11
TEMP08 = $12
TEMP09 = $13
TEMP10 = $14


OAMBUFFER = $0200

