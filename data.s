; da65 V2.17 - Git d52d986a
; Created:    2018-09-21 22:13:49
; Input file: data.bin
; Page:       1


        .setcpu "6502"

L010E           := $010E
LEABF           := $EABF

.segment        "raw": absolute

        .byte   $00,$15,$C1,$0A,$00,$01,$C1,$0A
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
        .byte   $00,$01,$01,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$BD,$0A,$00,$01,$BD,$0A
        .byte   $C1,$0A,$C8,$0A,$CB,$14,$C8,$14
        .byte   $BD,$0A,$00,$01,$BD,$0A,$C1,$0A
        .byte   $C8,$0A,$D1,$14,$C8,$14,$BD,$0A
        .byte   $00,$01,$BD,$0A,$C1,$0A,$C8,$0A
        .byte   $00,$01,$C8,$0F,$C1,$05,$BD,$0A
        .byte   $B5,$0A,$AC,$0A,$00,$01,$AC,$0A
        .byte   $B5,$0A,$00,$01,$B5,$0A,$AC,$14
        .byte   $00,$01,$01,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$BD,$0A,$00,$01,$BD,$0A
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
        .byte   $01,$00
L1798:  lda     $0335
        cmp     $00
        beq     L17A4
        inc     $00
        jmp     LEABF

L17A4:  ldy     #$00
        lda     ($01),y
        sta     $900C
        sta     $900B
        cmp     #$01
        beq     L17C6
        inc     $01
        lda     ($01),y
        sta     $0335
        sty     a:$00
        inc     $01
        lda     #$0F
        sta     $900E
        jmp     LEABF

L17C6:  sty     $00
        sty     $01
        jmp     LEABF

        sei
        lda     #$E7
        sta     $0314
        lda     #$17
        sta     $0315
        cli
        rts

        sei
        lda     #$BF
        sta     $0314
        lda     #$EA
        sta     $0315
        cli
        rts

        ldx     $0336
        inx
        cpx     #$04
        bne     L17F4
        jsr     L1B15
        ldx     #$00
L17F4:  stx     $0336
        jmp     L1798

        .byte   $00,$00,$00,$00,$00,$A0,$3C,$66
        .byte   $6E,$6E,$60,$62,$3C,$00,$18,$3C
        .byte   $66,$7E,$66,$66,$66,$00,$7C,$66
        .byte   $66,$7C,$66,$66,$7C,$00,$3C,$66
        .byte   $60,$60,$60,$66,$3C,$00,$78,$6C
        .byte   $66,$66,$66,$6C,$78,$00,$7E,$60
        .byte   $60,$78,$60,$60,$7E,$00,$7E,$60
        .byte   $60,$78,$60,$60,$60,$00,$3C,$66
        .byte   $60,$6E,$66,$66,$3C,$00,$66,$66
        .byte   $66,$7E,$66,$66,$66,$00,$3C,$18
        .byte   $18,$18,$18,$18,$3C,$00,$1E,$0C
        .byte   $0C,$0C,$0C,$6C,$38,$00,$66,$6C
        .byte   $78,$70,$78,$6C,$66,$00,$60,$60
        .byte   $60,$60,$60,$60,$7E,$00,$63,$77
        .byte   $7F,$6B,$63,$63,$63,$00,$66,$76
        .byte   $7E,$7E,$6E,$66,$66,$00,$3C,$66
        .byte   $66,$66,$66,$66,$3C,$00,$7C,$66
        .byte   $66,$7C,$60,$60,$60,$00,$3C,$66
        .byte   $66,$66,$66,$3C,$0E,$00,$7C,$66
        .byte   $66,$7C,$78,$6C,$66,$00,$3C,$66
        .byte   $60,$3C,$06,$66,$3C,$00,$7E,$18
        .byte   $18,$18,$18,$18,$18,$00,$66,$66
        .byte   $66,$66,$66,$66,$3C,$00,$66,$66
        .byte   $66,$66,$66,$3C,$18,$00,$63,$63
        .byte   $63,$6B,$7F,$77,$63,$00,$66,$66
        .byte   $3C,$18,$3C,$66,$66,$00,$66,$66
        .byte   $66,$3C,$18,$18,$18,$00,$7E,$06
        .byte   $0C,$18,$30,$60,$7E,$00,$3C,$30
        .byte   $30,$30,$30,$30,$3C,$00,$0C,$12
        .byte   $30,$7C,$30,$62,$FC,$00,$3C,$0C
        .byte   $0C,$0C,$0C,$0C,$3C,$00,$00,$18
        .byte   $3C,$7E,$18,$18,$18,$18,$00,$10
        .byte   $30,$7F,$7F,$30,$10,$FF,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$18,$18
        .byte   $18,$18,$00,$00,$18,$00,$66,$66
        .byte   $66,$00,$00,$00,$00,$00,$66,$66
        .byte   $FF,$66,$FF,$66,$66,$00,$18,$3E
        .byte   $60,$3C,$06,$7C,$18,$00,$62,$66
        .byte   $0C,$18,$30,$66,$46,$00,$3C,$66
        .byte   $3C,$38,$67,$66,$3F,$00,$06,$0C
        .byte   $18,$00,$00,$00,$00,$00,$0C,$18
        .byte   $30,$30,$30,$18,$0C,$00,$30,$18
        .byte   $0C,$0C,$0C,$18,$30,$00,$00,$66
        .byte   $3C,$FF,$3C,$66,$00,$00,$00,$18
        .byte   $18,$7E,$18,$18,$00,$00,$00,$00
        .byte   $00,$00,$00,$18,$18,$30,$00,$00
        .byte   $00,$7E,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$18,$18,$00,$00,$03
        .byte   $06,$0C,$18,$30,$60,$00,$3C,$66
        .byte   $6E,$76,$66,$66,$3C,$00,$18,$18
        .byte   $38,$18,$18,$18,$7E,$00,$3C,$66
        .byte   $06,$0C,$30,$60,$7E,$00,$3C,$66
        .byte   $06,$1C,$06,$66,$3C,$00,$06,$0E
        .byte   $1E,$66,$7F,$06,$06,$00,$7E,$60
        .byte   $7C,$06,$06,$66,$3C,$00,$3C,$66
        .byte   $60,$7C,$66,$66,$3C,$00,$7E,$66
        .byte   $0C,$18,$18,$18,$18,$00,$3C,$66
        .byte   $66,$3C,$66,$66,$3C,$00,$3C,$66
        .byte   $66,$3E,$06,$66,$3C,$00,$00,$00
        .byte   $08,$00,$00,$08,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$0E,$18
        .byte   $30,$60,$30,$18,$0E,$00,$00,$00
        .byte   $7E,$00,$7E,$00,$00,$00,$70,$18
        .byte   $0C,$06,$0C,$18,$70,$00,$3C,$66
        .byte   $06,$0C,$18,$00,$18,$00
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
        sec
        lda     $FB
        sbc     #$1A
        sta     $FD
        lda     $FC
        sbc     #$00
        sta     $FE
        rts

L1A29:  clc
        lda     $FB
        adc     #$01
        sta     $FD
        lda     $FC
        adc     #$00
        sta     $FE
        rts

L1A37:  sec
        lda     $FB
        sbc     #$01
        sta     $FD
        lda     $FC
        sbc     #$00
        sta     $FE
        rts

L1A45:  clc
        lda     $FB
        adc     #$1A
        sta     $FD
        lda     $FC
        adc     #$00
        sta     $FE
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
        jmp     L010E

        nop
        lda     $FD
        sta     $FB
        lda     $FE
        sta     $FC
        lda     #$73
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
        sty     $9113
        lda     #$7F
        sta     $9122
        lda     #$20
        sta     ($FB),y
        lda     $9120
        and     #$80
        beq     L1B05
        lda     #$FF
        sta     $9122
        nop
        nop
        nop
        nop
        nop
        lda     $911F
        and     #$04
        beq     L1ADB
        lda     $911F
        and     #$08
        beq     L1AE9
        lda     $911F
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
        adc     #$1A
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

        nop
        nop
L1B15:  lda     $0340
        sta     $FB
        sta     $FD
        lda     $0341
        sta     $FC
        sta     $FE
        nop
        nop
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
        lda     #$6F
        sta     ($FB),y
        lda     $FB
        sta     $0340
        lda     $FC
        sta     $0341
        lda     #$80
        sta     $9113
        lda     #$FF
        sta     $9122
        rts

        .byte   $EA,$EA,$78,$FC,$B4,$FC,$78,$48
        .byte   $24,$63,$3C,$7E,$5A,$7E,$3C,$24
        .byte   $24,$66,$1E,$3F,$2D,$3F,$1E,$12
        .byte   $24,$C6,$3C,$7E,$5A,$7E,$3C,$24
        .byte   $24,$66,$00,$3C,$7E,$5A,$7E,$42
        .byte   $7E,$5A,$10,$10,$08,$10,$18,$3C
        .byte   $3C,$18,$18,$3D,$7F,$FF,$7F,$7F
        .byte   $3F,$7E,$10,$B8,$FC,$FE,$FC,$F8
        .byte   $FC,$7E,$7E,$FF,$3F,$3F,$7F,$3F
        .byte   $17,$02,$7E,$FC,$FE,$FC,$FE,$FE
        .byte   $F8,$20,$00,$81,$D3,$FF,$FF,$FF
        .byte   $FB,$60,$50,$F1,$FB,$FF,$FF,$BF
        .byte   $05,$00,$7E,$7C,$3F,$7E,$1C,$7E
        .byte   $FC,$7C,$7C,$3E,$1C,$3F,$3E,$FF
        .byte   $FE,$7E,$42,$F7,$FF,$FF,$FF,$FF
        .byte   $B5,$20,$7E,$7F,$3E,$1C,$3E,$3F
        .byte   $7C,$7E,$08,$1C,$7E,$FF,$7C,$3E
        .byte   $0C,$00
