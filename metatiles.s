.segment "CODE"

.struct Metatile
    tileid_1    .byte
    tileid_2    .byte
    tileid_3    .byte
    tileid_4    .byte
    palette_id  .byte
    collider_fn .word
.endstruct

metatiles:
