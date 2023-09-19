.include "defines.inc"
.include "init.mac"

.export vblank_isr
.export reset_isr

.segment "CODE"
.proc reset_isr
    initialize_nes

game_loop:
    ; The main logic loop
    jsr read_controllers
    jsr update_physics
    jsr update_sprites
    jmp game_loop

.endproc

.proc vblank_isr
    rti
.endproc
