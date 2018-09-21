; da65 V2.17 - Git d52d986a
; Created:    2018-09-21 21:14:24
; Input file: 270.bin
; Page:       1


        .setcpu "6502"

L1A53           := $1A53
L1A71           := $1A71
L1A79           := $1A79
SETLFS          := $FFBA                        ; $FFBA: Set LA, FA, SA
SETNAM          := $FFBD                        ; $FFBD: Set length and FN address
LOAD            := $FFD5                        ; $FFD5: Load from file

.segment        "raw": absolute

        .byte   $0E,$01
        bne     L0113
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

        ldy     $1B5E
        iny
        cpy     #$73
        bne     L013E
        ldy     #$6F
L013E:  sty     $1B5E
        rts

        lda     #$1A
        sta     $FB
        lda     #$94
        sta     $FC
L014A:  ldy     #$00
        lda     $033F
L014F:  sta     ($FB),y
        iny
        bne     L014F
        inc     $FC
        lda     #$98
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
        lda     #$20
        cmp     $FC
        bne     L015D
        rts

        lda     #$01
        tax
        ldy     #$FF
        jsr     SETLFS
        lda     #$00
        jsr     SETNAM
        lda     #$00
        ldx     #$FF
        ldy     #$FF
        jsr     LOAD
        rts

        sei
        jsr     L1A53
        cli
        rts

