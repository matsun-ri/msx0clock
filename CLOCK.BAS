10     'save"clock.bas",a
20 KEY 1,CHR$(12)+"screen 0"+CHR$(13)
30 '
40 '  µ·ÄÞ¹² ¶²ÃÝ À²µ³
50 '
60 '  MSX0+Battery Bottom ¶Þ ËÂÖ³
70 '
80 SCREEN 1,0,0
90 COLOR 15,4,7
100 WIDTH 32
110 KEY OFF
120 '
130 PRINT"compile started."
140 CALL TURBO ON
150 '
160 DEFINT A-Z
170 '¶ÞÒÝÉ Ó¼Þ ÖÐÄØ ¶Ý½³
180 'DEF FNS$(X,Y)=CHR$(VPEEK(6144+X+4+Y*32))
190 '0-9¶¸Ó¼ÞÉ ·¬×¸ÀÊßÀ°Ý
200 '    0-9,x,y char.pattern:'0..9-c%'
210 DIM PT(12,4,6)
220 '4Ó¼ÞÌÞÝÉ ·¬×¸ÀÊßÀ°Ý
230 '      x  y
240 DIM SC(23,6)
250 'SC(11,2)=1:SC(11,5)=1
260 'src.x,y,delta.x,y
270 DIM SX(80),SY(80),DX(80),DY(80)
280 '×Ý½³Ö³
290 DIM RN(80)
300 'ÄÞ¯ÄÏÄØ¸½ Ë®³¼ÞÖ³ Ó¼Þ
310 DIM P(2)
320 'Í²º³ÄÞ³» Ö³
330 's:¿´¼Þ c:»²¸Ù d:·®Ø
340 DIM S(15),C(15),D(15)
350 PRINT"compile completed."
360 TX=16'(»²ÀÞ² ½Ú¯ÄÞ½³=½Ìß×²Ä½³)
370 CL=7:COLOR CL,4,4
380 MX=0'sx,sy,dx,dy()É »²ÀÞ²Á
390 P(0)=ASC("…"):P(1)=ASC("„"):P(2)=ASC("ƒ")
400 P=0
410 R=0 '0:^ 1:> 2:v 3:<
420 'CALL TURBO ON(PT(),SC(),SX(),SY(),DX(),DY(),RN(),P(),S(),C(),D(),TX,MX,R)
430 '
440 '0-9,-,c,% É ·¬×¸ÀÊßÀ°Ý ¦ ¼­Ä¸
450 '
460 FOR I=0 TO 12
470   A=48+I
480   IF I=10 THEN A=ASC("-")
490   IF I=11 THEN A=ASC("c")
500   IF I=12 THEN A=ASC("%")
510   FOR Y=0 TO 6
520     V=VPEEK(A*8+Y)\8
530     FOR X=0 TO 4
540       PT(I,4-X,Y)=V AND 1
550       V=V\2
560     NEXT X
570   NEXT Y
580 NEXT I
590 PT(11,0,1)=1 'c
600 '
610 '½Ìß×²Ä Ä ·¬×¸ÀÊßÀ°Ý ¦ Ã²·Þ
620 '
630 S$=""
640 FOR I=0 TO 7
650   READ A$
660   V=VAL("&B"+A$)
670   VPOKE ASC("…")*8+I,V
680   VPOKE ASC("„")*8+I,V
690   VPOKE ASC("ƒ")*8+I,V
700   S$=S$+CHR$(V)
710 NEXT I
720 SPRITE$(0)=S$
730 '
740 DATA 0111110
750 DATA 1111111
760 DATA 1111111
770 DATA 1111111
780 DATA 1111111
790 DATA 1111111
800 DATA 0111110
810 DATA 0000000
820 '
830 '¼®· ¼Þ¶Ý ¼­Ä¸
840 GOSUB 4250:TM$=CT$:TS=CS-1
850 '¼®· Î³º³ ¼­Ä¸
860 GOSUB 3810:R=AR:RN=AR
870 CLS
880 '
890 'Ò²Ý Ù°Ìß
900 '*
910 'Ë®³¼Þ Ö³É ÊßÀ°Ý ¦ »¸¾²
920 FOR I=0 TO 3
930   A=VAL(MID$(TM$,I+1,1))
940   FOR Y=0 TO 6
950     FOR X=0 TO 4
960       V=I*6+X
970       IF 1<I THEN V=V+1
980       SC(V,Y)=PT(A,X,Y)
990     NEXT X
1000   NEXT Y
1010 NEXT I
1020 '
1030 'R=1ÉÄ· µÝÄÞ/¼ÂÄÞ ¦ Ë®³¼Þ
1040 IF R=1 THEN ELSE 1360
1050   NP=P(2)
1060   'µÝÄÞ
1070   ID$="device/dht/temperature"
1080   GOSUB 4000
1090   A=IR
1100   IF A<-99 THEN A=-99
1110   IF 99<A THEN A=99
1130   IF A<0 THEN ELSE 1170
1140     FOR I=0 TO 2
1150       LOCATE 15,I:PRINT"ƒ"
1160     NEXT I
1170   'end if
1180   FOR I=1 TO 0 STEP -1
1190     NX=I*6+4:NY=11:NN=ABS(A MOD 10):GOSUB 3570
1200     A=A\10
1210   NEXT I
1220   'ßc
1230   NX=17:NY=11:NN=11:GOSUB 3570
1240   '¼ÂÄÞ
1250   ID$="device/dht/humidity"
1260   GOSUB 4000
1270   A=IR
1280   IF A<0  THEN A=0
1290   IF 99<A THEN A=99
1300   FOR I=1 TO 0 STEP -1
1310     NX=I*6+4:NY=22:NN=A MOD 10:GOSUB 3570
1320     A=A\10
1330   NEXT I
1340   '%
1350   NX=17:NY=22:NN=12:GOSUB 3570
1360 'end if
1370 'R=2ÉÄ· ËÂÞ¹ ¦ Ë®³¼Þ
1380 IF R=2 THEN ELSE 1450
1390   NP=P(2)
1400   A=CM*100+CD 'Â·Ë
1410   FOR I=3 TO 0 STEP -1
1420     NX=I*6-(1<I):NY=-11:NN=A MOD 10:GOSUB 3570
1430     A=A\10
1440   NEXT I
1450 'end if
1460 '
1470 'R=3ÉÄ· ¾²Ú·/ËÂÞ¹ ¦ Ë®³¼Þ
1480 IF R=3 THEN ELSE 1600
1490   NP=P(2)
1500   A=CY '¾²Ú·
1510   FOR I=3 TO 0 STEP -1
1520     NX=I*6-(1<I):NY=-17:NN=A MOD 10:GOSUB 3570
1530     A=A\10
1540   NEXT I
1550   A=CM*100+CD 'ËÂÞ¹
1560   FOR I=3 TO 0 STEP -1
1570     NX=I*6-(1<I):NY=-9:NN=A MOD 10:GOSUB 3570
1580     A=A\10
1590   NEXT I
1600 'end if
1610 '
1620 '¼Þº¸ Ë®³¼Þ ¼®Ø
1630 '
1640 FOR Y=0 TO 6
1650   FOR X=0 TO 23
1660     GOSUB 3700
1670     VPOKE 6144+RX+4+RY*32,SC(X,Y)*P(P)
1680    'LOCATE RX ,RY
1690    'IF SC(X,Y) THEN PRINT CHR$(P(P)); ELSE PRINT" ";
1700   NEXT X
1710 NEXT Y
1720 'ºÛÝ É ²Á¦ ¹²»Ý
1730 X=11:Y=2:GOSUB 3700:X1=RX:Y1=RY
1740 X=12:Y=2:GOSUB 3700:X1=(X1+RX)*4+32:Y1=(Y1+RY)*4-1
1750 X=11:Y=5:GOSUB 3700:X2=RX:Y2=RY
1760 X=12:Y=5:GOSUB 3700:X2=(X2+RX)*4+32:Y2=(Y2+RY)*4-1
1770 IF R=2 THEN ELSE 1800
1780   X=11:Y=-5:GOSUB 3700:X3=RX:Y3=RY
1790   X=12:Y=-5:GOSUB 3700:X3=(X3+RX)*4+32:Y3=(Y3+RY)*4-1
1800 'else if
1810 IF R=3 THEN ELSE 1840
1820   X=11:Y=-3:GOSUB 3700:X3=RX:Y3=RY
1830   X=12:Y=-3:GOSUB 3700:X3=(X3+RX)*4+32:Y3=(Y3+RY)*4-1
1840 'end if
1850 '
1860 TIME=0
1870 '¶ÞÒÝÉ Î³º³ ¦ ¼­Ä¸
1880 'loop
1890   IF INKEY$=CHR$(27) THEN END
1900   GOSUB 3810 'AR<-MSX0É Ñ·
1910   IF AR=R THEN ELSE 2130
1920     'Ñ·¶Þ ¶Ü×Å²
1930     'ËÞ®³ Ë®³¼Þ
1940     GOSUB 4250
1950     IF (R=0 OR R=3)AND(TS<>CS) THEN ELSE 2060
1960       TS=CS
1970       A=TS
1980       NP=P(2)
1990       FOR I=1 TO 0 STEP -1
2000         NX=I*6+13:NY=10
2010         IF R=3 THEN NX=I*6+13:NY=8
2020         NN=A MOD 10
2030         GOSUB 3570
2040         A=A\10
2050       NEXT I
2060     'end if
2070     'ºÛÝ ÃÝÒÂ
2080     A=TIME MOD 60
2090     PUT SPRITE 30,(X1,Y1),-(A<40 OR 46<A)*CL,0
2100     PUT SPRITE 31,(X2,Y2),-(A<54 OR 60<A)*CL,0
2110     IF (R=2)OR(R=3) THEN PUT SPRITE 29,(X3,Y3),-(A<54 OR 60<A)*CL,0
2120     GOTO 2230
2130   'else
2140     'Ñ·¶Þ ¶Ü¯À
2150     PUT SPRITE 29,,CL
2160     PUT SPRITE 30,,CL
2170     PUT SPRITE 31,,CL
2180     RN=AR
2190     TIME=0
2200     GOSUB 3810
2210     IF RN<>AR THEN 2140 '»×Æ Ñ·¶Þ ¶Ü¯ÀÅ× ÔØÅµ¼
2220     IF TIME<90 THEN 2200 '1.5ËÞ®³ Ö³½Ð
2230   'end
2240   '¼Þº¸¶Þ ¶Ü¯À× »²Ë®³¼Þ(Ñ·Ä¶ÄÞ³ÃÞÓ²²)
2250   GOSUB 4250
2260   IF TM$<>CT$ THEN TM$=CT$:TS=CS-1:GOTO 900
2270   IF RN=R THEN 1880 '¹¯·®¸ ÓÄÉ Ñ·Å× ÓÄÞÙ
2280 'loop end
2290 '
2300 'Ñ·¶Þ ¶Ü¯À
2310 '
2320 PUT SPRITE 29,(0,209)
2330 PUT SPRITE 30,(0,209)
2340 PUT SPRITE 31,(0,209)
2350 '·¬×¸ÀÊßÀ°Ý ¼®³·® ±ÆÒ°¼®Ý
2360 V=ASC("ƒ")
2370 FOR I=0 TO 6
2380   FOR J=0 TO 7
2390     VPOKE V*8+J,VPEEK(V*8+J)\2
2400   NEXT J
2410   TIME=0
2420   IF TIME<5 THEN 2420
2430 NEXT I
2440 '¼Þº¸ ²¶Þ²¦ ¹½
2450 'R=0
2460 IF R=0 THEN ELSE 2500
2470   FOR I=13 TO 20
2480     LOCATE 17,I:PRINT"           ";
2490   NEXT I
2500 'end if
2510 'R=1
2520 IF R=1 THEN ELSE 2560
2530   FOR I=0 TO 21
2540     LOCATE 1,I:PRINT"                  ";
2550   NEXT I
2560 'end if
2570 'R=2
2580 IF R=2 THEN ELSE 2620
2590   FOR I=14 TO 20
2600     LOCATE 4,I:PRINT"                        ";
2610   NEXT I
2620 'end if
2630 'R=3
2640 IF R=3 THEN ELSE 2690
2650   FOR I=0 TO 23
2660     LOCATE 0,I:PRINT"               ";
2670     IF I<11 THEN LOCATE 25,I:PRINT"           ";
2680   NEXT I
2690 'end if
2700 '·¬×¸ÀÊßÀ°Ý Ì¯¶Â
2710 FOR I=0 TO 7
2720   VPOKE ASC("ƒ")*8+I,VPEEK(ASC("…")*8+I)
2730 NEXT I
2740 '
2750 '²ÄÞ³Ö³ ÃÞ°À¦ Ê²ÚÂÆ ¾¯Ä
2760 '  sx,sy() ²ÄÞ³ÓÄ »ÞË®³
2770 '  dx,dy() ²ÄÞ³ »ÌÞÝ
2780 '
2790 MX=0 'Ö³¿½³(¿´¼Þ É »²ÀÞ²)
2800 FOR Y=0 TO 6
2810   FOR X=0 TO 23
2820     IF SC(X,Y)=0 THEN 2920
2830       GOSUB 3700
2840       SX(MX)=RX
2850       SY(MX)=RY
2860       SWAP R,RN
2870       GOSUB 3700
2880       DX(MX)=RX-SX(MX)
2890       DY(MX)=RY-SY(MX)
2900       SWAP R,RN
2910       MX=MX+1
2920 '   endif
2930   NEXT X
2940 NEXT Y
2950 R=RN '¶²ÃÝ
2960 '
2970 '²ÄÞ³É ¼Þ­Ý¼Þ®¦ ×ÝÀÞÑÆ ¾¯Ã²
2980 '
2990 FOR I=0 TO MX-1
3000   RN(I)=I
3010 NEXT I
3020 FOR I=0 TO MX-1
3030   SWAP RN(I),RN(RND(1)*MX)
3040 NEXT I
3050 '
3060 '²ÄÞ³ Ë®³¼Þ ¼®Ø
3070 '
3080 FOR I=0 TO TX-1
3090   S(I)=-1 '¼®·¶ Ì×¸Þ
3100 NEXT I
3110 LX=0 '¼®Ø½ÞÐ ¶³ÝÄ
3120 T=0  '½Ú¯ÄÞ
3130 'loop t
3140   '½Ú¯ÄÞ ¼®·¼®Ø
3150   IF S(T)<>-1 THEN 3280 'Ð¼®·¶ ½Ú¯ÄÞÅ× Å²Ö³¦ ¾¯Ä
3160     IF LX>=MX THEN 3270 'Ð¼®Ø¶Þ Éº¯Ã²Å² ÊÞ±²¦ É¿Þ¸
3170       '½Ú¯ÄÞ É ¼®·¼®Ø
3180       S(T)=RN(LX):LX=LX+1
3190       C(T)=1
3200       D(T)=SQR(DX(S(T))^2+DY(S(T))^2)+1
3210 '     D(T)=(DX(S(T))+DY(S(T)))*3
3220       '²ÄÞ³Ï´¶Þ ½ÃÞÆ ²ÄÞ³ºÞÉ Ó¼ÞÃÞ ³Ü¶Þ·»ÚÃ ²Å¹ÚÊÞ ½Íß°½ÃÞ ¹½
3230       IF VPEEK(6144+SX(S(T))+4+SY(S(T))*32)=P(1-P) THEN 3260
3240        'LOCATE SX(S(T)),SY(S(T)):PRINT" ";
3250         VPOKE 6144+SX(S(T))+4+SY(S(T))*32,0
3260 '     end if
3270 '   end if
3280 ' end if
3290   '½Ú¯ÄÞ É ¼®Ø
3300   IF S(T)=-1 THEN 3380 '(Ó³ ½À¯¸Æ Éº¯ÃÅ² ÊÞ±²¶Þ±Ù)
3310     IF C(T)<D(T) THEN PUT SPRITE T,(32+SX(S(T))*8+DX(S(T))*8*C(T)\D(T),SY(S(T))*8+DY(S(T))*8*C(T)\D(T)),CL,0:C(T)=C(T)+1:GOTO 3370
3320       '½Ú¯ÄÞ ¼­³Ø®³ ¼®Ø
3330       PUT SPRITE T,(0,209)
3340      'LOCATE SX(S(T))+DX(S(T)),SY(S(T))+DY(S(T)):PRINT CHR$(P(1-P));
3350       VPOKE 6144+SX(S(T))+DX(S(T))+4+(SY(S(T))+DY(S(T)))*32,P(1-P)
3360       S(T)=-1
3370 '   end if
3380 ' end if
3390   T=(T+1) MOD TX
3400   '¾ÞÝ½Ú¯ÄÞ¶Þ Ã²¼¼À¶ ¶¸ÆÝ
3410   S=0
3420   FOR I=0 TO TX-1
3430     S=S+S(I)
3440   NEXT I
3450   IF S>-TX THEN 3130
3460 'end loop
3470 '
3480 P=1-P
3490 GOTO 890
3500 '
3510 '
3520 '²ÁÓ¼Þ Ë®³¼Þ Ù°ÁÝ
3530 'input: nn:Ó¼Þ 0..12=0123456789-c%
3540 '       nx,ny:Ë®³¼Þ ²Á
3550 '       np:·¬×¸Àº°ÄÞ
3560 'out  : none
3570 '*
3580 FOR NI=0 TO 6
3590   FOR NJ=0 TO 4
3600     X=NX+NJ: Y=NY+NI
3610     GOSUB 3700
3620     VPOKE 6144+RX+4+RY*32,PT(NN,NJ,NI)*NP
3630   NEXT NJ
3640 NEXT NI
3650 RETURN
3660 '
3670 '»ÞË®³ ÍÝ¶Ý Ù°ÁÝ
3680 'input: r:Ñ· x,y:ÍÝ¶ÝÏ´ »ÞË®³
3690 'out  : rx,ry:ÍÝ¶ÝºÞ »ÞË®³
3700 '*
3710 RX=-1:RY=-1
3720 IF R=0 THEN RX=X : RY=3+Y
3730 IF R=1 THEN RX=25-Y: RY=X
3740 IF R=2 THEN RX=23-X: RY=9-Y
3750 IF R=3 THEN RX=13+Y : RY=23-X
3760 RETURN
3770 '
3780 'MSX0É Ñ·¦ ¼­Ä¸
3790 'input: none
3800 'out  : ar: MSX0É Ñ· 0-3
3810 '
3820 AR=R
3830 'x¼Þ¸ É ¶¿¸ÄÞ
3840 ID$="device/accel/x":GOSUB 4000:AX=IR
3850 'CALL IOTGET("device/accel/x",X)
3860 'y¼Þ¸ É ¶¿¸ÄÞ
3870 ID$="device/accel/y":GOSUB 4000:AY=IR
3880 'CALL IOTGET("device/accel/y",Y)
3890 IF (-700<AX)AND(AX<700) THEN IF AY<-700 THEN AR=0 ELSE IF 700<AY THEN AR=2
3900 IF (-700<AY)AND(AY<700) THEN IF AX<-700 THEN AR=1 ELSE IF 700<AX THEN AR=3
3910 RETURN
3920 '
3930 'MSX0 IoT data get
3940 '
3950 'input id$:device path
3960 'out: ir:result
3970 '
3980 'CALL IOTGET("device/accel/x",X)
3990 'CALL IOTGET("device/accel/y",Y)
4000 '*
4010 'ID$="device/accel/"+ID$
4020 IC=&H58 'Ì§°Ñ¶Þ ÌÙ² ÊÞ±²Ê &H8
4030 OUT IC,&HE0
4040 OUT IC,   1
4050 OUT IC,&H53
4060 OUT IC,&HC0
4070 OUT IC,LEN(ID$)
4080 FOR II=1 TO LEN(ID$)
4090   OUT IC,ASC(MID$(ID$,II,1))
4100 NEXT II
4110 OUT IC,   0
4120 IR=INP(IC)
4130 OUT IC,&HE0
4140 OUT IC,   1
4150 OUT IC,   1
4160 OUT IC,&H80
4170 IR=INP(IC)
4180 IR=INP(IC)+INP(IC)*256
4190 RETURN
4200 '
4210 ' ËÂÞ¹/¼Þº¸ ¼­Ä¸ Ù°ÁÝ
4220 ' input: Å¼
4230 ' out: CY,CM,CD,CH,CN,CS,CT$
4240 '    yyyy/mm/dd hh:mm:ss hhnn
4250 '*
4260 CR%=0:CT%=0
4270 'BDOSº°Ù¦ ØÖ³¼ ËÂÞ¹¦ ¼­Ä¸
4280 'LD C,02Ah   ;ËÂÞ¹ ¼­Ä¸ Ì§Ý¸¼®Ý
4290 'CALL 0F37Dh ;´ÝÄØ ±ÄÞÚ½
4300 'LD (CR%),HL  ;¹¯¶ yyyy
4310 'LD (CT%),DE  ;¹¯¶ mm,dd
4320 '#I &H0E,&H2A
4330 '#I &HCD,&H7D,&HF3
4340 '#I &H22,CR%
4350 '#I &HED,&H53,CT%
4360 CY=CR%:CM=CT%\256:CD=CT% MOD 256
4370 'BDOSº°Ù¦ ØÖ³¼ ¼Þº¸¦ ¼­Ä¸
4380 'LD C,02Ch   ;¼Þº¸ ¼­Ä¸ Ì§Ý¸¼®Ý
4390 'CALL 0F37Dh ;´ÝÄØ ±ÄÞÚ½
4400 'LD (CR%),HL  ;¹¯¶ h,m
4410 'LD (CT%),DE  ;¹¯¶ s,0
4420 '#I &H0E,&H2C
4430 '#I &HCD,&H7D,&HF3
4440 '#I &H22,CR%
4450 '#I &HED,&H53,CT%
4460 CH=CR%\256:CN=CR% MOD 256:CS=CT%\256
4470 CT$=HEX$(CH\10)+HEX$(CH MOD 10)+HEX$(CN\10)+HEX$(CN MOD 10)
4480 'LOCATE 0,0:PRINT CY;CM;CD;CH;CN;CS
4490 RETURN
