;;;
;;; Bomb Jack Revisited
;;;
;;; 1985,2018 ops
;;;

100 goto1050

;; Move the "smart" ghost
110 hh=(hp-sc-1)/26:ha=hh-int(hh)
130 pp=(fnn(832)-sc-1)/26:pa=pp-int(pp)
140 a=0:ifrnd(0)>.5then180
150 ifhh<ppandpeek(hp+26)<117thenh=26:return
160 ifhh>ppandpeek(hp-26)<117thenh=-26:return
170 ifathenh=0:return
180 ifha<paandpeek(hp+1)<117thenh=1:return
190 ifha>paandpeek(hp-1)<117thenh=-1:return
200 a=1:goto150

;; Set a new bomb
210 poke144,0:print"{home}{10 rght}bombs:"c"
215 w=int(rnd(0)*726)+sc+52:ifpeek(w)<>32then215
220 return

;; Game loop
230 ti$="000000":hp=sc+778:c=0:gosub1040
240 gosub210:poke888,7
250 r=int(60-ti/60):ifr<0then550
260 print"{home}time:"r"{left} "
270 ifr<10thenpoke36877,253
280 if(peek(37137)and32)=0thengosub910
290 ifpeek(0)=255thensys(ml+03),2
300 ifst=1then550
310 ifst=2thenj=1:poke36874,250:c=c+1:gosub210:ifc=9then360
320 ifjthenj=j+1:ifj>3thenj=0:poke36874,0
330 gosub110:hp=hp+h
340 pokehp,115::ifh<>0thenpokehp-h,32
350 pokew,116:goto250

;; Map completed. Load next
360 poke888,1:fori=0to500:next
370 poke36874,0:poke36877,0
380 ifpeek(0)<>255then380
390 poke646,(rnd(0)*6)+2:sys(ml+00):print"{wht}"
400 sys(ml+03),1
410 ifpeek(0)<>255then410
420 poke888,0
430 a$="                         "
440 a$=a$+"loading...            "
450 a$=a$+"time: 60  bombs: 0  men:"+str$(el)+" "
460 a=len(a$)-22
470 fori=1to18:print"{home}"mid$(a$,i,26):gosub990:next
480 l=l+1:ifl>8thenl=1
490 l$=str$(l):l$=mid$(l$,2)
500 ifl<10thenl$="0"+l$
510 l$="map"+l$+".bin"
520 sys(ml+09),l$,dn
530 fori=18toa-4:print"{home}"mid$(a$,i,26):gosub990:next
540 sys(ml+06):goto230

;; Death of player
550 poke888,1:poke36874,0:poke36877,0
560 gosub1210:ifr<0thengosub1000:goto580
570 ifpeek(0)<>255then570
580 poke888,0
590 el=el-1:ifel=0then620
600 print"{home}time: 60  bombs: 0  men:"el
610 sys(ml+03),0:goto230

;; Game over
620 a$="                         "
630 a$=a$+"if you want to play a new game "
640 a$=a$+"press f1.   press f3 to quit the game.   "
650 a$=a$+"bomb jack was programmed by "
660 a$=a$+"ops in 1985. thanks to s.l. for the loading picture "
670 a$=a$+"and catchy tunes. the game was updated in 2018 by ops. "
680 a$=a$+"   github.com/ops/bjr/ "
690 a=len(a$):gosub780:gosub1210:poke888,5
700 fori=1toa
710   print"{home}  "mid$(a$,i,22)
720   pokew,116
730   forj=0to60:next
740   ifpeek(197)=39then870
750   ifpeek(197)=47thensys64802
760   ifpeek(0)=255thensys(ml+03),2
770 next:goto700

;; Display "Game Over" text and play a sound
780 fori=1to300:next
790 fori=15to0step-.5
800   forj=202to200step-1
810     poke36874,j:poke646,jand5
820     print"{home}        game over         "
830   next
840   poke36878,i
850 next
860 poke36874,0:poke36878,15:print"{wht}":return

;; Set up a new game
870 l=0:el=8:poke888,0:poke0,255:gosub1230:sys(ml+00)
880 print"{2 down}{yel}          press fire when ready!"
890 if(peek(37137)and32)=32then890
900 i=fre(0):goto360

;; Pause mode
910 poke888,0:b$=ti$:gosub1230
920 a$="                      pause mode...         "
930 a=len(a$):
940 fori=1to15:print"{home}"mid$(a$,i,26):gosub990:next
950 if(peek(37137)and32)=32then950
960 fori=15to37:print"{home}"mid$(a$,i,26):gosub990:next
970 ti$=b$:print"{home}{10 rght}bombs:"c" men:"el
980 poke888,7:return

;; Sound effect during text scroll
990 forj=0to7:poke36874,j+128:next:poke36874,0:return

;; The bomb explodes!
1000 poke36879,24:poke888,0:gosub1230
1010 poke36877,140:poke36879,8:poke36874,128
1020 fori=15to0step-.05:poke36878,i:next
1030 gosub1230:poke36878,15:return

1040 restore:fori=0to7:reada:poke832+i,a:next:return

;; Initial setup
1050 clr:poke648,28
1060 deffnn(x)=peek(x)+256*peek(x+1)
1070 poke36864,8:poke36865,27:poke36866,26:poke36867,62:poke36869,254
1080 poke36879,8:poke36878,15
1090 ml=9216:sc=7168:el=8:dn=peek(186)
1110 gosub1140
1120 poke888,0:poke0,255
1125 poke828,111:poke829,1:poke830,1:poke831,1
1130 sys(ml+12):sys(ml+00):goto360

;; Title screen
1140 sys(ml+00)
1150 printtab(159)"{yel}bomb jack revisited"
1160 printtab(12)"{yel}(c)  1985,2018 by ops"
1170 printtab(73)"{wht}github.com/ops/bjr/"
1180 printtab(93)"{grn}press fire to start"
1190 if(peek(37137)and32)=32then1190
1200 return

;; Clear ghosts, player and the bomb
1210 pokefnn(832),32:pokefnn(834),32:pokefnn(836),32:pokefnn(838),32:pokew,32:pokehp,32
1220 return

;; Silence sounds
1230 fori=0to3:poke36874+i,0:next:return

1240 data53,28,76,28,243,30,10,31
