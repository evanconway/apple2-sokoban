0000 REM GAME START
0010 GR
0020 HOME
0040 DIM WA(8, 8) : REM DECLARE WORLD ARRAY
0050 DIM PP(2) : REM PLAYER POSITION (Y, X)
0060 RESTORE
0070 GOSUB 1000
0075 GOSUB 2000
0080 REM GAMEPLAY LOOP
0090 GET KY$ : REM GET USER INPUT
0100 IF KY$ = "Q" THEN END
110 IF KY$ = "W" THEN PP(1) = PP(1) - 1
120 IF KY$ = "S" THEN PP(1) = PP(1) + 1
130 IF PP(1) < 1 THEN PP(1) = 1
140 IF PP(1) > 8 THEN PP(1) = 8
150 IF KY$ = "A" THEN PP(2) = PP(2) - 1
160 IF KY$ = "D" THEN PP(2) = PP(2) + 1
170 IF PP(2) < 1 THEN PP(2) = 1
180 IF PP(2) > 8 THEN PP(2) = 8
190 PRINT PP(1) ;
200 PRINT "," ;
210 PRINT PP(2)

0998 GOSUB 2000
0999 GOTO 0090

1000 REM LOAD NEXT LEVEL
1010 FOR WY = 1 TO 8 : REM WORLD X
1020 FOR WX = 1 TO 8 : REM WORLD Y
1030 READ CELL
1040 WA(WY, WX) = CELL
1050 IF CELL = 1 THEN PP(1) = WY: PP(2) = WX: WA(WY, WX) = 0
1060 NEXT WX
1070 NEXT WY
1080 RETURN

2000 REM RENDER WORLD
2010 WC = 1 : REM WALL COLOR
2020 FOR WY = 0 TO 9
2030 FOR WX = 0 TO 9
2040 IF WX = 0 OR WX = 9 OR WY = 0 OR WY = 9 THEN GOTO 3000
2050 REM BIT 0 = PLAYER, 1 = WALL, 2 = BOX, 3 = GOAL
2060 CELL = WA(WY, WX)
2070 COLOR = 5
2080 IF CELL = 8 THEN COLOR = 9 : REM GOAL COLOR
2090 IF CELL = 2 THEN COLOR = WC : REM WALL COLOR
2100 IF CELL = 4 THEN COLOR = 8 : REM BOX COLOR
2120 IF WY = PP(1) AND WX = PP(2) THEN COLOR = 2 : REM PLAYER COLOR
2130 PLOT WX,WY * 2
2140 PLOT WX,WY * 2 + 1
2150 NEXT WX
2160 NEXT WY
2170 RETURN

3000 REM COLOR WALL BLOCK
3010 COLOR = WC
3020 GOTO 2130

60000 DATA 1,0,0,0,0,0,0,0
60010 DATA 0,0,2,2,2,2,2,0
60020 DATA 8,0,4,0,0,0,0,0
60030 DATA 0,0,0,0,0,0,0,0
60040 DATA 0,2,0,0,2,2,0,0
60050 DATA 0,2,0,4,0,0,0,8
60060 DATA 0,2,0,0,0,2,0,0
60070 DATA 0,0,0,0,0,2,2,0
