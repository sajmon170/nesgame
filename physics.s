.feature c_comments
.include "defines.inc"

.import player_pos_x:     zeropage
.import player_pos_y:     zeropage
.import player_speed_x:   zeropage
.import player_speed_y:   zeropage
.import player_on_ground: zeropage

; Multiplies a real number by delta-time.
; Assumes delta-time = 1/16 T = 1/60 s.
.macro mul_dt real
    ror float
    ror float + 1
    clc
    
    ror float
    ror float + 1
    clc
    
    ror float
    ror float + 1
    clc
    
    ror float
    ror float + 1
    clc
.endmacro

.macro add_re real1 real2
    clc
    lda real1 + 1
    adc real2 + 1
    sta real1 + 1
    lda real1
    adc real2
    sta real1
.endmacro

.macro sub_re real1 real2
    clc
    lda real1 + 1
    sbc real2 + 1
    sta real1 + 1
    lda real1
    sbc real2
    sta real1
.endmacro

.segment "CODE"
.proc update_physics
    ; Formulae:
    ; v = ds/dt => ds = vdt
    ; a = dv/dt => dv = adt
    ; F = f * N

    ; local_vars[0]: integer part
    ; local_vars[1]: real part

update_y:
    lda player_on_ground
    cmp #$01
    bne update_x

    lda player_speed_y
    sta local_vars
    lda player_speed_y + 1
    sta local_vars + 1
    mul_dt local_vars
    add_re player_pos_y local_vars

    lda #$00
    sta local_vars
    lda GRAVITY_STEP
    sta local_vars + 1
    add_re player_speed_y local_vars

update_x:
    lda player_speed_x
    cmp #$00
    beq finish

    lda player_speed_x
    sta local_vars
    lda player_speed_x + 1
    sta local_vars + 1
    mul_dt local_vars
    add_re player_speed_x local_vars

    lda #$00
    sta local_vars
    lda GRAVITY_STEP
    sta local_vars + 1
    sub_re player_speed_y local_vars

finish:
    
    
    rts
.endproc
