

;boot.prg ==0801==
  100 iff=1then400
  110 poke36865,160:goto280
  120 print"{home}{down}{yel}  {rvon}ops-soft presents:":poke646,0
  130 print"{down} {CBM-D}{CBM-I}{CBM-I}{CBM-I}  {CBM-I}{CBM-I}{CBM-I} {CBM-D}   {CBM-F}{CBM-D}{CBM-I}{CBM-I}{CBM-I}"
  140 print" {rvon}{CBM-K}{rvof}   {CBM-K}{rvon}{CBM-K}{rvof}   {CBM-K}{rvon}{CBM-K}{rvof}{CBM-F} {CBM-D}{CBM-K}{rvon}{CBM-K}{rvof}   {CBM-K}"
  150 print" {rvon}{CBM-K}{rvof}   {CBM-K}{rvon}{CBM-K}{rvof}   {CBM-K}{rvon}{CBM-K}{rvof}{CBM-C}{CBM-I}{CBM-V}{CBM-K}{rvon}{CBM-K}{rvof}   {CBM-K}"
  160 print" {rvon}{CBM-K}{rvof}  {rvon}{CBM-K}{rvof} {rvon}{CBM-K}{rvof}   {CBM-K}{rvon}{CBM-K}{rvof}   {CBM-K}{rvon}{CBM-K}{rvof}  {rvon}{CBM-K}{rvof}"
  170 print" {rvon}{CBM-K}{rvof}   {CBM-K}{rvon}{CBM-K}{rvof}   {CBM-K}{rvon}{CBM-K}{rvof}   {CBM-K}{rvon}{CBM-K}{rvof}   {CBM-K}"
  180 print" {rvon}{CBM-K}{rvof}   {CBM-K}{rvon}{CBM-K}{rvof}   {CBM-K}{rvon}{CBM-K}{rvof}   {CBM-K}{rvon}{CBM-K}{rvof}   {CBM-K}"
  190 print" {CBM-C}{rvon}{CBM-I}{CBM-I}{CBM-I}{rvof}  {rvon}{CBM-I}{CBM-I}{CBM-I}{rvof} {CBM-C}   {CBM-V}{CBM-C}{rvon}{CBM-I}{CBM-I}{CBM-I}{rvof}"
  200 print"    {CBM-I}{CBM-F} {CBM-I}{CBM-I}{CBM-I}  {CBM-I}{CBM-I}{CBM-I} {CBM-D}   {CBM-F}"
  210 print"    {rvon}{CBM-K}{rvof} {rvon}{CBM-K}{rvof}   {CBM-K}{rvon}{CBM-K}{rvof}   {CBM-K}{rvon}{CBM-K}{rvof}  {rvon}{CBM-B}{rvof}"
  220 print"    {rvon}{CBM-K}{rvof} {rvon}{CBM-K}{rvof}   {CBM-K}{rvon}{CBM-K}{rvof}    {rvon}{CBM-K}{rvof} {rvon}{CBM-B}"
  230 print"    {rvon}{CBM-K}{rvof} {rvon}{CBM-K}{rvof}{CBM-I}{CBM-I}{CBM-I}{CBM-K}{rvon}{CBM-K}{rvof}    {rvon}{CBM-K} {rvof}"
  240 print" {CBM-D}  {rvon}{CBM-K}{rvof} {rvon}{CBM-K}{rvof}   {CBM-K}{rvon}{CBM-K}{rvof}    {rvon}{CBM-K}{rvof} {CBM-B}"
  250 print" {rvon}{CBM-K}{rvof}  {rvon}{CBM-K}{rvof} {rvon}{CBM-K}{rvof}   {CBM-K}{rvon}{CBM-K}{rvof}   {CBM-K}{rvof}{rvon}{CBM-K}{rvof}  {CBM-B}"
  260 print"  {rvon}{CBM-I}{CBM-I}{rvof}{CBM-V} {CBM-C}   {CBM-V} {rvon}{CBM-I}{CBM-I}{CBM-I}{rvof} {CBM-C}   {CBM-V}"
  270 return
  280 poke36877,253:poke36878,15:poke36875,0:poke376,0
  290 poke56,20:poke55,255:poke52,20:poke51,255:clr
  300 p=peek(45)+256*peek(46)-180
  310 fori=0to133:poke270+i,peek(p+i):next:p=p+134
  320 fori=0to42:poke725+i,peek(p+i):next
  330 fori=1to100:next
  340 poke36874,128:poke36877,130
  350 print"{clr}":gosub120::poke36879,136:poke36869,240:poke36864,12:poke36865,38
  360 poke36866,150:poke36867,174
  370 fori=15to0step-.05:poke36878,i:next:poke36874,0:poke36877,0
  380 print"{home}":poke214,18:print:print"{wht}      loading...{up}"
  390 clr:f=1:load"",1,1
  400 poke45,54:poke46,18:clr:load

