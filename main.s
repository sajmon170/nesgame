.include "utils.mac"
.feature c_comments

; From: utils.mac
.import read_controllers

; From: update_sprites.s
.import update_sprites

; From: loader.s
.import load_level

; From: zeropage.s
.import local_vars: zeropage
.import vblank_finished: zeropage

; From: palettes.s
.import palettes_data

; .import update_physics
; .import update_sprites

.export vblank_isr
.export reset_isr

.segment "CODE"
.proc reset_isr
    initialize_nes

    jsr load_palettes
    jsr load_sprites
    jsr load_level

    lda #$00
    sta PPUSCRL
    sta PPUSCRL

    cli

    lda #ENABLE_NMI
    sta PPUCTRL
    lda #ALLOW_SPR | ALLOW_BG
    sta PPUMASK

game_loop:
    lda vblank_finished
    cmp #$01
    bne game_loop
    lda #$00
    sta vblank_finished
    
    ; jsr update_logic
    ; jsr update_state
    ; jsr update_sprites
    jmp game_loop

.endproc

.proc vblank_isr
    store_registers
    
    lda #$02
    sta OAM_DMA

    ; Note: this macro exploits OAM DMA
    ; => it cannot be moved outside of VBLANK
    read_controllers
    lda #$01
    sta vblank_finished

    load_registers    
    rti
.endproc

.proc load_palettes
    ; read status to reset the address latch
    lda PPUSTAT 

    ; set the PPU address to #3f00
    lda #$3f
    sta PPUADDR
    lda #$00
    sta PPUADDR
    
    ldx #$00
load:
    lda palettes_data, X
    sta PPUDATA
    inx
    cpx #$20
    bne load
    
    rts
.endproc

.proc load_sprites
    ldx #$00

load:
    ; This only initializes the NES RAM's OAM region
    ; => no OAM DMA is being done yet!
    ; lda sprites, X
    sta $0200, X
    inx
    cpx #$20
    bne load
    
    rts
.endproc
