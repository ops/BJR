; da65 V2.17 - Git d52d986a
; Created:    2018-09-21 21:14:43
; Input file: 725.bin
; Page:       1


        .setcpu "6502"

CLRSCR          := $E55F

.segment        "raw": absolute

        .byte   $D5,$02
        jsr     CLRSCR
        lda     #$00
        sta     $FB
        lda     #$1C
        sta     $FC
        lda     #$00
        sta     $FD
        lda     #$94
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
        lda     #$20
        cmp     $FC
        bne     L02E8
        rts

