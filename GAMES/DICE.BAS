5 CLEAR
7 REM *** PROGRAM WRITTEN BY C. VAN DER KAAY 6/2024 ***
10 RANDOMIZE
20 GOSUB 1000 ' Title Screen
25 GOSUB 1150 ' Pause before instructions
30 GOSUB 2000 ' Instructions
35 GOSUB 2250 ' Pause before starting
50 PLAYERSCORE = 0
60 COMPUTERSCORE = 0
70 NUMROUNDS = INT(RND * 5 + 1)
80 PRINT "THE COMPUTER HAS CHOSEN "; NUMROUNDS; " ROUNDS.": PRINT CHR$(7)
90 FOR R = 1 TO NUMROUNDS
100 PRINT "ROUND "; R
110 GOSUB 4000 ' Player Rolls Dice
120 GOSUB 5000 ' Computer Rolls Dice
130 NEXT R
140 GOSUB 6000 ' Display Final Scores
150 GOSUB 7000 ' Determine Winner
160 GOSUB 8000 ' Play Again?
170 END
1000 ' Title Screen Subroutine
1010 PRINT "============================"
1020 PRINT "|     ______    ______     |"
1030 PRINT "|    |      |  |      |    |"
1040 PRINT "|    | o  o |  | o  o |    |"
1050 PRINT "|    |  o   |  | o  o |    |"
1060 PRINT "|    | o  o |  | o  o |    |"
1070 PRINT "|    |______|  |______|    |"
1080 PRINT "|   *WELCOME TO THE DICE*  |"
1090 PRINT "|   *     G A M E !     *  |"
1100 PRINT "|                          |"
1110 PRINT "============================": PRINT CHR$(7)
1120 RETURN
1150 ' Pause before Instructions Subroutine
1155 PRINT "PRESS ENTER TO VIEW INSTRUCTIONS AND BEGIN!"
1157 INPUT USER_INPUT$
1159 RETURN
2000 ' Instructions Subroutine
2010 PRINT CHR$(12):PRINT "========================"
2030 PRINT "||    DICE GAME!      ||"
2050 PRINT "========================"
2060 PRINT "1. Computer picks 1-5"
2070 PRINT "   rounds."
2080 PRINT "------------------------"
2090 PRINT "2. You roll two dice."
2100 PRINT "   (Press ENTER)"
2110 PRINT "   If sum >= 7, you"
2120 PRINT "   score the sum."
2130 PRINT "------------------------"
2140 PRINT "3. Computer rolls two"
2150 PRINT "   dice."
2160 PRINT "   If either die > 3,"
2170 PRINT "   computer scores sum."
2180 PRINT "------------------------"
2190 PRINT "4. Highest score wins."
2200 PRINT "========================"
2230 RETURN
2250 ' Pause before Starting Subroutine
2255 PRINT CHR$(7):PRINT "THE COMPUTER WILL NOW CHOSE HOW MANY ROUNDS TO PLAY. PRESS ENTER TO CONTINUE."
2257 INPUT USER_INPUT$
2259 RETURN
4000 ' Player Rolls Dice Subroutine
4010 PRINT "PRESS ENTER TO ROLL THE DICE"
4020 INPUT USER_INPUT$
4030 PLAYERROLL1 = INT(RND * 6 + 1)
4040 PLAYERROLL2 = INT(RND * 6 + 1)
4050 PRINT "YOU ROLLED "; PLAYERROLL1; " AND "; PLAYERROLL2: PRINT CHR$(7)
4060 IF PLAYERROLL1 + PLAYERROLL2 >= 7 THEN PLAYERSCORE = PLAYERSCORE + PLAYERROLL1 + PLAYERROLL2
4070 PRINT "YOUR SCORE IS NOW "; PLAYERSCORE
4080 RETURN
5000 ' Computer Rolls Dice Subroutine
5010 COMPUTERROLL1 = INT(RND * 6 + 1)
5020 COMPUTERROLL2 = INT(RND * 6 + 1)
5030 PRINT "COMPUTER ROLLED "; COMPUTERROLL1; " AND "; COMPUTERROLL2: PRINT CHR$(7)
5040 IF COMPUTERROLL1 > 3 OR COMPUTERROLL2 > 3 THEN COMPUTERSCORE = COMPUTERSCORE + COMPUTERROLL1 + COMPUTERROLL2
5050 PRINT "THE COMPUTER'S SCORE IS NOW "; COMPUTERSCORE
5060 RETURN
6000 ' Display Final Scores Subroutine
6010 PRINT "GAME OVER": PRINT CHR$(7)
6020 PRINT "YOUR FINAL SCORE IS "; PLAYERSCORE
6030 PRINT "THE COMPUTER'S FINAL SCORE IS "; COMPUTERSCORE
6040 RETURN
7000 ' Determine Winner Subroutine
7010 IF PLAYERSCORE > COMPUTERSCORE THEN GOTO 7100
7020 IF COMPUTERSCORE > PLAYERSCORE THEN GOTO 7200
7030 PRINT "IT'S A TIE!": PRINT CHR$(7)
7040 GOTO 7300
7100 PRINT "YOU WIN!": PRINT CHR$(7)
7110 GOTO 7300
7200 PRINT "THE COMPUTER WINS!": PRINT CHR$(7)
7300 RETURN
8000 ' Play Again Subroutine
8010 PRINT
8020 INPUT "DO YOU WANT TO PLAY AGAIN? Y/N"; L$
8030 IF L$ = "Y" THEN GOTO 5
8040 PRINT "GOODBYE!": PRINT CHR$(7)
8050 RETURN