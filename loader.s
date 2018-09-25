;;;
;;;
;;;

L010E           := $010E
MAIN2           := $C483



VICCR0 := VIC+$0
VICCR1 := VIC+$1
VICCR2 := VIC+$2
VICCR3 := VIC+$3
VICCR4 := VIC+$4
VICCR5 := VIC+$5

	.setcpu "6502"

        .include "cbm_kernal.inc"
        .include "vic20.inc"

        .export  __LOADADDR__: absolute = 1
        .segment "LOADADDR"
        .addr *+2

        ; The following symbol is used by linker config to force the module
        ; to get included into the output file
        .export __EXEHDR__: absolute = 1
	.segment        "EXEHDR"

        .addr   Next
        .word   .version        ; Line number
        .byte   $9E             ; SYS token
;       .byte   <(((Start / 10000) .mod 10) + '0')
        .byte   <(((Start /  1000) .mod 10) + '0')
        .byte   <(((Start /   100) .mod 10) + '0')
        .byte   <(((Start /    10) .mod 10) + '0')
        .byte   <(((Start /     1) .mod 10) + '0')
        .byte   $00             ; End of BASIC line
Next:   .word   0               ; BASIC end marker
Start:

; If the start address is larger than 4 digits, the header generated above
; will not contain the highest digit. Instead of wasting one more digit that
; is almost never used, check it at link time and generate an error so the
; user knows something is wrong.

.assert (Start < 10000), error, "Start address too large for generated BASIC stub"

        .segment "CODE"

        jsr     CLRSCR
        ldx     #$10
        lda     #$00
L0417:  sta     $0FFF,x
        dex
        bne     L0417

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

        ldy     #$00
        lda     #$00
        sta     $FB
        sta     $FD
        lda     #$1E
        sta     $FC
        lda     #$96
        sta     $FE
L0446:  lda     #$00
        sta     ($FB),y
        lda     #$0A
        sta     ($FD),y
        iny
        bne     L0446
        inc     $FC
        inc     $FE
        lda     #$20
        cmp     $FC
        bne     L0446

        lda     #$E8
        sta     VIC_COLOR
        lda     #$97
        sta     $900E
        lda     #$0A
        sta     CHARCOLOR

        lda     #$01
        ldx     $ba
        ldy     #$FF
        jsr     SETLFS
        lda     #pic_end-pic
	ldx     #<pic
	ldy     #>pic
        jsr     SETNAM
        lda     #$00
        ldx     #$FF
        ldy     #$FF
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

pic:	.byte "picture.bin"
pic_end:
