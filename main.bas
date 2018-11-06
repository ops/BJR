100 goto830

110 sys(ml+24)
120 ifst=1then510
130 ifst=2thenf=1:poke36874,250:pokew,32:c=c+1:gosub150:ifc=9thengoto400
140 poke144,0:sys(ml+15):goto370

150 w=int(rnd(0)*726)+sc+52:ifpeek(w)<>32then150
160 print"{home}{10 rght}bombs:"c"{left} ":pokew,116:return

170 ha=(hp-sc-1)/26-int((hp-sc-1)/26):pp=peek(832)+256*peek(833)
180 rd=rnd(0):pa=(pp-sc-1)/26-int((pp-sc-1)/26)
190 ifrd<=.5then220
200 ifrd>.5then250
210 return
220 ifhp<ppandpeek(hp+26)<117thenh=26:return
230 ifhp>ppandpeek(hp-26)<117thenh=-26:return
240 ifzxthen280
250 ifpa<haandpeek(hp-1)<117thenh=-1:return
260 ifpa>haandpeek(hp+1)<117thenh=1:return
270 zx=1:goto220
280 h=0:return

290 ti$="000000"
300 r=int(t-ti/60):ifr<0then510
310 print"{wht}{home}time:"r"{left} ":sys(ml+12)
320 ifr<9thenpoke36877,253
330 if(peek(37137)and32)=0thenb$=ti$:goto760
340 iffthenk=k+1:ifk=3thenk=0:f=0:poke36874,0
350 ifqandti>1087thensys(ml+18):q=0:sys(ml+33):sys(ml+15)
360 ifst<>0then110
370 gosub170:hp=hp+h:sys(ml+0)
380 pokew,116:pokehp,115:zx=0:ifh<>0thenpokehp-h,32
390 goto300

400 gosub1100:gosub1040
410 a$="                         loading...            time: 60  bombs: 0  men:   "
420 sys(ml+18):gosub1240
430 a=len(a$)-22:fori=1to20:print"{wht}{home}  "mid$(a$,i,22):gosub920:next
440 poke157,0:poke831,(rnd(0)*6)+2:poke646,peek(831):sys(ml+3):sys(ml+9):gosub970
450 fori=20toa-4:print"{home}{wht}"mid$(a$,i,26):gosub920:next
460 print"{home}{24 rght}"el
470 print"{wht}"
480 poke251,0:poke252,28:poke253,0:poke254,148:sys(ml+6)
490 gosub150:sys(ml+15)
500 c=0:hp=sc+778:goto290
510 sys(ml+24):poke36874,0:poke36877,0:gosub1100:ifr<0thengosub930:goto530
520 ifpeek(36875)<>1then520
530 sys(ml+18):el=el-1:ifel=0then580
540 poke36877,0:print"{home}time: 60  bombs: 0  men:"el
550 sys(ml+27)
560 c=0:gosub970:poke144,0:q=1
570 hp=sc+778:gosub150:poke820,0:sys(ml+15):goto290

580 a$="                         if you want to play a new game, please rewind "
590 a$=a$+"tape to '000' and then press f1.   "
600 a$=a$+"press f3 to quit the game.   "
610 a$=a$+"bomb jack was programmed by "
620 a$=a$+"ops in 1985. thanks to s.l. for the loading picture "
630 gosub1120
640 sys(ml+18):poke0,0:sys(ml+33):sys(ml+15):sys(ml+24)
650 pokepeek(833)*256+peek(832),32:poke36877,0:print"{home}                          "
660 pokehp,32:a=len(a$)
670 fori=1toa:print"{home}  "mid$(a$,i,22):sys(ml+12):pokew,116
680   fort=0to60:next
690   ifpeek(197)=39then720
700   ifpeek(197)=47thensys64802
710 next:goto670

720 sys(ml+18):gosub1240:sys(ml+21)
730 print"    press play on tape{down}              and then fire!"
740 if(peek(37137)and32)=32then740
750 sys(ml+21):el=8:a$="":i=fre(0):goto400

760 a$="                      pause mode...         "
770 sys(ml+18):gosub1240:print"{home}                          "
780 a=len(a$):fori=1to18:print"{home}  "mid$(a$,i,22):gosub920:next
790 if(peek(37137)and32)=32then790
800 fori=18to37:print"{home}  "mid$(a$,i,22):gosub920:next:print"{home}
810 ti$=b$:print"{home}time:"int(t=ti/60)"  bombs:"c" men:"el
820 sys(ml+15):goto300

830 poke648,28:clr:gosub980
840 ml=9216:sc=7168
850 sys(ml+21):t=60:el=8:hp=sc+778
860 poke36869,254
870 sys(ml+33)
880 poke36864,8:poke36865,27:poke36866,26:poke36867,62
890 poke36878,15
900 deffnn(x)=peek(x)+256*peek(x+1)
910 goto400

920 poke36878,15:forii=0to7:poke36874,ii+128:next:poke36874,0:return

930 poke36879,24:sys(ml+18):gosub1240
940 poke36878,15:gosub1240:poke36877,140:poke36879,8:poke36874,128
950 fori=15to0step-.05
960 poke36878,i:next::poke36877,0:poke36874,0:poke36878,15:return

970 restore:fori=0to7:readaa:poke832+i,aa:next:aa=0:return

980 print"{clr}{blk}":poke36879,154:poke36866,22:poke36867,46:poke36869,242:printchr$(8)
990 printtab(178)"Please reset tape":printchr$(13)
1000 print"  counter to  '000'":printchr$(13)
1010 print"    and press FIRE"
1020 if(peek(37137)and32)=32then1020
1030 print"{clr}{wht}":poke36879,8:return

1040 poke822,0:poke36874,0:poke36877,0:ifpeek(36875)=0then1060
1050 ifpeek(36875)<>1then1050
1060 sys(ml+18):sys(ml+21):fori=0to400:next:gosub1240
1070 sys(ml+30):poke822,0:sys(ml+15):sys(ml+24)
1080 ifpeek(36875)<>1then1080
1090 sys(ml+18):sys(ml+33):return

1100 pokefnn(832),32:pokefnn(834),32:pokefnn(836),32:pokefnn(838),32:pokew,32:pokehp,32
1110 return

1120 gosub1240
1130 print"{home}                          "
1140 c$="{home}        game over"
1150 poke36878,15:fori=1to300:next
1160 fori=15to0step-.5
1170   forjj=202to200step-1
1180     poke36874,jj
1190     poke646,jjand5:printc$
1200   next
1210 poke36878,i
1220 next
1230 poke36874,0:print"{wht}":return

1240 fori=0to3:poke36874+i,0:next:return

1250 data53,28,76,28,243,30,10,31
