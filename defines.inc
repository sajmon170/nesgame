.ifndef _DEFINES
_DEFINES = 1

; Memory map
OAMDATA = $0200

; Memory-mapped registers
PPUCTRL = $2000
PPUMASK = $2001
PPUSTAT = $2002
PPUSCRL = $2005
PPUADDR = $2006
PPUDATA = $2007
DMCFREQ = $4010
OAM_DMA = $4014
JOYPAD1 = $4016
JOYPAD2 = $4017
APUFCNT = $4017

; Register configuration
BASE_CFG   = %00000000

; PPUCTRL config
ENABLE_NMI = %10000000

; PPUMASK config
EMPH_BLUE  = %10000000
EMPH_GREEN = %01000000
EMPH_RED   = %00100000
ALLOW_SPR  = %00010000
ALLOW_BG   = %00001000
ALLOW_LSPR = %00000100
ALLOW_LBG  = %00000010
GRAYSCALE  = %00000001

; Nametables
NAMETABLE0 = $2000

; Controller buttons
BTN_A      = %10000000
BTN_B      = %01000000
BTN_SELECT = %00100000
BTN_START  = %00010000
BTN_UP     = %00001000
BTN_DOWN   = %00000100
BTN_LEFT   = %00000010
BTN_RIGHT  = %00000001

; Physics constants
; To avoid costly multiplication all objects are 
; assumed to have the same mass of 60kg.

; let T = 16/60 [s] be the basic unit of time.
DELTA         = $01 << 5 ; [T] 
GRAVITY_STEP  = $01 << 5 ; [adt] = [m/T]
FRICTION_STEP = $01 << 4 ; [adt] = [m/T]
PLAYER_PULL   = $01 << 3 ; [adt] = [m/T]
    
.endif
