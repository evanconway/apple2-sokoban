0000 REM GAME START
0010 GR
0011 HOME
0012 PRINT "LOADING..."
0021 LH = 32 : REM GAME LEVEL HEIGHT
0022 LW = 32 : REM GAME LEVEL WIDTH
0023 WN = 0 : REM WIN FLAG
0024 FL = 0 : REM FINAL LEVEL FLAG
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

0995 GOSUB 3000
0996 IF WN = 1 AND FL = 0 THEN HOME : PRINT CHR$(7) ; : PRINT "LEVEL COMPLETE" : PRINT "PRESS ANY KEY TO CONTINUE" : GET ZZ$ : HOME : GOSUB 1000 : GOSUB 3000
0997 IF WN = 1 AND FL = 1 THEN GOSUB 4000
0999 GOTO 0080

1000 REM LOAD NEXT LEVEL
1001 READ LH : REM LOAD LEVEL HEIGHT INTO MEMORY
1005 READ LW : REM LOAD LEVEL WIDTH INTO MEMORY
1009 READ FL : REM LOAD FINAL LEVEL FLAG
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
2080 HOME
2090 PRINT "MOVE: WASD"
2100 PRINT "RESET: R"
2110 RETURN

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

4000 REM END OF GAME
4005 HOME
4010 PRINT "YOU BEAT ALL THE LEVELS!!!"
4020 PRINT "YOU'RE A SOKOBAN MASTER!!!"
4030 FOR RY = 1 TO 18
4040 FOR RX = 1 TO 22
4050 READ PL
4060 IF PL = 0 THEN COLOR = 3
4070 IF PL = 1 THEN COLOR = 0
4080 IF PL = 2 THEN COLOR = 15
4090 IF PL = 3 THEN COLOR = 12
4100 PLOT RX,RY * 2
4105 PLOT RX,RY * 2 + 1
4110 NEXT RX
4120 NEXT RY
4130 GET ZZ$

59999 REM LEVEL HEIGHT, WIDTH

60000 DATA 8,8,0
60001 DATA 2,2,2,2,2,2,2,2
60010 DATA 2,1,2,2,2,2,2,2
60020 DATA 2,0,4,0,0,8,0,2
60030 DATA 2,0,0,0,0,0,0,2
60040 DATA 2,2,0,0,2,2,0,2
60050 DATA 2,2,0,4,0,0,8,2
60060 DATA 2,2,0,0,0,2,0,2
60070 DATA 2,2,2,2,2,2,2,2

60080 DATA 9,8,1
60090 DATA 0,0,2,2,2,2,2,0
60100 DATA 2,2,2,0,0,0,2,0
60110 DATA 2,8,1,4,0,0,2,0
60120 DATA 2,2,2,0,4,8,2,0
60130 DATA 2,8,2,2,4,0,2,0
60140 DATA 2,0,2,0,8,0,2,2
60150 DATA 2,4,0,12,4,4,8,2
60160 DATA 2,0,0,0,8,0,0,2
60170 DATA 2,2,2,2,2,2,2,2

63002 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
63003 DATA 0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0
63004 DATA 0,0,0,0,0,1,2,2,2,2,2,2,2,2,2,2,1,0,0,0,0,0
63005 DATA 0,0,0,0,0,1,2,1,1,1,1,1,1,1,1,2,1,0,0,0,0,0
63006 DATA 0,0,0,0,0,1,2,3,1,3,1,3,1,1,1,2,1,0,0,0,0,0
63007 DATA 0,0,0,0,0,1,2,1,1,1,1,1,1,1,1,2,1,0,0,0,0,0
63008 DATA 0,0,0,0,0,1,2,1,3,3,1,3,3,1,1,2,1,0,0,0,0,0
63009 DATA 0,0,0,0,0,1,2,1,1,1,1,1,1,1,1,2,1,0,0,0,0,0
63010 DATA 0,0,0,0,0,1,2,1,1,1,1,1,1,1,1,2,1,0,0,0,0,0
63011 DATA 0,0,0,0,0,1,2,2,2,2,2,2,2,2,2,2,1,0,0,0,0,0
63012 DATA 0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0
63013 DATA 0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0
63014 DATA 0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0
63015 DATA 0,0,0,0,0,1,1,1,2,1,2,1,2,1,2,1,1,0,0,0,0,0
63016 DATA 0,0,0,0,0,1,1,2,1,2,1,2,1,2,1,1,1,0,0,0,0,0
63017 DATA 0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0
63018 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
63019 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
