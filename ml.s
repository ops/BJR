;;;
;;; Bomb Jack Revisited
;;;
;;; 1985,2018 ops
;;;

COMCHK          := $CEFD
GETBYT          := $D79B
PARSL           := $E1D1
IRQ             := $EABF

SCREEN_MEM      := $1C00
COLOR_MEM       := $9400

CURR_PLAYER_CH  := $033C
GHOST_DELAY     := $033D
PLAYER_DELAY    := $033E
PLAYER_CH_DELAY := $033F
PLAYER_POS      := $0340
GHOST_POS       := PLAYER_POS+2  ; 3 x word
CONTROL         := 888           ; $0378

MAP_X_SIZE       = 26

CH_EMPTY         = $20
CH_PLAYER_MIN    = $6F
CH_PLAYER_MAX    = $72
CH_GHOST         = $73
CH_BOMB          = $74
CH_WALL_MIN      = $75
CH_WALL_MAX      = $7F

        .include "cbm_kernal.inc"
        .include "vic20.inc"
        .include "VERSION"

        .segment "LOADADDR"
        .export  __LOADADDR__: absolute = 1
        .addr *+2

        .segment "CODE"

        ; Jump table for subroutines
        jmp clear_screen        ; 00
        jmp set_tune            ; 03
        jmp paint_lanes         ; 06
        jmp load_map            ; 09
        jmp initialise          ; 12
        jmp set_positions       ; 15
        jmp print_version       ; 18

.proc clear_screen
        jsr     CLRSCR
        ldy     #$00
        sty     $FB
        sty     $FD
        lda     #>SCREEN_MEM
        sta     $FC
        lda     #>COLOR_MEM
        sta     $FE
        ldx     #$04
@loop:  lda     #CH_EMPTY
        sta     ($FB),y
        lda     646
        sta     ($FD),y
        iny
        bne     @loop
        inc     $FC
        inc     $FE
        dex
        bne     @loop
        rts
.endproc

.proc paint_lanes
        lda     #<SCREEN_MEM
        sta     $FB
        lda     #>SCREEN_MEM
        sta     $FC
        lda     #<COLOR_MEM
        sta     $FD
        lda     #>COLOR_MEM
        sta     $FE
        ldx     #$04
        ldy     #MAP_X_SIZE
@loop:  lda     #CH_EMPTY
        cmp     ($FB),y
        bne     :+
        lda     #$01
        sta     ($FD),y
:       iny
        bne     @loop
        inc     $FC
        inc     $FE
        dex
        bne     @loop
        rts
.endproc

.proc load_map
        jsr     COMCHK
        jsr     PARSL
        lda     #$00
        ldx     #<(SCREEN_MEM+MAP_X_SIZE)
        ldy     #>(SCREEN_MEM+MAP_X_SIZE)
        jmp     LOAD
.endproc

.proc initialise
        lda     #CH_PLAYER_MIN
        sta     CURR_PLAYER_CH
        lda     #1
        sta     GHOST_DELAY
        sta     PLAYER_DELAY
        sta     PLAYER_CH_DELAY
        sei
        lda     #<my_irq
        sta     IRQVec
        lda     #>my_irq
        sta     IRQVec+1
        cli
        rts
.endproc

.proc set_positions
        ldx     #4*2-1
:       lda     pos,x
        sta     PLAYER_POS,x
        dex
        bpl     :-
        rts

pos:    .word   SCREEN_MEM+53, SCREEN_MEM+76, SCREEN_MEM+755, SCREEN_MEM+778
.endproc

.proc print_version
        lda     #'v'-64
        sta     SCREEN_MEM+30*26+20
        lda     #BJR_VERSION_MAJOR+'0'
        sta     SCREEN_MEM+30*26+21
        lda     #'.'
        sta     SCREEN_MEM+30*26+22
        lda     #BJR_VERSION_MINOR+'0'
        sta     SCREEN_MEM+30*26+23
        rts
.endproc

.proc my_irq
        lda     CONTROL
        and     #1 << 0
        beq     :+
        jsr     play_music
:       lda     CONTROL
        and     #1 << 1
        beq     :+
        dec     PLAYER_CH_DELAY
        bne     @skip
        jsr     next_player_char
        ldy     #10
        sty     PLAYER_CH_DELAY
@skip:  dec     PLAYER_DELAY
        bne     :+
        jsr     move_player
        lda     #$05
        sta     PLAYER_DELAY
:       lda     CONTROL
        and     #1 << 2
        beq     :+
        dec     GHOST_DELAY
        bne     :+
        jsr     move_ghosts
        lda     #$08
        sta     GHOST_DELAY
:       jmp     IRQ
.endproc

.proc read_joy
        lda     #$7F
        sta     VIA2_DDRB
        lda     VIA2_PB
        pha
        lda     #$FF
        sta     VIA2_DDRB
        pla
        and     #$80
        beq     pos_right
        lda     VIA1_PA2
        and     #$04
        beq     pos_up
        lda     VIA1_PA2
        and     #$08
        beq     pos_down
        lda     VIA1_PA2
        and     #$10
        beq     pos_left
        rts
.endproc

get_new_pos:
        lda     $9119
        adc     $9128
        and     #$03
        beq     pos_right
        cmp     #$01
        beq     pos_left
        cmp     #$02
        beq     pos_down
        ; fall through
pos_up:
        sec
        lda     $FB
        sbc     #MAP_X_SIZE
        sta     $FD
        lda     $FC
        sbc     #$00
        sta     $FE
        rts
pos_right:
        clc
        lda     $FB
        adc     #$01
        sta     $FD
        lda     $FC
        adc     #$00
        sta     $FE
        rts
pos_left:
        sec
        lda     $FB
        sbc     #$01
        sta     $FD
        lda     $FC
        sbc     #$00
        sta     $FE
        rts
pos_down:
        clc
        lda     $FB
        adc     #MAP_X_SIZE
        sta     $FD
        lda     $FC
        adc     #$00
        sta     $FE
        rts

.proc move_ghosts
        ldx     #$00
@loop:  lda     GHOST_POS,x
        sta     $FB
        lda     GHOST_POS+1,x
        sta     $FC
        jsr     get_new_pos
        ldy     #$00
        lda     #CH_EMPTY
        sta     ($FB),y
        lda     ($FD),y
        cmp     #CH_WALL_MIN-1
        bcs     :+
        lda     $FD
        sta     $FB
        sta     GHOST_POS,x
        lda     $FE
        sta     $FC
        sta     GHOST_POS+1,x
:       lda     #CH_GHOST
        sta     ($FB),y
        inx
        inx
        cpx     #$06
        bne     @loop
        rts
.endproc

.proc move_player
        lda     $90
        bne     @out
        lda     PLAYER_POS
        sta     $FB
        sta     $FD
        lda     PLAYER_POS+1
        sta     $FC
        sta     $FE
        ldy     #$00
        lda     #CH_GHOST
        cmp     ($FB),y
        bne     @skip
        lda     #$01
        sta     $90
@out:   rts
@skip:  lda     #CH_EMPTY
        sta     ($FB),y
        jsr     read_joy
        lda     #CH_EMPTY
        cmp     ($FD),y
        beq     L1B53
        lda     #CH_GHOST
        cmp     ($FD),y
        bne     :+
        lda     #$01
        sta     $90
        rts
:       lda     #CH_BOMB
        cmp     ($FD),y
        bne     L1B5D
        lda     #$02
        sta     $90
L1B53:  lda     $FD
        sta     $FB
        lda     $FE
        sta     $FC
L1B5D:  lda     CURR_PLAYER_CH
        sta     ($FB),y
        lda     $FB
        sta     PLAYER_POS
        lda     $FC
        sta     PLAYER_POS+1
        rts
.endproc

.proc next_player_char
        ldy     CURR_PLAYER_CH
        iny
        cpy     #CH_PLAYER_MAX+1
        bne     :+
        ldy     #CH_PLAYER_MIN
:       sty     CURR_PLAYER_CH
        rts
.endproc

.proc play_music
        ldy     $00
        beq     @next
        cpy     #$FF
        beq     @skip
        dey
        sty     $00
        rts
@next:  lda     ($01),y
        sta     VIC_CRC
        sta     VIC_CRB
        iny
        lda     ($01),y
        sta     $00
        clc
        lda     $01
        adc     #$02
        sta     $01
        bcc     @skip
        inc     $02
@skip:  rts
.endproc

.proc set_tune
        jsr     GETBYT
        txa
        asl
        tax
        lda     tune_table,x
        sta     $01
        lda     tune_table+1,x
        sta     $02
        lda     #$00
        sta     $00
        rts
.endproc

tune_table:
        .word   tune1,tune2,tune3

tune1:  .byte   $C1,$0A,$00,$01,$C1,$0A
        .byte   $C8,$0A,$CB,$0A,$00,$01,$CB,$0A
        .byte   $00,$01,$CB,$0A,$C8,$0A,$C1,$0A
        .byte   $00,$01,$C1,$0A,$00,$01,$C1,$0A
        .byte   $BD,$0A,$C1,$0A,$C8,$14,$AC,$14
        .byte   $C8,$0A,$00,$01,$C8,$0A,$CB,$0A
        .byte   $D1,$0A,$00,$01,$D1,$0A,$00,$01
        .byte   $D1,$0A,$CB,$0A,$C8,$0A,$CB,$0A
        .byte   $00,$01,$CB,$0A,$D1,$0A,$D8,$0A
        .byte   $D6,$14,$00,$01,$D6,$14,$DC,$0A
        .byte   $00,$01,$DC,$0A,$D8,$0A,$D6,$0A
        .byte   $D8,$0A,$00,$01,$D8,$0A,$D6,$0A
        .byte   $D1,$0A,$D6,$0A,$00,$01,$D6,$0A
        .byte   $D1,$0A,$D6,$0A,$D8,$14,$D1,$14
        .byte   $DC,$0A,$00,$01,$DC,$0A,$D8,$0A
        .byte   $D6,$0A,$D8,$0A,$00,$01,$D8,$0A
        .byte   $D6,$0A,$D1,$0A,$CE,$0A,$C1,$0A
        .byte   $C8,$0A,$CE,$0A,$D1,$14,$00,$01
        .byte   $D1,$14,$00,$01,$D1,$0A,$00,$01
        .byte   $D1,$0A,$CB,$0A,$C8,$0A,$CB,$0A
        .byte   $00,$01,$CB,$0A,$C8,$0A,$C1,$0A
        .byte   $C8,$0A,$00,$01,$C8,$0A,$C1,$0A
        .byte   $C8,$0A,$CB,$14,$C1,$14,$D1,$0A
        .byte   $00,$01,$D1,$0A,$CB,$0A,$C8,$0A
        .byte   $CB,$0A,$00,$01,$CB,$0A,$C8,$0A
        .byte   $C1,$0A,$BD,$0A,$AC,$0A,$B5,$0A
        .byte   $BD,$0A,$C1,$14,$00,$01,$C1,$14
        .byte   $00,$01,$01,$ff

tune2:  .byte   $BD,$0A,$00,$01,$BD,$0A
        .byte   $C1,$0A,$C8,$0A,$CB,$14,$C8,$14
        .byte   $BD,$0A,$00,$01,$BD,$0A,$C1,$0A
        .byte   $C8,$0A,$D1,$14,$C8,$14,$BD,$0A
        .byte   $00,$01,$BD,$0A,$C1,$0A,$C8,$0A
        .byte   $00,$01,$C8,$0F,$C1,$05,$BD,$0A
        .byte   $B5,$0A,$AC,$0A,$00,$01,$AC,$0A
        .byte   $B5,$0A,$00,$01,$B5,$0A,$AC,$14
        .byte   $00,$01,$01,$ff

tune3:  .byte   $BD,$0A,$00,$01,$BD,$0A
        .byte   $C1,$0A,$C8,$0A,$00,$01,$C8,$0F
        .byte   $C1,$05,$BD,$0A,$B5,$0A,$AC,$0A
        .byte   $00,$01,$AC,$0A,$B5,$0A,$BD,$0A
        .byte   $00,$01,$BD,$0F,$B5,$05,$00,$01
        .byte   $B5,$14,$BD,$0A,$00,$01,$BD,$0A
        .byte   $C1,$0A,$C8,$0A,$00,$01,$C8,$0F
        .byte   $C1,$05,$BD,$0A,$B5,$0A,$AC,$0A
        .byte   $00,$01,$AC,$0A,$B5,$0A,$BD,$0A
        .byte   $B5,$0F,$AC,$05,$00,$01,$AC,$14
        .byte   $B5,$14,$BD,$0A,$AC,$0A,$B5,$0A
        .byte   $BD,$05,$C1,$05,$BD,$0A,$AC,$0A
        .byte   $B5,$0A,$BD,$05,$C1,$05,$BD,$0A
        .byte   $B5,$0A,$AB,$0A,$B5,$0A,$91,$14
        .byte   $BD,$0A,$00,$01,$BD,$0A,$C1,$0A
        .byte   $C8,$0A,$00,$01,$C8,$0F,$C1,$05
        .byte   $BD,$0A,$B5,$0A,$AC,$0A,$00,$01
        .byte   $AC,$0A,$B5,$0A,$BD,$0A,$B5,$0F
        .byte   $AC,$05,$00,$01,$AC,$14,$00,$01
        .byte   $01,$ff
