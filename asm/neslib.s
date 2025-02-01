.INCLUDE "nes_constants.inc"
.PC02

.importzp sp
.import incsp5

.export _load_palette

.proc _load_palette: near
  ; Load arguments: t1=c4, t2=c3, t3=c2, t4=c1, t5=pal
  LDY #$04
  LDX #0
  loop:
  LDA (sp),Y
  STA TEMP01,X
  INX
  DEY
  BPL loop  
  
  
  ; Load palette offset in A
  LDA TEMP01
  AND #%00000111
  CLC
  ASL
  ASL
  
  ; Reset latch PPUADDR
  LDX PPUSTATUS
  ; Set PPU address $3F00 to store next value
  LDX #>PPUPALETTES
  STX PPUADDR
  ; Store palette offset
  STA PPUADDR
  ; Store colors from stack
  LDX TEMP02
  STX PPUDATA
  LDX TEMP03
  STX PPUDATA
  LDX TEMP04
  STX PPUDATA
  LDX TEMP05
  STX PPUDATA
    
  JMP incsp5
.endproc

