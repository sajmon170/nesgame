.export palettes
.export sprites

.segment "CODE"
palettes:
.byte $27 ; bg color
.incbin "assets/bluecolors.pal"
.byte $00, $00, $00
.incbin "assets/bluecolors.pal"
.incbin "assets/bluecolors.pal"

pal1:
.incbin "assets/player_part1.pal"
pal2:
.incbin "assets/player_part2.pal"

sprites:
.byte $08, $01, $00, $08
.byte $08, $02, $00, $10
.byte $10, $03, $00, $08
.byte $10, $04, $00, $10
.byte $18, $05, $01, $08
.byte $18, $06, $01, $10
.byte $20, $07, $01, $08
.byte $20, $08, $01, $10
