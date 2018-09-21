; da65 V2.17 - Git d52d986a
; Created:    2018-09-21 21:42:47
; Input file: loader.prg
; Page:       1


        .setcpu "6502"

L010E           := $010E
MAIN2           := $C483
CLRSCR          := $E55F
SETLFS          := $FFBA                        ; $FFBA: Set LA, FA, SA
SETNAM          := $FFBD                        ; $FFBD: Set length and FN address
LOAD            := $FFD5                        ; $FFD5: Load from file

.segment        "raw": absolute

        .byte   $01,$04,$0B,$04,$FF,$FF,$9E,$31
        .byte   $30,$34,$30,$00,$00,$00,$00,$00
        .byte   $00
        jsr     CLRSCR
        ldx     #$10
        lda     #$00
L0417:  sta     $0FFF,x
        dex
        bne     L0417
        lda     #$0C
        sta     $9000
        lda     #$2B
        sta     $9001
        lda     #$96
        sta     $9002
        lda     #$15
        sta     $9003
        lda     #$FC
        sta     $9005
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
        sta     $900F
        lda     #$97
        sta     $900E
        lda     #$0A
        sta     $0286
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        lda     #$01
        ldx     #$01
        ldy     #$FF
        jsr     SETLFS
        lda     #$00
        jsr     SETNAM
        lda     #$00
        ldx     #$FF
        ldy     #$FF
        jsr     LOAD
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

        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
L04AF:  nop
        lda     #$00
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

        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
