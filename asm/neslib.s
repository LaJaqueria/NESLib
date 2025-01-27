.INCLUDE "nes_constants.inc"
.PC02

.importzp sp

.export _load_palette

.proc _load_palette: near
  ; Reset latch PPUADDR
  LDX PPUSTATUS
  ; Set PPU address $3F00 to store next value
  LDX #$3f
  STX PPUADDR
  LDX #$00
  STX PPUADDR
  ; Store green value at PPU
  LDA #$29; Green
  STA PPUDATA
  RTS
.endproc

