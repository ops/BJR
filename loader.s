;;;
;;; Bomb Jack Revisited
;;;
;;; 1985,2018 ops
;;;

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
	lda     #$1E		; set screen memory
	sta     $0288		; start to $1E00
        jsr     CLRSCR

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

	lda     #$00
	ldx     #$0e
	ldy     #$10
	jsr     fill_pages

        lda     #$0A
	ldx     #$02
        ldy     #$96
	jsr     fill_pages

	ldx     #$1E		; start of screen mem
	jsr     fill_chars

	; load loading picture
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

	; load ML routines
        lda     #$01
        ldx     $BA
        ldy     #$FF
        jsr     SETLFS
        lda     #ml_end-ml
	ldx     #<ml
	ldy     #>ml
        jsr     SETNAM
        lda     #$00
	jsr     LOAD

	; load character data
        lda     #$01
        ldx     $BA
        ldy     #$00
        jsr     SETLFS
        lda     #ml_end-ml
	ldx     #<ml
	ldy     #>ml
        jsr     SETNAM
        lda     #$00
	ldx     #<($3c00)
	ldy     #>($3c00)
	jsr     LOAD

	; load main program
        lda     #$01
        ldx     $BA
        ldy     #$FF
        jsr     SETLFS
        lda     #main_end-main
	ldx     #<main
	ldy     #>main
        jsr     SETNAM
        lda     #$00
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

ml:	.byte "ml.prg"
ml_end:

chr:	.byte "chr.bin"
chr_end:

main:	.byte "main.prg"
main_end:
