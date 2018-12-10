;;;
;;; Bomb Jack Revisited
;;;
;;; 1985,2018 ops
;;;

COLUMNS = 22
ROWS    = 10

PTR1 = $FB
PTR2 = $FD

LNKPRG := $C533
STXTPT := $C68E
NEWSTT := $C7AE

        .setcpu "6502"

        .include "cbm_kernal.inc"
        .include "vic20.inc"

        .export  __LOADADDR__: absolute = 1
        .segment "LOADADDR"
        .addr *+2

        .segment "CODE"

        lda     #$0A
        sta     CHARCOLOR
        lda     #>$1E00         ; set screen memory
        sta     $0288           ; start to $1E00
        jsr     CLRSCR

        lda     #$0C
        sta     VIC_CR0
        lda     #$2B
        sta     VIC_CR1
        lda     #$80 | COLUMNS
        sta     VIC_CR2
        lda     #(ROWS << 1) | $01
        sta     VIC_CR3
        lda     #$FC
        sta     VIC_CR5
        lda     #$97
        sta     VIC_CRE
        lda     #$E8
        sta     VIC_CRF

        lda     #$00
        ldx     #$0E
        ldy     #$10
        jsr     fill_pages

        lda     #$0A
        ldx     #$02
        ldy     #$96
        jsr     fill_pages

        ldx     #$1E            ; start of screen mem
        jsr     fill_chars

        ; load loading picture
        lda     #$01
        ldx     DEVNUM
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
        ldx     DEVNUM
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
        ldx     DEVNUM
        ldy     #$00
        jsr     SETLFS
        lda     #chr_end-chr
        ldx     #<chr
        ldy     #>chr
        jsr     SETNAM
        lda     #$00            ; load temporarily
        ldx     #<($3C00)       ; to $3C00 so it doesn't
        ldy     #>($3C00)       ; overwrite loading picture
        jsr     LOAD

        ; load main program
        lda     #$01
        ldx     DEVNUM
        ldy     #$FF
        jsr     SETLFS
        lda     #main_end-main
        ldx     #<main
        ldy     #>main
        jsr     SETNAM
        lda     #$00
        jsr     LOAD

        stx     $2D
        sty     $2E
        ldy     #$00
        sty     $2C00
        lda     #<$2C01
        sta     $2B
        lda     #>$2C01
        sta     $2C

        ; copy character data to $1800 ->
        sty     PTR1
        sty     PTR2
        lda     #>$3C00
        sta     PTR1+1
        lda     #>$1800
        sta     PTR2+1
        ldx     #$04
@loop:  lda     (PTR1),y
        sta     (PTR2),y
        iny
        bne     @loop
        inc     PTR1+1
        inc     PTR2+1
        dex
        bne     @loop

        jsr     STXTPT
        jsr     LNKPRG
        jmp     NEWSTT

.proc fill_chars
        stx     PTR1+1
        ldx     #$00
        stx     PTR1
        clc
@loop1: txa
        ldy     #$00
@loop2: sta     (PTR1),y
        adc     #ROWS
        iny
        cpy     #COLUMNS
        bne     @loop2
        tya
        clc
        adc     PTR1
        sta     PTR1
        inx
        cpx     #ROWS
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

pic:    .byte "picture"
pic_end:

ml:     .byte "ml.prg"
ml_end:

chr:    .byte "chr.prg"
chr_end:

main:   .byte "main.prg"
main_end:
