;;;
;;; Bomb Jack Revisited
;;;
;;; 1985,2018 ops
;;;

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

        lda     #$07
        sta     CHARCOLOR

        jsr     CLRSCR

        lda     #$08
        sta     VIC_COLOR

        lda     #$01
        ldx     $BA
        ldy     #$FF
        jsr     SETLFS
        lda     #fname_end-fname
        ldx     #<fname
        ldy     #>fname
        jsr     SETNAM
        lda     #$00
        jsr     LOAD

        jmp     $2000

fname:  .byte "loader"
fname_end:
