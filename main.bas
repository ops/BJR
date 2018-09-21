

;main.prg ==0801==
  100 goto810
  110 poke788,152:poke789,23
  120 ifst=1then490
  130 ifst=2thenf=1:poke36874,250:pokew,32:c=c+1:gosub150:ifc=9thengoto400
  140 poke144,0:sys6093:goto370
  150 w=int(rnd(0)*726)+7220:ifpeek(w)<>32then150
  160 print"{home}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}bombs:"c"{left} ":pokew,116:return
  170 ha=(hp-7167)/26-int((hp-7167)/26):pp=peek(832)+256*peek(833)
  180 rd=rnd(0):pa=(pp-7167)/26-int((pp-7167)/26)
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
  310 print"{wht}{home}time:"r"{left} ":sys398
  320 ifr<9thenpoke36877,253
  330 if(peek(37137)and32)=0thenb$=ti$:goto740
  340 iffthenk=k+1:ifk=3thenk=0:f=0:poke36874,0
  350 ifqandti>1087thensys6106:q=0:poke0,0:poke1,0:poke2,23:poke821,0:sys6093
  360 ifst<>0then110
  370 gosub170:hp=hp+h:sys308
  380 pokew,116:pokehp,115:zx=0:ifh<>0thenpokehp-h,32
  390 goto300
  400 gosub1060:gosub1000
  410 a$="                         loading...            time: 60  bombs: 0  men:   "
  420 sys6106:fori=0to3:poke36874+i,0:next:poke0,0:poke1,0
  430 a=len(a$)-22:fori=1to20:print"{wht}{home}  "mid$(a$,i,22):gosub870:next
  440 poke157,0:poke831,(rnd(0)*6)+2:poke646,peek(831):sys322:sys375:gosub920:poke36892,1
  450 fori=20toa-4:print"{home}{wht}"mid$(a$,i,26):gosub870:next
  460 print"{home}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}{rght}"el
  470 print"{wht}":poke251,0:poke252,28:poke253,0:poke254,148:sys349:gosub150:sys6093
  480 c=0:hp=7946:goto290
  490 poke788,152:poke789,23:poke36874,0:poke36877,0:gosub1060:ifr<0thengosub880:goto510
  500 ifpeek(36875)<>1then500
  510 sys6106:el=el-1:ifel=0then560
  520 poke36877,0:print"{home}time: 60  bombs: 0  men:"el
  530 poke0,0:poke1,0:poke821,2:poke2,21
  540 c=0:gosub920:poke144,0:q=1
  550 hp=7946:gosub150:poke820,0:sys6093:goto290
  560 a$="                         if you want to play a new game, please rewind "
  570 a$=a$+"tape to '000' and then press f1.   "
  580 a$=a$+"press f3 to quit the game.   "
  590 a$=a$+"bomb jack was programmed by "
  600 a$=a$+"ops in 1985. thanks to s.l. for the loading picture "
  610 gosub1080:poke36892,255
  620 sys6106:poke0,0:poke1,0:poke2,23:poke821,2:sys6093:poke788,152:poke789,23
  630 pokepeek(833)*256+peek(832),32:poke36877,0:print"{home}                          "
  640 pokehp,32:a=len(a$)
  650 fori=1toa:print"{home}  "mid$(a$,i,22):sys398:pokew,116
  660 fort=0to60:next
  670 ifpeek(197)=39then700
  680 ifpeek(197)=47thensys64802
  690 next:goto650
  700 sys6106:fori=0to3:poke36874+i,0:next:sys725:poke36892,1
  710 print"    press play on tape{down}              and then fire!"
  720 if(peek(37137)and32)=32then720
  730 sys725:el=8:a$="":i=fre(0):goto400
  740 a$="                      pause mode...         "
  750 sys6106:fori=0to3:poke36874+i,0:next:print"{home}                          "
  760 a=len(a$):fori=1to18:print"{home}  "mid$(a$,i,22):gosub870:next
  770 if(peek(37137)and32)=32then770
  780 fori=18to37:print"{home}  "mid$(a$,i,22):gosub870:next:print"{home}
  790 ti$=b$:print"{home}time:"int(t=ti/60)"  bombs:"c" men:"el
  800 sys6093:goto300
  810 poke56,20:poke55,255:poke52,20:poke51,255:clr:gosub930
  820 poke648,28:sys725:t=60:el=8:hp=7946:poke36869,254
  830 poke0,0:poke1,0:poke2,23
  840 poke36864,8:poke36865,27:poke36866,26:poke36867,62:poke36878,15
  850 deffnn(x)=peek(x)+256*peek(x+1)
  860 goto400
  870 poke36878,15:forii=0to7:poke36874,ii+128:next:poke36874,0:return
  880 poke36879,24:sys6106:fori=0to3:poke36874+i,0:next
  890 poke36878,15:fori=0to3:poke36874+i,0:next:poke36877,140:poke36879,8:poke36874,128
  900 fori=15to0step-.05
  910 poke36878,i:next::poke36877,0:poke36874,0:poke36878,15:return
  920 restore:fori=0to7:readaa:poke832+i,aa:next:aa=0:return:fori=0to7:readaa:poke832+i,aa:next:aa=0:return
  930 print"{clr}{blk}":poke36879,154:poke36869,242:printchr$(8)
  940 printtab(178)"Please reset tape":printchr$(13)
  950 print"  counter to  '000'":printchr$(13)
  960 print"    and press FIRE"
  970 if(peek(37137)and32)=32then970
  980 poke36892,1
  990 print"{clr}{wht}":poke36879,8:poke36869,254:return
 1000 poke822,0:poke36874,0:poke36877,0:ifpeek(36875)=0then1020
 1010 ifpeek(36875)<>1then1010
 1020 sys6106:sys725:fori=0to400:next:poke36874,0:poke36875,0:poke36876,0
 1030 poke2,22:poke1,0:poke0,0:poke821,2:poke822,0:sys6093:poke788,152:poke789,23
 1040 ifpeek(36875)<>1then1040
 1050 sys6106:poke1,0:poke2,23:return
 1060 pokefnn(832),32:pokefnn(834),32:pokefnn(836),32:pokefnn(838),32:pokew,32:pokehp,32
 1070 return
 1080 fori=0to3:poke36874+i,0:next:print"{home}                          "
 1090 c$="{home}        game over":poke36878,15:fori=1to300:next
 1100 fori=15to0step-.5
 1110 forjj=202to200step-1
 1120 poke36874,jj
 1130 poke646,jjand5:printc$:next:poke36878,i:next:poke36874,0
 1140 print"{wht}":return
 1150 data53,28,76,28,243,30,10,31

