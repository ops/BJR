;;;
;;; Bomb Jack Revisited
;;;
;;; 1985,2018 ops
;;;

L010E           := $010E
MAIN2           := $C483

PTR1 = $FB

VICCR0 := VIC+$0
VICCR1 := VIC+$1
VICCR2 := VIC+$2
VICCR3 := VIC+$3
VICCR4 := VIC+$4
VICCR5 := VIC+$5
VICCR6 := VIC+$6
VICCR7 := VIC+$7
VICCR8 := VIC+$8
VICCR9 := VIC+$9
VICCRA := VIC+$A
VICCRB := VIC+$B
VICCRC := VIC+$C
VICCRD := VIC+$D
VICCRE := VIC+$E
VICCRF := VIC+$F


	.setcpu "6502"

        .include "cbm_kernal.inc"
        .include "vic20.inc"

        .export  __LOADADDR__: absolute = 1
        .segment "LOADADDR"
        .addr *+2

        .segment "CODE"

        lda     #$0A
        sta     CHARCOLOR
	lda     #$1E
	sta     $0288
        jsr     CLRSCR

	ldx     #$1E		; start of screen mem
	jsr     fill_chars

	lda     #$00
	ldx     #$0e
	ldy     #$10
	jsr     fill_pages

        lda     #$0A
	ldx     #$02
        ldy     #$96
	jsr     fill_pages

        lda     #$0C
        sta     VICCR0
        lda     #$2B
        sta     VICCR1
        lda     #$80+22
        sta     VICCR2
        lda     #$15 ;;(20<<1) | $01
        sta     VICCR3
        lda     #$FC
        sta     VICCR5
        lda     #$97
        sta     VICCRE
        lda     #$E8
        sta     VICCRF

        lda     #$01
        ldx     $BA
        ldy     #$FF
        jsr     SETLFS
        lda     #pic_end-pic
	ldx     #<pic
	ldy     #>pic
        jsr     SETNAM
        lda     #$00
	jsr     LOAD

	rts

        lda     #$01
        ldx     #$01
        ldy     #$FF
        jsr     SETLFS
        lda     #$00
        jsr     SETNAM

        ldx     #$3C
L049B:  lda     L04AF,x
        sta     $010D,x
        dex
        bne     L049B
        jmp     L010E

L04AF:  lda     #$00
        ldx     #$FF
        ldy     #$FF
        jsr     LOAD

        lda     $033D
        sta     $2B
        lda     $033E
        sta     $2C
        lda     $033F
        sta     $2D
        lda     $0340
        sta     $2E

        lda     #$52
        sta     $0277
        lda     #$D5
        sta     $0278
        lda     #$0D
        sta     $0279
        lda     #$03
        sta     $C6
        jsr     CLRSCR
        jmp     MAIN2


.proc fill_chars
	stx     PTR1+1
	ldx     #$00
	stx     PTR1
	clc
@loop1:	txa
	ldy     #$00
@loop2:	sta     (PTR1),y
	adc     #10
	iny
	cpy     #22
	bne     @loop2
	tya
	clc
	adc     PTR1
	sta     PTR1
	inx
	cpx     #10
	bne     @loop1
	rts
.endproc

.proc fill_pages
	;; A = fill value
	;; X = number of pages
	;; Y = start page
        sty     PTR1+1
        ldy     #$00
        sty     PTR1
@loop:  sta     (PTR1),y
        iny
        bne     @loop
        inc     PTR1+1
	dex
        bne     @loop
	rts
.endproc

pic:	.byte "picture.bin"
pic_end:
