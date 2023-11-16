.export palettes
.export sprites
.export nametable

.feature c_comments

.segment "CODE"
palettes:
/*
.incbin "assets/bg.pal"
.incbin "assets/bluetile.pal"
.incbin "assets/bluetile.pal"
.incbin "assets/bluetile.pal"
*/

.incbin "assets/level0.pal"
.incbin "assets/level1.pal"
.incbin "assets/level1.pal"
.incbin "assets/level1.pal"

pal1:
.incbin "assets/player0.pal"
pal2:
.incbin "assets/player1.pal"

sprites:
.byte $08, $DA, $00, $08
.byte $08, $DB, $00, $10
.byte $10, $DC, $00, $08
.byte $10, $DD, $00, $10
.byte $18, $DE, $01, $08
.byte $18, $DF, $01, $10
.byte $20, $E0, $01, $08
.byte $20, $E1, $01, $10

nametable:
.incbin "assets/level.bin"
.incbin "assets/level_attr.bin"
