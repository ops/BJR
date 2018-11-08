100 goto830

110 sys(ml+24)
120 ifst=1then510
130 ifst=2thenf=1:poke36874,250:pokew,32:c=c+1:gosub150:ifc=2thenc=0:goto400
140 poke144,0:sys(ml+15):goto370

; Set a new bomb
150 w=int(rnd(0)*726)+sc+52:ifpeek(w)<>32then150
160 print"{home}{10 rght}bombs:"c"{left} ":pokew,116:return

170 zx=0:pp=fnn(832)
175 ha=(hp-sc-1)/26-int((hp-sc-1)/26)
180 pa=(pp-sc-1)/26-int((pp-sc-1)/26)
200 rd=rnd(0):ifrd>.5then250
220 ifhp<ppandpeek(hp+26)<117thenh=26:return
230 ifhp>ppandpeek(hp-26)<117thenh=-26:return
240 ifzxthenh=0:return
250 ifpa<haandpeek(hp-1)<117thenh=-1:return
260 ifpa>haandpeek(hp+1)<117thenh=1:return
270 zx=1:goto220

; Game loop
290 ti$="000000":hp=sc+778
300 r=int(t-ti/60):ifr<0then510
310 print"{home}time:"r"{left} "
315 sys(ml+12):sys(ml+0):pokew,116
320 ifr<9thenpoke36877,253
330 if(peek(37137)and32)=0then760
340 iffthenk=k+1:ifk=3thenk=0:f=0:poke36874,0
350 ifqandti>1087thensys(ml+18):q=0:sys(ml+03),2:sys(ml+15)
360 ifst<>0then110
370 gosub170:hp=hp+h
380 pokehp,115::ifh<>0thenpokehp-h,32
390 goto300

400 gosub1040
410 a$="                         "
411 a$=a$+"loading...            "
412 a$=a$+"time: 60  bombs: 0  men:"+str$(el)+" "
415 a=len(a$)-22
420 sys(ml+18)
425 poke646,(rnd(0)*6)+2:sys(ml+21):print"{wht}"
430 fori=1to18:print"{home}"mid$(a$,i,26):gosub920:next
435 l=l+1:ifl>8thenl=1
436 l$=str$(l):l$=mid$(l$,2)
437 ifl<10thenl$="0"+l$
438 l$="map"+l$+".bin"
444 sys(ml+09),l$,dn
445 gosub970
450 fori=18toa-4:print"{home}"mid$(a$,i,26):gosub920:next
480 sys(ml+06)
490 gosub150:sys(ml+15)
500 goto290

; Death of player
510 sys(ml+24):poke36874,0:poke36877,0:gosub1100:ifr<0thengosub930:goto530
520 ifpeek(36875)<>1then520
530 sys(ml+18)
535 el=el-1:ifel=0then580
540 poke36877,0:print"{home}time: 60  bombs: 0  men:"el
550 sys(ml+03),0
560 gosub970:poke144,0:q=1:c=0
570 gosub150:poke820,0:sys(ml+15):goto290

580 a$="                         "
585 a$=a$+"if you want to play a new game, please rewind "
590 a$=a$+"tape to '000' and then press f1.   "
600 a$=a$+"press f3 to quit the game.   "
610 a$=a$+"bomb jack was programmed by "
620 a$=a$+"ops in 1985. thanks to s.l. for the loading picture "
625 a=len(a$)
630 gosub1240:gosub1120
640 sys(ml+18):poke0,0:sys(ml+03),2:sys(ml+15):sys(ml+24)
650 pokehp,32:pokefnn(832),32
670 fori=1toa
675   print"{home}  "mid$(a$,i,22)
676   sys(ml+12):pokew,116
680   fort=0to60:next
690   ifpeek(197)=39then720
700   ifpeek(197)=47thensys64802
710 next:goto670

720 el=8:sys(ml+18):gosub1240:sys(ml+21)
730 print"    press play on tape{down}              and then fire!"
740 if(peek(37137)and32)=32then740
750 a$="":i=fre(0):goto400

760 a$="                      pause mode...         "
770 a=len(a$):b$=ti$:sys(ml+18):gosub1240
780 fori=1to15:print"{home}"mid$(a$,i,26):gosub920:next
790 if(peek(37137)and32)=32then790
800 fori=15to37:print"{home}"mid$(a$,i,26):gosub920:next
810 ti$=b$:print"{home}time:"int(t=ti/60)"  bombs:"c" men:"el
820 sys(ml+15):goto300

; Initial setup
830 clr:poke648,28
831 deffnn(x)=peek(x)+256*peek(x+1)
833 poke36864,8:poke36865,27:poke36866,26:poke36867,62:poke36869,254
836 poke36879,8:poke36878,15
840 ml=9216:sc=7168:t=60:el=8
845 dn=peek(186)
847 gosub980
850 sys(ml+21):sys(ml+03),2
910 goto400

; Sound during text scroll
920 forii=0to7:poke36874,ii+128:next:poke36874,0:return

; The bomb explodes!
930 poke36879,24:sys(ml+18):gosub1240
940 poke36877,140:poke36879,8:poke36874,128
950 fori=15to0step-.05:poke36878,i:next
960 gosub1240:poke36878,15:return

970 restore:fori=0to7:readaa:poke832+i,aa:next:aa=0:return

980 sys(ml+21)
990 printtab(159)"{yel}bomb jack revisited"
990 printtab(12)"{yel}(c)  1985,2018 by ops"
1000 printtab(73)"{wht}github.com/ops/bjr/"
1010 printtab(93)"{grn}press fire to start"
1020 if(peek(37137)and32)=32then1020
1030 print"{clr}{wht}":return

1040 poke822,0:poke36874,0:poke36877,0:ifpeek(36875)=0then1060
1050 ifpeek(36875)<>1then1050
1060 sys(ml+18):fori=0to400:next:gosub1240
1070 sys(ml+03),1:poke822,0:sys(ml+15):sys(ml+24)
1080 ifpeek(36875)<>1then1080
1090 sys(ml+18):sys(ml+03),2:return

1100 pokefnn(832),32:pokefnn(834),32:pokefnn(836),32:pokefnn(838),32:pokew,32:pokehp,32
1110 return

1120 c$="{home}        game over         "
1150 fori=1to300:next
1160 fori=15to0step-.5
1170   forj=202to200step-1
1180     poke36874,j
1190     poke646,jand5:printc$
1200   next
1210 poke36878,i
1220 next
1230 poke36874,0:poke36878,15:print"{wht}":return

; Silence sounds
1240 fori=0to3:poke36874+i,0:next:return

1250 data53,28,76,28,243,30,10,31
