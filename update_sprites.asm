.include "defines.inc"

.import palettes
.import sprites

; TODO: move this to a header file
.import local_vars: zeropage
.import p1_input:   zeropage
.import p2_input:   zeropage
.import p1_old:     zeropage
.import p2_old:     zeropage

.export update_sprites

.feature c_comments

.segment "CODE"
.proc update_sprites
    ldx #$00
    ldy #$00
    
pressed_left:
    lda p1_input
    and #BTN_LEFT
    beq pressed_right
    ldx #$FF ; -1
    
pressed_right:
    lda p1_input
    and #BTN_RIGHT
    beq pressed_down
    ldx #$01

pressed_down:
    lda p1_input
    and #BTN_DOWN
    beq pressed_up
    ldy #$01

pressed_up:
    lda p1_input
    and #BTN_UP
    beq update
    ldy #$FF ; -1

update:
    stx local_vars

    ldx #$0
loop:
    ; Update X coordinate
    lda local_vars
    clc
    adc $0203, X
    sta $0203, X

    ; Update Y coordinate
    tya
    clc
    adc $0200, X
    sta $0200, X

    ; Update loop counter
    txa
    clc
    adc #$04
    tax

    ; Finished?
    cpx #$8*4
    bne loop
    
finish:
    rts
.endproc
