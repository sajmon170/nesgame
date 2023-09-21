.include "utils.mac"
.feature c_comments

.import read_controllers
.import update_sprites
.import palettes
.import sprites
.import vblank_finished: zeropage
; .import update_physics
; .import update_sprites

.export vblank_isr
.export reset_isr

.segment "CODE"
.proc reset_isr
    initialize_nes

    ; TODO: move this part into another function/game loop
    ; ...or maybe move this into initialization code?
    ; read status to reset the address latch
    lda PPUSTAT 

    ; set the PPU address to #3f00
    lda #$3f
    sta PPUADDR
    lda #$00
    sta PPUADDR

    ldx #$00
loadpalettes:
    lda palettes, X
    sta PPUDATA
    inx
    cpx #$20
    bne loadpalettes

    ldx #$00
loadsprites:
    lda sprites, X
    sta $0200, X
    inx
    cpx #$20
    bne loadsprites

    cli
    lda #ENABLE_NMI
    sta PPUCTRL
    lda #ALLOW_SPR
    sta PPUMASK

game_loop:
    lda vblank_finished
    cmp #$01
    bne game_loop
    lda #$00
    sta vblank_finished
    
    ; jsr update_logic
    ; jsr update_state
    jsr update_sprites
    jmp game_loop

.endproc

.proc vblank_isr
    lda #$02
    sta OAM_DMA
    read_controllers

    lda #$01
    sta vblank_finished
    rti
.endproc
