0000 REM GAME START
0010 GR
0020 HOME
0021 LH = 32 : REM GAME LEVEL HEIGHT
0022 LW = 32 : REM GAME LEVEL WIDTH
0023 WN = 0 : REM WIN FLAG
0030 DIM LA(LH, LW) : REM DECLARE LEVEL ARRAY (HEIGHT, WIDTH)
0040 DIM WA(LH, LW) : REM DECLARE WORLD ARRAY (HEIGHT, WIDTH)
0041 DIM GA(LH, LW) : REM GOALS ARRAY (HEIGHT, WIDTH)
0050 DIM PP(2) : REM PLAYER POSITION (Y, X)
0060 RESTORE
0070 GOSUB 1000
0075 GOSUB 3000
0078 DIM PM(2) : REM PLAYER MOVEMENT
0080 REM GAMEPLAY LOOP
0090 GET KY$ : REM GET USER INPUT
0100 IF KY$ = "Q" THEN END
0110 IF KY$ = "R" THEN GOSUB 2000
0120 IF KY$ = "W" THEN PM(1) = -1
0130 IF KY$ = "S" THEN PM(1) = 1
0140 IF KY$ = "A" THEN PM(2) = -1
0150 IF KY$ = "D" THEN PM(2) = 1
0155 MT = WA(PP(1) + PM(1), PP(2) + PM(2)) : REM MOVING TO
0160 IF MT = 2 THEN PM(1) = 0 : PM(2) = 0
0170 IF MT = 4 AND WA(PP(1) + PM(1) * 2, PP(2) + PM(2) * 2) = 0 THEN WA(PP(1) + PM(1), PP(2) + PM(2)) = 0 : WA(PP(1) + PM(1) * 2, PP(2) + PM(2) * 2) = 4 : GOTO 988
180 IF MT = 4 AND WA(PP(1) + PM(1) * 2, PP(2) + PM(2) * 2) <> 0 THEN PM(1) = 0 : PM(2) = 0
988 PP(1) = PP(1) + PM(1) : PP(2) = PP(2) + PM(2)
989 PM(1) = 0: PM(2) = 0
990 PRINT PP(1) ;
991 PRINT "," ;
992 PRINT PP(2)

0997 GOSUB 3000
0998 IF WN = 1 THEN PRINT "YOU WIN! PRESS ANY KEY TO CONTINUE" : GET ZZ$ : GOSUB 1000 : GOSUB 3000
0999 GOTO 0080

1000 REM LOAD NEXT LEVEL
1001 READ LH : REM LOAD LEVEL HEIGHT INTO MEMORY
1002 READ LW : REM LOAD LEVEL WIDTH INTO MEMORY 
1010 FOR LY = 1 TO LH : REM LEVEL Y
1020 FOR LX = 1 TO LW : REM LEVEL X
1025 GA(LY,LX) = 0
1030 READ CELL
1040 LA(LY, LX) = CELL
1045 IF CELL = 12 THEN LA(LY, LX) = 4 : GA(LY, LX) = 8 
1050 IF CELL = 8 THEN GA(LY, LX) = 8 : LA(LY, LX) = 0
1060 NEXT LX
1070 NEXT LY
1075 GOSUB 2000
1080 RETURN

2000 REM RESET GAME WORLD TO LEVEL
2010 FOR WY = 1 TO LH : REM WORLD Y
2020 FOR WX = 1 TO LW : REM WORLD X
2040 WA(WY, WX) = LA(WY, WX)
2050 IF WA(WY, WX) = 1 THEN PP(1) = WY: PP(2) = WX: WA(WY, WX) = 0
2060 NEXT WX
2070 NEXT WY
2080 RETURN

3000 REM RENDER WORLD AND CHECK FOR WIN
3001 WN = 1 : REM ASSUME TRUE
3020 FOR WY = 1 TO LH
3030 FOR WX = 1 TO LW
3050 REM BIT 0 = PLAYER, 1 = WALL, 2 = BOX, 3 = GOAL
3060 CELL = WA(WY, WX)
3070 COLOR = 5 : REM DEFAULT TO FLOOR COLOR
3080 IF GA(WY, WX) = 8 THEN COLOR = 9 : REM GOAL COLOR
3090 IF CELL = 2 THEN COLOR = 1 : REM WALL COLOR
3100 IF CELL = 4 THEN COLOR = 8 : REM BOX COLOR
3120 IF WY = PP(1) AND WX = PP(2) THEN COLOR = 2 : REM PLAYER COLOR
3130 PLOT WX,WY * 2
3140 PLOT WX,WY * 2 + 1
3145 IF CELL = 4 AND GA(WY, WX) <> 8 THEN WN = 0 : REM SET WIN FALSE IF BOX WITHOUT GOAL
3150 NEXT WX
3160 NEXT WY
3170 RETURN

59999 REM LEVEL HEIGHT, WIDTH

60000 DATA 8,8
60001 DATA 2,2,2,2,2,2,2,2
60010 DATA 2,1,2,2,2,2,2,2
60020 DATA 2,0,4,0,0,8,0,2
60030 DATA 2,0,0,0,0,0,0,2
60040 DATA 2,2,0,0,2,2,0,2
60050 DATA 2,2,0,4,0,0,8,2
60060 DATA 2,2,0,0,0,2,0,2
60070 DATA 2,2,2,2,2,2,2,2

60080 DATA 9,8
60090 DATA 0,0,2,2,2,2,2,0
60100 DATA 2,2,2,0,0,0,2,0
60110 DATA 2,8,1,4,0,0,2,0
60120 DATA 2,2,2,0,4,8,2,0
60130 DATA 2,8,2,2,4,0,2,0
60140 DATA 2,0,2,0,8,0,2,2
60150 DATA 2,4,0,12,4,4,8,2
60160 DATA 2,0,0,0,8,0,0,2
60170 DATA 2,2,2,2,2,2,2,2
