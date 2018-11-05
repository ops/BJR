  100 goto810

  110 sys(ml+24)
  120 ifst=1then490
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
  300 r=int(t-ti/60):ifr<0then490
  310 print"{wht}{home}time:"r"{left} ":sys(ml+12)
  320 ifr<9thenpoke36877,253
  330 if(peek(37137)and32)=0thenb$=ti$:goto740
  340 iffthenk=k+1:ifk=3thenk=0:f=0:poke36874,0
  350 ifqandti>1087thensys(ml+18):q=0:sys(ml+33):sys(ml+15)
  360 ifst<>0then110
  370 gosub170:hp=hp+h:sys(ml+0)
  380 pokew,116:pokehp,115:zx=0:ifh<>0thenpokehp-h,32
  390 goto300

  400 gosub1060:gosub1000
  410 a$="                         loading...            time: 60  bombs: 0  men:   "
  420 sys(ml+18):gosub1145
  430 a=len(a$)-22:fori=1to20:print"{wht}{home}  "mid$(a$,i,22):gosub870:next
  440 poke157,0:poke831,(rnd(0)*6)+2:poke646,peek(831):sys(ml+3):sys(ml+9):gosub920
  450 fori=20toa-4:print"{home}{wht}"mid$(a$,i,26):gosub870:next
  460 print"{home}{24 rght}"el
  470 print"{wht}"
  471 poke251,0:poke252,28:poke253,0:poke254,148:sys(ml+6)
  472 gosub150:sys(ml+15)
  480 c=0:hp=sc+778:goto290
  490 sys(ml+24):poke36874,0:poke36877,0:gosub1060:ifr<0thengosub880:goto510
  500 ifpeek(36875)<>1then500
  510 sys(ml+18):el=el-1:ifel=0then560
  520 poke36877,0:print"{home}time: 60  bombs: 0  men:"el
  530 sys(ml+27)
  540 c=0:gosub920:poke144,0:q=1
  550 hp=sc+778:gosub150:poke820,0:sys(ml+15):goto290

  560 a$="                         if you want to play a new game, please rewind "
  570 a$=a$+"tape to '000' and then press f1.   "
  580 a$=a$+"press f3 to quit the game.   "
  590 a$=a$+"bomb jack was programmed by "
  600 a$=a$+"ops in 1985. thanks to s.l. for the loading picture "
  610 gosub1080
  620 sys(ml+18):poke0,0:sys(ml+33):sys(ml+15):sys(ml+24)
  630 pokepeek(833)*256+peek(832),32:poke36877,0:print"{home}                          "
  640 pokehp,32:a=len(a$)
  650 fori=1toa:print"{home}  "mid$(a$,i,22):sys(ml+12):pokew,116
  660   fort=0to60:next
  670   ifpeek(197)=39then700
  680   ifpeek(197)=47thensys64802
  690 next:goto650

  700 sys(ml+18):gosub1145:sys(ml+21)
  710 print"    press play on tape{down}              and then fire!"
  720 if(peek(37137)and32)=32then720
  730 sys(ml+21):el=8:a$="":i=fre(0):goto400

  740 a$="                      pause mode...         "
  750 sys(ml+18):gosub1145:print"{home}                          "
  760 a=len(a$):fori=1to18:print"{home}  "mid$(a$,i,22):gosub870:next
  770 if(peek(37137)and32)=32then770
  780 fori=18to37:print"{home}  "mid$(a$,i,22):gosub870:next:print"{home}
  790 ti$=b$:print"{home}time:"int(t=ti/60)"  bombs:"c" men:"el
  800 sys(ml+15):goto300

  810 poke648,28:clr:gosub930
  815 ml=9216:sc=7168
  820 sys(ml+21):t=60:el=8:hp=sc+778
  825 poke36869,254
  830 sys(ml+33)
  840 poke36864,8:poke36865,27:poke36866,26:poke36867,62
  845 poke36878,15
  850 deffnn(x)=peek(x)+256*peek(x+1)
  860 goto400

  870 poke36878,15:forii=0to7:poke36874,ii+128:next:poke36874,0:return

  880 poke36879,24:sys(ml+18):gosub1145
  890 poke36878,15:gosub1145:poke36877,140:poke36879,8:poke36874,128
  900 fori=15to0step-.05
  910 poke36878,i:next::poke36877,0:poke36874,0:poke36878,15:return

  920 restore:fori=0to7:readaa:poke832+i,aa:next:aa=0:return

  930 print"{clr}{blk}":poke36879,154:poke36866,22:poke36867,46:poke36869,242:printchr$(8)
  940 printtab(178)"Please reset tape":printchr$(13)
  950 print"  counter to  '000'":printchr$(13)
  960 print"    and press FIRE"
  970 if(peek(37137)and32)=32then970
  990 print"{clr}{wht}":poke36879,8:return

 1000 poke822,0:poke36874,0:poke36877,0:ifpeek(36875)=0then1020
 1010 ifpeek(36875)<>1then1010
 1020 sys(ml+18):sys(ml+21):fori=0to400:next:gosub1145
 1030 sys(ml+30):poke822,0:sys(ml+15):sys(ml+24)
 1040 ifpeek(36875)<>1then1040
 1050 sys(ml+18):sys(ml+33):return

; Clear ghosts, bomb, player
 1060 pokefnn(832),32:pokefnn(834),32:pokefnn(836),32:pokefnn(838),32:pokew,32:pokehp,32
 1070 return

 1080 gosub1145
 1082 print"{home}                          "
 1090 c$="{home}        game over"
 1092 poke36878,15:fori=1to300:next
 1100 fori=15to0step-.5
 1110   forjj=202to200step-1
 1120     poke36874,jj
 1130     poke646,jjand5:printc$
 1132   next
 1134 poke36878,i
 1136 next
 1140 poke36874,0:print"{wht}":return

; Silence sounds
 1145 fori=0to3:poke36874+i,0:next:return

 1150 data53,28,76,28,243,30,10,31
