; ---------------------------------------------------------------------------
; crt0.s
; ---------------------------------------------------------------------------
;
; Startup code for cc65

.import   _main

.export   __STARTUP__ : absolute = 1        ; Mark as startup
.import __STACKSTART__, __STACKSIZE__, __ROM_START__
.import    copydata, zerobss, initlib, donelib
.include "../asm/nes_constants.inc"
.include "zeropage.inc"

; Enable 65C02 instruction set
.PC02

; ---------------------------------------------------------------------------
; SEGMENT STARTUP
; ---------------------------------------------------------------------------
.segment  "STARTUP"


; Initialize NES
_init:
    ; Disable interrupts
  SEI
  ; Disable decimal mode
  CLD
  ; Disable audio IRQs
  LDX #$40
  STX $4017
  ; Initialize stack
  LDX #$FF
  TXS
  ; Disable NMI frame trigger (bit 7 controls whether or not the PPU will trigger an NMI every frame.)
  LDX #$0
  STX PPUCTRL
  ; Disable graphics
  STX PPUMASK
  ; Turn off DMC IRQs
  STX $4010
     
  ; Initialize cc65 stack pointer
  LDA #<(__STACKSTART__ + __STACKSIZE__)
  STA sp
  LDA #>(__STACKSTART__ + __STACKSIZE__)
  STA sp+1

  ; Initialize memory storage
  JSR zerobss
  JSR copydata
  JSR initlib

  ; Wait for the PPU to fully boot up
  BIT $2002
vblankwait:
  BIT $2002
  BPL vblankwait
vblankwait2:
  BIT $2002
  BPL vblankwait2
    
  ; Set up IRQ subroutine
  LDA #<_irq_int
  STA IRQ_ADDR
  LDA #>_irq_int
  STA IRQ_ADDR+1
    
  ; Set up NMI subroutine
  LDA #<_nmi_int
  STA NMI_ADDR
  LDA #>_nmi_int
  STA NMI_ADDR+1
    
  ; Call main()
  JSR _main

; Back from main (also the _exit entry):
_exit:
    ; Run destructors
    JSR donelib

; Stop
_stop:
    BRA _stop


; Maskable interrupt (IRQ) service routine
_irq_int:  
    RTI 

; Non-maskable interrupt (NMI) service routine
_nmi_int:
    PHA

  ; Copy OAM cache
  LDA #<OAMBUFFER
  STA OAMADDR
  LDA #>OAMBUFFER
  STA OAMDMA

  ; Set Background scroll
  LDA SCROLLX
  STA PPUSCROLL
  LDA SCROLLY
  STA PPUSCROLL

  ; Latch controllers
  LDA #$01
  STA PORT1
  LDA #$00
  STA PORT1  
  ; Read controller 1
  LDA #%00000001
  STA GAMEPAD1
  loop:
  LDA PORT1
  LSR
  ROL GAMEPAD1
  BCC loop  
  ; Read controller 2
  LDA #%00000001
  STA GAMEPAD2
  loop2:
  LDA PORT2
  LSR
  ROL GAMEPAD2
  BCC loop2

  PLA
  RTI

hw_irq_int:
    JMP (IRQ_ADDR)
    
hw_nmi_int:
    JMP (NMI_ADDR)

; ---------------------------------------------------------------------------
; SEGMENT VECTORS
; ---------------------------------------------------------------------------
.segment  "VECTORS"

.addr      hw_nmi_int    ; NMI vector
.addr      _init       ; Reset vector
.addr      hw_irq_int    ; IRQ/BRK vector


; ---------------------------------------------------------------------------
; SEGMENT HEADER - EMULATORS HEADER (16 byte) (https://www.nesdev.org/wiki/INES
; ---------------------------------------------------------------------------
.segment "HEADER"
.byt "NES"
.byt $1a                      ; Magic string that always begins an iNES header
.byt $02                      ; Number of 16KB PRG-ROM banks
.byt $01                      ; Number of 8KB CHR-ROM banks
.byt %00000001                ; Vertical mirroring (Screens left, right), no save RAM, no mapper
.byt %00000000                ; No special-case flags set, no mapper
.byt $00                      ; No PRG-RAM present
.byt $00                      ; NTSC format
.byt $00,$00,$00,$00,$00,$00  ; Unused padding

