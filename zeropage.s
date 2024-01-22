.macro mkvar name, size
    .export name
    .ifblank size
        name: .res 1
    .else
        name: .res size
    .endif
.endmacro

.segment "ZEROPAGE"
mkvar local_vars, 16
mkvar vblank_vars, 16

; Controller input bit map:
; |---|---|--------|-------|----|------|------|-------|
; | 7 | 6 |   5    |   4   | 3  |  2   |  1   |   0   |
; |---|---|--------|-------|----|------|------|-------|
; | A | B | Select | Start | Up | Down | Left | Right |
; |---|---|--------|-------|----|------|------|-------|

; Player 1 and 2 controllers (current)
mkvar p1_input
mkvar p2_input

; Player 1 and 2 controllers (previous)
mkvar p1_old
mkvar p2_old

; TODO: store 8 booleans inside a single state byte
mkvar vblank_finished

; TODO: make a Vector2 struct
; TODO: make an entity state struct
mkvar player_pos_x, 2
mkvar player_pos_y, 2
mkvar player_speed_x, 2
mkvar player_speed_y, 2
mkvar player_on_ground
