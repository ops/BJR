;;;
;;;
;;;


PTR = $FB

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

        lda     #$E8
        sta     VIC_COLOR
        lda     #$97
        sta     $900E
        lda     #$0A
        sta     CHARCOLOR

        lda     #$01
        ldx     $ba
        ldy     #$00
        jsr     SETLFS
        lda     #pic_end-pic
	ldx     #<pic
	ldy     #>pic
        jsr     SETNAM
        lda     #$00
        ldx     #$00
        ldy     #$10
	jsr     LOAD

	jmp     $2000

pic:	.byte "picture.bin"
pic_end:
