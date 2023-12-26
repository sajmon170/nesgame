.segment "CODE"
.feature c_comments

.include "defines.inc"

.export load_level

; From: level.s
.import level
; From: metatiles.s
.import metatiles

; From: zeropage.s
.import local_vars: zeropage

.proc load_level
    ; local_vars[0:1] - metatile definitions structure address
    ; local_vars + 2 - temporary variable
    ; local_vars + 3 - current line number
    ; local_vars + 4 - attribute table entry
    
    lda #<(metatiles)
    sta local_vars
    lda #>(metatiles)
    sta local_vars+1

    lda PPUSTAT
    lda #$20
    sta PPUADDR
    lda #$00
    sta PPUADDR

    ; set initial line to 0
    ldx #$0
    stx local_vars+3

    load_nametable:
        ldx local_vars+3 
        lda #0
        part1:
            ; back-up column iterator
            pha 

            ; A *= 5
            clc
            lda level, X
            sta local_vars+2
            asl
            asl
            adc local_vars+2
            tay

            ; load 2 next top tiles
            lda (local_vars), Y
            sta PPUDATA
            iny
            lda (local_vars), Y
            sta PPUDATA
            inx

            ; column loop evaluation
            pla
            adc #$1
            cmp #$10
            bne part1


        ldx local_vars+3
        lda #0
        part2:
            ; back-up column iterator
            pha 
    
            ; A *= 5
            clc
            lda level, X
            sta local_vars+2
            asl
            asl
            adc local_vars+2
            tay

            ; load 2 next bottom tiles
            iny
            iny
            lda (local_vars), Y
            sta PPUDATA
            iny
            lda (local_vars), Y
            sta PPUDATA
            inx

            ; column loop evaluation
            pla
            adc #$1
            cmp #$10
            bne part2

        clc
        lda local_vars+3
        adc #$10
        sta local_vars+3
        cmp #$F0
        bne load_nametable

    ldx #$0 ; position column
    ldy #$0 ; position row
    clc

    
    ; Loading palettes

    /*
    lda #$00
    tax
et:
    sta PPUDATA
    inx
    cpx #$40
    bne et
    */

    lda #$11
    sta local_vars+3

    ; initialize row iterator
    lda #$0
    
    load_palettes:
        ; back-up row iterator
        pha
    
        ldx local_vars+3 
        lda #0
    
        ; iterates through 2x2 metatiles
        inner_loop:
            ; back-up column iterator
            pha 

            ; A = 5*A + 4 
            lda level, X
            sta local_vars+2
            asl
            asl
            clc
            adc local_vars+2
            clc
            adc #$04
            tay

            ; load metatile, update
            lda (local_vars), Y
            asl
            asl
            sta local_vars+4

            dex

            ; A = 5*A + 4 
            lda level, X
            sta local_vars+2
            asl
            asl
            clc
            adc local_vars+2
            clc
            adc #$04
            tay

            ; load metatile, update
            lda (local_vars), Y
            ora local_vars+4
            asl
            asl
            sta local_vars+4

            txa
            clc
            sbc #$0E
            tax

            ; A = 5*A + 4 
            lda level, X
            sta local_vars+2
            asl
            asl
            clc
            adc local_vars+2
            clc
            adc #$04
            tay

            ; load metatile, update
            lda (local_vars), Y
            ora local_vars+4
            asl
            asl
            sta local_vars+4

            dex

            ; A = 5*A + 4 
            lda level, X
            sta local_vars+2
            asl
            asl
            clc
            adc local_vars+2
            clc
            adc #$04
            tay

            ; load metatile, update
            lda (local_vars), Y
            ora local_vars+4

            sta PPUDATA
    
            ; column loop evaluation
            pla
            clc
            adc #$02
            tay
            clc
            adc local_vars+3
            tax
            tya
            cmp #$10
            bne inner_loop

        lda local_vars+3
        clc
        adc #$20
        sta local_vars+3
        pla
        clc
        adc #$01
        cmp #$08
        bne load_palettes
    
    rts
.endproc
