100 goto940

;; Set a new bomb
110 w=int(rnd(0)*726)+sc+52:ifpeek(w)<>32then110
120 print"{home}{10 rght}bombs:"c"{left} ":return

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
230 ti$="000000":hp=sc+778
240 r=int(t-ti/60):ifr<1then580
250 print"{home}time:"r"{left} "
260 sys(ml+12):sys(ml+0)
270 ifr<9thenpoke36877,253
280 if(peek(37137)and32)=0then870
290 ifqandti>1087thensys(ml+18):q=0:sys(ml+03),2:sys(ml+15)
300 ifst=1then580
310 ifst=2thenf=1:poke144,0:poke36874,250:gosub110:c=c+1:ifc=2thenc=0:goto360
320 iffthenf=f+1:iff=4thenf=0:poke36874,0
330 gosub130:hp=hp+h
340 pokehp,115::ifh<>0thenpokehp-h,32
350 pokew,116:goto240

360 fori=0to500:next
370 poke822,0:poke36874,0:poke36877,0:ifpeek(36875)=0then390
380 ifpeek(36875)<>1then380
390 gosub1280
400 poke646,(rnd(0)*6)+2:sys(ml+21):print"{wht}"
410 sys(ml+03),1:sys(ml+24)
420 ifpeek(36875)<>1then420
430 sys(ml+18):sys(ml+03),2
440 a$="                         "
450 a$=a$+"loading...            "
460 a$=a$+"time: 60  bombs: 0  men:"+str$(el)+" "
470 a=len(a$)-22
480 fori=1to18:print"{home}"mid$(a$,i,26):gosub1030:next
490 l=l+1:ifl>8thenl=1
500 l$=str$(l):l$=mid$(l$,2)
510 ifl<10thenl$="0"+l$
520 l$="map"+l$+".bin"
530 sys(ml+09),l$,dn
540 fori=18toa-4:print"{home}"mid$(a$,i,26):gosub1030:next
550 gosub1080:gosub110
560 sys(ml+06):sys(ml+15)
570 goto230

;; Death of player
580 sys(ml+24):poke36874,0:poke36877,0:gosub1160:ifr<0thengosub1040:goto600
590 ifpeek(36875)<>1then590
600 sys(ml+18)
610 el=el-1:ifel=0then660
620 poke36877,0:print"{home}time: 60  bombs: 0  men:"el
630 sys(ml+03),0
640 gosub1080:gosub110
650 poke144,0:q=1:c=0:poke820,0:sys(ml+15):goto230

660 a$="                         "
670 a$=a$+"if you want to play a new game, please rewind "
680 a$=a$+"tape to '000' and then press f1.   "
690 a$=a$+"press f3 to quit the game.   "
700 a$=a$+"bomb jack was programmed by "
710 a$=a$+"ops in 1985. thanks to s.l. for the loading picture "
720 a=len(a$)
730 gosub1280:gosub1180
740 sys(ml+03),2:sys(ml+24)
750 pokehp,32:pokefnn(832),32
760 fori=1toa
770   print"{home}  "mid$(a$,i,22)
780   sys(ml+12):pokew,116
790   fort=0to60:next
800   ifpeek(197)=39then830
810   ifpeek(197)=47thensys64802
820 next:goto760

830 el=8:sys(ml+18):gosub1280:sys(ml+21)
840 print"    press play on tape{down}              and then fire!"
850 if(peek(37137)and32)=32then850
860 a$="":i=fre(0):goto360

870 a$="                      pause mode...         "
880 a=len(a$):b$=ti$:sys(ml+18):gosub1280
890 fori=1to15:print"{home}"mid$(a$,i,26):gosub1030:next
900 if(peek(37137)and32)=32then900
910 fori=15to37:print"{home}"mid$(a$,i,26):gosub1030:next
920 ti$=b$:print"{home}time:"int(t=ti/60)"  bombs:"c" men:"el
930 sys(ml+15):goto240

;; Initial setup
940 clr:poke648,28
950 deffnn(x)=peek(x)+256*peek(x+1)
960 poke36864,8:poke36865,27:poke36866,26:poke36867,62:poke36869,254
970 poke36879,8:poke36878,15
980 ml=9216:sc=7168:t=60:el=8
990 dn=peek(186)
1000 gosub1090
1010 sys(ml+21):sys(ml+03),2
1020 goto360

;; Sound during text scroll
1030 forj=0to7:poke36874,j+128:next:poke36874,0:return

;; The bomb explodes!
1040 poke36879,24:sys(ml+18):gosub1280
1050 poke36877,140:poke36879,8:poke36874,128
1060 fori=15to0step-.05:poke36878,i:next
1070 gosub1280:poke36878,15:return

1080 restore:fori=0to7:reada:poke832+i,a:next:return

1090 sys(ml+21)
1100 printtab(159)"{yel}bomb jack revisited"
1110 printtab(12)"{yel}(c)  1985,2018 by ops"
1120 printtab(73)"{wht}github.com/ops/bjr/"
1130 printtab(93)"{grn}press fire to start"
1140 if(peek(37137)and32)=32then1140
1150 return

1160 pokefnn(832),32:pokefnn(834),32:pokefnn(836),32:pokefnn(838),32:pokew,32:pokehp,32
1170 return

1180 c$="{home}        game over         "
1190 fori=1to300:next
1200 fori=15to0step-.5
1210   forj=202to200step-1
1220     poke36874,j
1230     poke646,jand5:printc$
1240   next
1250 poke36878,i
1260 next
1270 poke36874,0:poke36878,15:print"{wht}":return

;; Silence sounds
1280 fori=0to3:poke36874+i,0:next:return

1290 data53,28,76,28,243,30,10,31
