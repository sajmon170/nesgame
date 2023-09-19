.import vblank_isr
.import reset_isr

.segment "VECTORS"
.addr vblank_isr
.addr reset_isr
