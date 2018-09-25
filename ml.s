
MAP_X_SIZE = 26
;MAP_Y_SIZE = 25

VICCRA  := VIC+$0A
VICCRB  := VIC+$0B
VICCRC  := VIC+$0C
VICCRE  := VIC+$0E
LEABF   := $EABF

SCREEN_MEM := $1000
COLOR_MEM := $9400

        .setcpu "6502"

        .include "cbm_kernal.inc"
        .include "vic20.inc"

        .segment "LOADADDR"
        .export  __LOADADDR__: absolute = 1
        .addr *+2

        .segment "CODE"

	jmp L0134 ; 00 inc haamu 308
	jmp L0142 ; 03 set color mem 322
	jmp L015D ; 06 349
	jmp L0177 ; 09 375
	jmp L018E ; 12 398
	jmp L17CD ; 15 6093
	jmp L17DA ; 18 6106
	jmp L02D5 ; 21 725
	jmp set_irq2 ; 24
	jmp set_tune1 ; 27
	jmp set_tune2 ; 30
	jmp set_tune3 ; 33

L0142:  lda     #<(COLOR_MEM+$001A)
        sta     $FB
        lda     #>(COLOR_MEM+$001A)
        sta     $FC
L014A:  ldy     #$00
        lda     $033F
L014F:  sta     ($FB),y
        iny
        bne     L014F
        inc     $FC
        lda     #>(COLOR_MEM+$0400)
        cmp     $FC
        bne     L014A
        rts

L015D:  ldy     #$00
L015F:  lda     #$20
        cmp     ($FB),y
        bne     L0169
        lda     #$01
        sta     ($FD),y
L0169:  iny
        bne     L015F
        inc     $FC
        inc     $FE
        lda     #>(SCREEN_MEM+$0400)
        cmp     $FC
        bne     L015D
        rts

L0177:	lda     #$01
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

NAME:	.byte "map01.bin"
NAME_END:

L02D5:	jsr     CLRSCR
        lda     #$00
        sta     $FB
        lda     #>SCREEN_MEM
        sta     $FC
        lda     #$00
        sta     $FD
        lda     #>COLOR_MEM
        sta     $FE
L02E8:  ldy     #$00
L02EA:  lda     #$20
        sta     ($FB),y
        lda     #$01
        sta     ($FD),y
        iny
        bne     L02EA
        inc     $FC
        inc     $FE
        lda     #>(SCREEN_MEM + $0400)
        cmp     $FC
        bne     L02E8
        rts

L17CD:  sei
        lda     #<L17E7
        sta     IRQVec
        lda     #>L17E7
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

L17DA:	sei
        lda     #$BF
        sta     IRQVec
        lda     #$EA
        sta     IRQVec+1
        cli
        rts

L17E7:  ldx     $0336
        inx
        cpx     #$04
        bne     L17F4
        jsr     L1B15
        ldx     #$00
L17F4:  stx     $0336
        jsr     play_music
        jmp     LEABF

irq2:	jsr     play_music
        jmp     LEABF

L1A00:  ldy     #$00
        lda     #$20
        sta     ($FB),y
        jsr     L1A99
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        cmp     #$00
        beq     L1A29
        cmp     #$01
        beq     L1A37
        cmp     #$02
        beq     L1A45
        ; Move up
        sec
        lda     $FB
        sbc     #MAP_X_SIZE
        sta     $FD
        lda     $FC
        sbc     #$00
        sta     $FE
        rts

        ; Move right
L1A29:  clc
        lda     $FB
        adc     #$01
        sta     $FD
        lda     $FC
        adc     #$00
        sta     $FE
        rts

        ; Move left
L1A37:  sec
        lda     $FB
        sbc     #$01
        sta     $FD
        lda     $FC
        sbc     #$00
        sta     $FE
        rts

        ; Move down
L1A45:  clc
        lda     $FB
        adc     #MAP_X_SIZE
        sta     $FD
        lda     $FC
        adc     #$00
        sta     $FE
        rts

L018E:	sei
        jsr     L1A53
        cli
        rts

L1A53:  ldx     $0334
        lda     $0342,x
        sta     $FB
        inx
        lda     $0342,x
        sta     $FC
        stx     $0334
        jsr     L1A00
        ldy     #$00
        lda     #$20
        cmp     ($FD),y
L010E:  bne     L0113
L0110:  jmp     L1A71
L0113:  lda     #$74
        cmp     ($FD),y
        beq     L0110
        lda     #$6F
        cmp     ($FD),y
        beq     L0110
        lda     #$70
        cmp     ($FD),y
        beq     L0110
        lda     #$71
        cmp     ($FD),y
        beq     L0110
        lda     #$72
        cmp     ($FD),y
        beq     L0110
        jmp     L1A79

L1A71:  lda     $FD
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
        rts

L1A99:  lda     $9119
        adc     $9128
        rts

L1AA0:  stx     $0334
        jmp     L1A53

L1AA6:  ldy     #$00
        sty     VIA1_DDRA
        lda     #$7F
        sta     VIA2_DDRB
        lda     #$20
        sta     ($FB),y
        lda     VIA2_JOY
        and     #$80
        beq     L1B05
        lda     #$FF
        sta     VIA2_DDRB
        lda     VIA1_PA2
        and     #$04
        beq     L1ADB
        lda     VIA1_PA2
        and     #$08
        beq     L1AE9
        lda     VIA1_PA2
        and     #$10
        beq     L1AF7
        rts

L1ADB:  sec
        lda     $FB
        sbc     #$1A
        sta     $FD
        lda     $FC
        sbc     #$00
        sta     $FE
        rts

L1AE9:  clc
        lda     $FB
        adc     #$1A ;; xsize
        sta     $FD
        lda     $FC
        adc     #$00
        sta     $FE
        rts

L1AF7:  sec
        lda     $FB
        sbc     #$01
        sta     $FD
        lda     $FC
        sbc     #$00
        sta     $FE
        rts

L1B05:  clc
        lda     $FB
        adc     #$01
        sta     $FD
        lda     $FC
        adc     #$00
        sta     $FE
        rts

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
        jmp     L1B5B

L1B34:  jsr     L1AA6
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
        bne     L1B5B
        lda     #$02
        sta     $90
L1B53:  lda     $FD
        sta     $FB
        lda     $FE
        sta     $FC
L1B5B:  ldy     #$00
L1B5D:	lda     #$6F
        sta     ($FB),y
        lda     $FB
        sta     $0340
        lda     $FC
        sta     $0341
        lda     #$80
        sta     VIA1_DDRA
        lda     #$FF
        sta     VIA2_DDRB
        rts

L0134:	ldy     L1B5D+1
        iny
        cpy     #$73
        bne     L013E
        ldy     #$6F
L013E:  sty     L1B5D+1
        rts

play_music:
	ldy     $0000
	beq     @next
	cpy     #$FF
	beq     @skip
	dey
	sty     $0000
	rts
@next:  lda     ($01),y
        sta     VICCRC
        sta     VICCRB
	iny
        lda     ($01),y
        sta     $0000
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
	sta     $0000
	rts

set_tune2:
	lda     #<tune2
	sta     $01
	lda     #>tune2
	sta     $02
	lda     #$00
	sta     $0000
	rts

set_tune3:
	lda     #<tune3
	sta     $01
	lda     #>tune3
	sta     $02
	lda     #$00
	sta     $0000
	rts

tune1:	.byte   $C1,$0A,$00,$01,$C1,$0A
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

tune2:	.byte   $BD,$0A,$00,$01,$BD,$0A
        .byte   $C1,$0A,$C8,$0A,$CB,$14,$C8,$14
        .byte   $BD,$0A,$00,$01,$BD,$0A,$C1,$0A
        .byte   $C8,$0A,$D1,$14,$C8,$14,$BD,$0A
        .byte   $00,$01,$BD,$0A,$C1,$0A,$C8,$0A
        .byte   $00,$01,$C8,$0F,$C1,$05,$BD,$0A
        .byte   $B5,$0A,$AC,$0A,$00,$01,$AC,$0A
        .byte   $B5,$0A,$00,$01,$B5,$0A,$AC,$14
        .byte   $00,$01,$01,$ff

tune3:	.byte   $BD,$0A,$00,$01,$BD,$0A
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
