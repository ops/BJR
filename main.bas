100 goto890

;; Set a new bomb
110 poke144,0:print"{home}{10 rght}bombs:"c"{left} "
115 w=int(rnd(0)*726)+sc+52:ifpeek(w)<>32then115
120 return

;; Move the "smart" ghost
130 zx=0
140 hh=(hp-sc-1)/26:ha=hh-int(hh)
150 pp=(fnn(832)-sc-1)/26:pa=pp-int(pp)
160 ifrnd(0)>.5then200
170 ifhh<ppandpeek(hp+26)<117thenh=26:return
180 ifhh>ppandpeek(hp-26)<117thenh=-26:return
190 ifzxthenh=0:return
200 ifha<paandpeek(hp+1)<117thenh=1:return
210 ifha>paandpeek(hp-1)<117thenh=-1:return
220 zx=1:goto170

;; Game loop
230 ti$="000000":hp=sc+778:c=0:gosub1040
240 gosub110:poke888,7
250 r=int(t-ti/60):ifr<0then550
260 print"{home}time:"r"{left} "
270 ifr<10thenpoke36877,253
280 if(peek(37137)and32)=0thengosub810
290 ifpeek(0)=255thensys(ml+03),2
300 ifst=1then550
310 ifst=2thenj=1:poke36874,250:c=c+1:gosub110:ifc=8then360
320 ifjthenj=j+1:ifj>3thenj=0:poke36874,0
330 gosub130:hp=hp+h
340 pokehp,115::ifh<>0thenpokehp-h,32
350 pokew,116:goto250

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
560 gosub1120:ifr<0thengosub1000:goto580
570 ifpeek(0)<>255then570
580 poke888,0
590 el=el-1:ifel=0then620
600 print"{home}time: 60  bombs: 0  men:"el
610 sys(ml+03),0:goto230

620 a$="                         "
630 a$=a$+"if you want to play a new game "
640 a$=a$+"press f1.   press f3 to quit the game.   "
660 a$=a$+"bomb jack was programmed by "
670 a$=a$+"ops in 1985. thanks to s.l. for the loading picture "
672 a$=a$+"and catchy tunes. the game was updated in 2018 by ops. "
674 a$=a$+"   github.com/ops/bjr/ "
680 a=len(a$):gosub1140:gosub1120:poke888,5
690 fori=1toa
700   print"{home}  "mid$(a$,i,22)
710   pokew,116
720   forj=0to60:next
730   ifpeek(197)=39then770
740   ifpeek(197)=47thensys64802
750   ifpeek(0)=255thensys(ml+03),2
760 next:goto690

770 l=0:el=8:poke888,0:poke0,255:gosub1240:sys(ml+00)
780 print"{2 down}{yel}          press fire when ready!"
790 if(peek(37137)and32)=32then790
800 i=fre(0):goto360

810 poke888,0:b$=ti$:gosub1240
820 a$="                      pause mode...         "
830 a=len(a$):
840 fori=1to15:print"{home}"mid$(a$,i,26):gosub990:next
850 if(peek(37137)and32)=32then850
860 fori=15to37:print"{home}"mid$(a$,i,26):gosub990:next
870 ti$=b$:print"{home}time:"int(t-ti/60)" bombs:"c" men:"el
880 poke888,7:return

;; Initial setup
890 clr:poke648,28
900 deffnn(x)=peek(x)+256*peek(x+1)
910 poke36864,8:poke36865,27:poke36866,26:poke36867,62:poke36869,254
920 poke36879,8:poke36878,15
930 ml=9216:sc=7168:t=60:el=8
940 dn=peek(186)
950 gosub1050
960 poke888,0:poke0,255
970 sys(ml+12):sys(ml+00)
980 goto360

;; Sound during text scroll
990 forj=0to7:poke36874,j+128:next:poke36874,0:return

;; The bomb explodes!
1000 poke36879,24:poke888,0:gosub1240
1010 poke36877,140:poke36879,8:poke36874,128
1020 fori=15to0step-.05:poke36878,i:next
1030 gosub1240:poke36878,15:return

1040 restore:fori=0to7:reada:poke832+i,a:next:return

1050 sys(ml+00)
1060 printtab(159)"{yel}bomb jack revisited"
1070 printtab(12)"{yel}(c)  1985,2018 by ops"
1080 printtab(73)"{wht}github.com/ops/bjr/"
1090 printtab(93)"{grn}press fire to start"
1100 if(peek(37137)and32)=32then1100
1110 return

1120 pokefnn(832),32:pokefnn(834),32:pokefnn(836),32:pokefnn(838),32:pokew,32:pokehp,32
1130 return

1140 b$="{home}        game over         "
1150 fori=1to300:next
1160 fori=15to0step-.5
1170   forj=202to200step-1
1180     poke36874,j
1190     poke646,jand5:printb$
1200   next
1210 poke36878,i
1220 next
1230 poke36874,0:poke36878,15:print"{wht}":return

;; Silence sounds
1240 fori=0to3:poke36874+i,0:next:return

1250 data53,28,76,28,243,30,10,31
