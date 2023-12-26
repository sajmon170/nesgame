.feature c_comments

.segment "CODE"

.export palettes_data
.export palettes_green_id  := 0
.export palettes_blue_id   := 1
.export palettes_orange_id := 2
.export palettes_bw_id     := 3

palettes_data:
; Background palettes
.incbin "assets/pal/colors.pal"
; Sprite palettes
.incbin "assets/pal/colors.pal"
