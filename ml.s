
MAP_X_SIZE = 26
;MAP_Y_SIZE = 25

VICCRA  := VIC+$0A
VICCRB  := VIC+$0B
VICCRC  := VIC+$0C
VICCRE  := VIC+$0E
LEABF   := $EABF

SCREEN_MEM := $1c00
COLOR_MEM := $9400

GHOST_DELAY := $0336

        .setcpu "6502"

        .include "cbm_kernal.inc"
        .include "vic20.inc"

        .segment "LOADADDR"
        .export  __LOADADDR__: absolute = 1
        .addr *+2

        .segment "CODE"

        jmp next_player_char    ; 00
        jmp $0000               ; 03
        jmp fill_empty          ; 06
        jmp load_map            ; 09
        jmp move_ghost          ; 12
        jmp start_irq           ; 15
        jmp reset_irq           ; 18
        jmp clear_screen        ; 21
        jmp set_irq2            ; 24
        jmp set_tune1           ; 27
        jmp set_tune2           ; 30
        jmp set_tune3           ; 33

fill_empty:
        lda     #<SCREEN_MEM
        sta     $FB
        lda     #>SCREEN_MEM
        sta     $FC
        lda     #<COLOR_MEM
        sta     $FD
        lda     #>COLOR_MEM
        sta     $FE
        ldy     #MAP_X_SIZE
@loop:  lda     #$20
        cmp     ($FB),y
        bne     @skip
        lda     #$01
        sta     ($FD),y
@skip:  iny
        bne     @loop
        inc     $FC
        inc     $FE
        lda     #>(SCREEN_MEM + $0400)
        cmp     $FC
        bne     @loop
        rts

load_map:
        lda     #$01
        ldx     $ba
        ldy     #$00
        jsr     SETLFS
        lda     #(NAME_END-NAME)
        ldx     #<NAME
        ldy     #>NAME
        jsr     SETNAM
        lda     #$00
        ldx     #<(SCREEN_MEM+26)
        ldy     #>(SCREEN_MEM+26)
        jsr     LOAD
        rts

NAME:   .byte "map01.bin"
NAME_END:

clear_screen:
        jsr     CLRSCR
        ldy     #$00
        sty     $FB
        sty     $FD
        lda     #>SCREEN_MEM
        sta     $FC
        lda     #>COLOR_MEM
        sta     $FE
@loop:  lda     #$20
        sta     ($FB),y
        lda     646
        sta     ($FD),y
        iny
        bne     @loop
        inc     $FC
        inc     $FE
        lda     #>(SCREEN_MEM + $0400)
        cmp     $FC
        bne     @loop
        rts

start_irq:
        sei
        lda     #<my_irq
        sta     IRQVec
        lda     #>my_irq
        sta     IRQVec+1
        cli
        rts

set_irq2:
        sei
        lda     #<irq2
        sta     IRQVec
        lda     #>irq2
        sta     IRQVec+1
        cli
        rts

reset_irq:
        sei
        lda     #$BF
        sta     IRQVec
        lda     #$EA
        sta     IRQVec+1
        cli
        rts

my_irq:
        ldx     GHOST_DELAY
        inx
        cpx     #$04
        bne     L17F4
        jsr     L1B15
        ldx     #$00
L17F4:  stx     GHOST_DELAY
        jsr     play_music
        jmp     LEABF

irq2:   jsr     play_music
        jmp     LEABF

read_joy:
        ldy     #$7F
        sty     VIA2_DDRB
        lda     VIA2_PB
        ldy     #$FF
        sty     VIA2_DDRB
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

get_new_pos:
        lda     $9119
        adc     $9128
        and     #$03
        cmp     #$00
        beq     pos_right
        cmp     #$01
        beq     pos_left
        cmp     #$02
        beq     pos_down
        ; Move up
pos_up:
        sec
        lda     $FB
        sbc     #MAP_X_SIZE
        sta     $FD
        lda     $FC
        sbc     #$00
        sta     $FE
        rts
        ; Move right
pos_right:
        clc
        lda     $FB
        adc     #$01
        sta     $FD
        lda     $FC
        adc     #$00
        sta     $FE
        rts
        ; Move left
pos_left:
        sec
        lda     $FB
        sbc     #$01
        sta     $FD
        lda     $FC
        sbc     #$00
        sta     $FE
        rts
        ; Move down
pos_down:
        clc
        lda     $FB
        adc     #MAP_X_SIZE
        sta     $FD
        lda     $FC
        adc     #$00
        sta     $FE
        rts

move_ghost:
        sei
L1A53:  ldx     $0334
        lda     $0342,x
        sta     $FB
        inx
        lda     $0342,x
        sta     $FC
        stx     $0334
        jsr     get_new_pos
        ldy     #$00
        lda     #$20
        sta     ($FB),y
        cmp     ($FD),y
L010E:  beq     store_pos
L0113:  lda     #$74
        cmp     ($FD),y
        beq     store_pos
        lda     #$6F
        cmp     ($FD),y
        beq     store_pos
        lda     #$70
        cmp     ($FD),y
        beq     store_pos
        lda     #$71
        cmp     ($FD),y
        beq     store_pos
        lda     #$72
        cmp     ($FD),y
        beq     store_pos
        jmp     L1A79

store_pos:
        lda     $FD
        sta     $FB
        lda     $FE
        sta     $FC
L1A79:  lda     #$73
        ldy     #$00
        sta     ($FB),y
        ldx     $0334
        dex
        lda     $FB
        sta     $0342,x
        inx
        lda     $FC
        sta     $0342,x
        inx
        cpx     #$06
        bne     L1AA0
        ldx     #$00
        stx     $0334
        cli
        rts
L1AA0:  stx     $0334
        jmp     L1A53

L1B15:  lda     $0340
        sta     $FB
        sta     $FD
        lda     $0341
        sta     $FC
        sta     $FE
        ldy     #$00
        lda     #$73
        cmp     ($FB),y
        bne     L1B34
        lda     #$01
        sta     $90
        jmp     L1B5D

L1B34:  ldy     #$00
        lda     #$20
        sta     ($FB),y
        jsr     read_joy
        ldy     #$00
        lda     #$20
        cmp     ($FD),y
        beq     L1B53
        lda     #$73
        cmp     ($FD),y
        bne     L1B49
        lda     #$01
        sta     $90
L1B49:  lda     #$74
        cmp     ($FD),y
        bne     L1B5D
        lda     #$02
        sta     $90
L1B53:  lda     $FD
        sta     $FB
        lda     $FE
        sta     $FC
L1B5D:  lda     #$6F
        sta     ($FB),y
        lda     $FB
        sta     $0340
        lda     $FC
        sta     $0341
        rts

next_player_char:
        ldy     L1B5D+1
        iny
        cpy     #$73
        bne     L013E
        ldy     #$6F
L013E:  sty     L1B5D+1
        rts

play_music:
        ldy     $00
        beq     @next
        cpy     #$FF
        beq     @skip
        dey
        sty     $00
        rts
@next:  lda     ($01),y
        sta     VICCRC
        sta     VICCRB
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

set_tune1:
        lda     #<tune1
        sta     $01
        lda     #>tune1
        sta     $02
        lda     #$00
        sta     $00
        rts

set_tune2:
        lda     #<tune2
        sta     $01
        lda     #>tune2
        sta     $02
        lda     #$00
        sta     $00
        rts

set_tune3:
        lda     #<tune3
        sta     $01
        lda     #>tune3
        sta     $02
        lda     #$00
        sta     $00
        rts

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
