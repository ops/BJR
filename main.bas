;;;
;;; Bomb Jack Revisited
;;;
;;; 1985,2018 ops
;;;

100 goto570

;; Move the "smart" ghost
105 hh=(hp-sc-1)/26:ha=hh-int(hh)
110 pp=(fnn(832)-sc-1)/26:pa=pp-int(pp)
115 a=0:ifrnd(0)>.5then135
120 ifhh<ppandpeek(hp+26)<117thenh=26:return
125 ifhh>ppandpeek(hp-26)<117thenh=-26:return
130 ifathenh=0:return
135 ifha<paandpeek(hp+1)<117thenh=1:return
140 ifha>paandpeek(hp-1)<117thenh=-1:return
145 a=1:goto120

;; Set a new bomb
150 poke144,0:print"{home}{10 rght}bombs:"c"
155 w=int(rnd(0)*726)+sc+52:ifpeek(w)<>32then155
160 return

;; Game loop
165 ti$="000000":hp=sc+778:c=0:sys(ml+15)
170 gosub150:poke888,7
175 r=int(60-ti/60):ifr<0then325
180 print"{home}time:"r"{left} "
185 ifr<10thenpoke36877,253
190 if(peek(37137)and32)=0thengosub505
195 ifpeek(0)=255thensys(ml+03),2
200 ifst=1then325
205 ifst=2thenj=1:poke36874,250:c=c+1:gosub150:ifc=9then230
210 ifjthenj=j+1:ifj>3thenj=0:poke36874,0
215 gosub105:hp=hp+h
220 pokehp,115::ifh<>0thenpokehp-h,32
225 pokew,116:goto175

;; Map completed. Load next
230 poke888,1:fori=0to500:next
235 poke36874,0:poke36877,0
240 ifpeek(0)<>255then240
245 poke646,(rnd(0)*6)+2:sys(ml+00):print"{wht}"
250 sys(ml+03),1
255 ifpeek(0)<>255then255
260 poke888,0
265 a$="                         "
270 a$=a$+"loading...            "
275 a$=a$+"time: 60  bombs: 0  men:"+str$(el)+" "
280 a=len(a$)-22
285 fori=1to18:print"{home}"mid$(a$,i,26):gosub545:next
290 l=l+1:ifl>8thenl=1
295 l$=str$(l):l$=mid$(l$,2)
300 ifl<10thenl$="0"+l$
305 l$="map"+l$
310 sys(ml+09),l$,dn
315 fori=18toa-4:print"{home}"mid$(a$,i,26):gosub545:next
320 sys(ml+06):goto165

;; Death of player
325 poke888,1:poke36874,0:poke36877,0
330 gosub645:ifr<0thengosub550:goto340
335 ifpeek(0)<>255then335
340 poke888,0
345 el=el-1:ifel=0then360
350 print"{home}time: 60  bombs: 0  men:"el
355 sys(ml+03),0:goto165

;; Game over
360 a$="                         "
365 a$=a$+"if you want to play a new game "
370 a$=a$+"press f1.   press f3 to quit the game.   "
375 a$=a$+"bomb jack was programmed by "
380 a$=a$+"ops in 1985. thanks to s.l. for the loading picture "
385 a$=a$+"and catchy tunes. the game was updated in 2018 by ops. "
390 a$=a$+"    ops.github.io/bjr/ "
395 a=len(a$):gosub440:gosub645:poke888,5
400 fori=1toa
405   print"{home}  "mid$(a$,i,22)
410   pokew,116
415   forj=0to60:next
420   ifpeek(197)=39then485
425   ifpeek(197)=47thensys64802
430   ifpeek(0)=255thensys(ml+03),2
435 next:goto400

;; Display "Game Over" text and play a sound
440 fori=1to300:next
445 fori=15to0step-.5
450   forj=202to200step-1
455     poke36874,j:poke646,jand5
460     print"{home}        game over         "
465   next
470   poke36878,i
475 next
480 poke36874,0:poke36878,15:print"{wht}":return

;; Set up a new game
485 l=0:el=8:poke888,0:poke0,255:gosub655:sys(ml+00)
490 print"{2 down}{yel}          press fire when ready!"
495 if(peek(37137)and32)=32then495
500 i=fre(0):goto230

;; Pause mode
505 poke888,0:b$=ti$:gosub655
510 a$="                      pause mode...         "
515 a=len(a$):
520 fori=1to15:print"{home}"mid$(a$,i,26):gosub545:next
525 if(peek(37137)and32)=32then525
530 fori=15to37:print"{home}"mid$(a$,i,26):gosub545:next
535 ti$=b$:print"{home}{10 rght}bombs:"c" men:"el
540 poke888,7:return

;; Sound effect during text scroll
545 forj=0to7:poke36874,j+128:next:poke36874,0:return

;; The bomb explodes!
550 poke36879,24:poke888,0:gosub655
555 poke36877,140:poke36879,8:poke36874,128
560 fori=15to0step-.05:poke36878,i:next
565 gosub655:poke36878,15:return

;; Initial setup
570 clr:poke648,28
575 deffnn(x)=peek(x)+256*peek(x+1)
580 poke36864,8:poke36865,27:poke36866,26:poke36867,62:poke36869,254
585 poke36879,8:poke36878,15
590 ml=9216:sc=7168:el=8:dn=peek(186)
595 gosub610
600 poke888,0:poke0,255
605 sys(ml+12):sys(ml+00):goto230

;; Title screen
610 poke646,1:sys(ml+00):sys(ml+18)
615 printtab(159)"{yel}bomb jack revisited"
620 printtab(12)"{yel}(c)  1985,2018 by ops"
625 printtab(73)"{wht}ops.github.io/bjr/"
630 printtab(93)"{grn}press fire to start"
635 if(peek(37137)and32)=32then635
640 return

;; Clear ghosts, player and the bomb
645 pokefnn(832),32:pokefnn(834),32:pokefnn(836),32:pokefnn(838),32:pokew,32:pokehp,32
650 return

;; Silence sounds
655 fori=0to3:poke36874+i,0:next:return
