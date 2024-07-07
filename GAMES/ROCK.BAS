5 REM *** PROGRAMMED BY C. VAN DER KAAY 6/2024 ***
10 RANDOMIZE
20 DIM userChoices$(100), computerChoices$(100)
30 GOSUB 1000 ' Display instructions
35 INPUT "Choose difficulty (1=Easy, 2=Medium, 3=Hard): ", difficultyLevel
36 IF difficultyLevel < 1 OR difficultyLevel > 3 THEN PRINT "Invalid choice! Try again.": GOTO 35
40 GOSUB 7000 ' Initialize game state
50 INPUT "How many rounds would you like to play? ", totalRounds
60 IF totalRounds <= 0 THEN PRINT "Please enter a positive number.": GOTO 50
70 userScore = 0
80 computerScore = 0
90 roundCount = 1
100 tieCount = 0
110 WHILE roundCount <= totalRounds
120   IF INT(RND * 10) = 0 THEN PRINT "*** BONUS ROUND! Points are doubled! ***": bonusRound = 1 ELSE bonusRound = 0
130   GOSUB 2000 ' Get player choice
140   IF playerChoice$ = "X" THEN GOSUB 8000: GOTO 130
150   GOSUB 3000 ' Get computer choice
160   GOSUB 4000 ' Determine winner and update score
170   GOSUB 5000 ' Display scores
180   roundCount = roundCount + 1
190 WEND
200 GOSUB 6000 ' End game message
210 INPUT "Would you like to view the statistics (Y/N)? ", STATS$
220 IF STATS$ = "Y" OR STATS$ = "y" THEN GOSUB 8000: GOTO 230
225 IF STATS$ <> "N" AND STATS$ <> "n" THEN PRINT "Please enter Y or N.": GOTO 210
230 INPUT "Play again (Y/N)? ", AGAIN$
240 IF AGAIN$ = "Y" OR AGAIN$ = "y" THEN GOSUB 7000: GOTO 35
250 PRINT : PRINT "GOOD BYE!"
260 END

1000 REM Subroutine to display instructions
1010 PRINT "*********************************************"
1020 PRINT "*                                           *"
1030 PRINT "*   Welcome to Rock-Paper-Scissors!         *"
1040 PRINT "*                                           *"
1050 PRINT "*  INSTRUCTIONS:                            *"
1060 PRINT "*  Choose rock (R), paper (P), or scissors  *"
1070 PRINT "*  (S). The game follows the standard rules:*"
1080 PRINT "*  Rock beats Scissors, Scissors beat Paper,*"
1090 PRINT "*  and Paper beats Rock.                    *"
1100 PRINT "*                                           *"
1110 PRINT "*  The player with the most points after    *"
1120 PRINT "*  the specified rounds wins.               *"
1130 PRINT "*                                           *"
1140 PRINT "*********************************************"
1150 RETURN

2000 REM Subroutine to get player choice
2010 PRINT
2020 IF roundCount > 1 THEN GOTO 2025 ELSE GOTO 2080
2025 GOTO 2080
2080 PRINT "Choose rock (R), paper (P), scissors (S) or stats (X)."
2085 PRINT "Your choice (R/P/S/X): ";
2090 INPUT playerChoice$
2100 playerChoice$ = LEFT$(playerChoice$, 1)
2110 IF playerChoice$ = "r" THEN playerChoice$ = "R"
2120 IF playerChoice$ = "p" THEN playerChoice$ = "P"
2130 IF playerChoice$ = "s" THEN playerChoice$ = "S"
2140 IF playerChoice$ = "x" THEN playerChoice$ = "X"
2150 IF playerChoice$ <> "R" AND playerChoice$ <> "P" AND playerChoice$ <> "S" AND playerChoice$ <> "X" THEN PRINT "Invalid choice! Try again.": GOTO 2090
2160 IF playerChoice$ = "X" THEN RETURN
2170 userChoices$(roundCount) = playerChoice$
2180 RETURN

3000 REM Subroutine to get computer choice
3010 IF difficultyLevel = 1 THEN computerChoice$ = MID$("RPS", INT(RND * 3) + 1, 1): GOTO 3030
3011 IF difficultyLevel = 2 THEN GOSUB 3100: GOTO 3030
3012 IF difficultyLevel = 3 THEN GOSUB 3500: GOTO 3030
3030 PRINT "Computer chose: "; computerChoice$
3040 computerChoices$(roundCount) = computerChoice$
3050 RETURN

3100 REM Subroutine to use basic pattern recognition for medium level
3110 IF roundCount > 5 THEN GOSUB 3200 ELSE computerChoice$ = MID$("RPS", INT(RND * 3) + 1, 1)
3120 PRINT "Computer chose: "; computerChoice$
3130 computerChoices$(roundCount) = computerChoice$
3140 RETURN

3200 REM Analyze last 5 player choices for pattern recognition
3210 REM Initialize counts for each choice
3220 rockCount = 0: paperCount = 0: scissorsCount = 0
3230 REM Loop through the last 5 player choices and count each type
3240 FOR i = roundCount - 5 TO roundCount - 1
3250 IF i > 0 THEN GOTO 3270 ELSE GOTO 3300
3270 IF userChoices$(i) = "R" THEN rockCount = rockCount + 1 ELSE GOTO 3290
3280 GOTO 3300
3290 IF userChoices$(i) = "P" THEN paperCount = paperCount + 1 ELSE GOTO 3295
3295 IF userChoices$(i) = "S" THEN scissorsCount = scissorsCount + 1
3300 NEXT i

3310 REM Determine the most frequent player choice in the last 5 rounds
3320 REM Set default to rock for comparison purposes
3330 mostFrequentChoice$ = "R"
3340 IF paperCount > rockCount AND paperCount > scissorsCount THEN mostFrequentChoice$ = "P"
3350 IF scissorsCount > rockCount AND scissorsCount > paperCount THEN mostFrequentChoice$ = "S"
3360 REM Handle ties by random selection among tied choices
3370 IF rockCount = paperCount AND rockCount > scissorsCount THEN mostFrequentChoice$ = MID$("RP", INT(RND * 2) + 1, 1)
3380 IF rockCount = scissorsCount AND rockCount > paperCount THEN mostFrequentChoice$ = MID$("RS", INT(RND * 2) + 1, 1)
3390 IF paperCount = scissorsCount AND paperCount > rockCount THEN mostFrequentChoice$ = MID$("PS", INT(RND * 2) + 1, 1)
3400 IF rockCount = paperCount AND rockCount = scissorsCount THEN mostFrequentChoice$ = MID$("RPS", INT(RND * 3) + 1, 1)

3410 REM Choose computer move to counter the most frequent player choice
3420 REM Introduce randomness to avoid predictability
3430 randNum = INT(RND * 10)
3440 IF mostFrequentChoice$ = "R" THEN computerChoice$ = MID$("PSR", randNum MOD 3 + 1, 1)
3450 IF mostFrequentChoice$ = "P" THEN computerChoice$ = MID$("SRP", randNum MOD 3 + 1, 1)
3460 IF mostFrequentChoice$ = "S" THEN computerChoice$ = MID$("RPS", randNum MOD 3 + 1, 1)
3470 RETURN

3500 REM Advanced pattern recognition for hard level
3510 REM Initialize counts for each choice
3520 rockCount = 0: paperCount = 0: scissorsCount = 0
3530 REM Loop through the last 10 player choices and count each type
3540 FOR i = roundCount - 10 TO roundCount - 1
3550 IF i > 0 THEN GOTO 3570 ELSE GOTO 3600
3570 IF userChoices$(i) = "R" THEN rockCount = rockCount + 1 ELSE GOTO 3590
3580 GOTO 3600
3590 IF userChoices$(i) = "P" THEN paperCount = paperCount + 1 ELSE GOTO 3595
3595 IF userChoices$(i) = "S" THEN scissorsCount = scissorsCount + 1
3600 NEXT i

3610 REM Determine the most frequent player choice in the last 10 rounds
3620 mostFrequentChoice$ = "R"
3630 IF paperCount > rockCount AND paperCount > scissorsCount THEN mostFrequentChoice$ = "P"
3640 IF scissorsCount > rockCount AND scissorsCount > paperCount THEN mostFrequentChoice$ = "S"
3650 REM Handle ties by random selection among tied choices
3660 IF rockCount = paperCount AND rockCount > scissorsCount THEN mostFrequentChoice$ = MID$("RP", INT(RND * 2) + 1, 1)
3670 IF rockCount = scissorsCount AND rockCount > paperCount THEN mostFrequentChoice$ = MID$("RS", INT(RND * 2) + 1, 1)
3680 IF paperCount = scissorsCount AND paperCount > rockCount THEN mostFrequentChoice$ = MID$("PS", INT(RND * 2) + 1, 1)
3690 IF rockCount = paperCount AND rockCount = scissorsCount THEN mostFrequentChoice$ = MID$("RPS", INT(RND * 3) + 1, 1)

3700 REM Choose computer move to counter the most frequent player choice
3710 REM Introduce randomness to avoid predictability
3720 randNum = INT(RND * 10)
3730 IF mostFrequentChoice$ = "R" THEN computerChoice$ = MID$("PSR", randNum MOD 3 + 1, 1)
3740 IF mostFrequentChoice$ = "P" THEN computerChoice$ = MID$("SRP", randNum MOD 3 + 1, 1)
3750 IF mostFrequentChoice$ = "S" THEN computerChoice$ = MID$("RPS", randNum MOD 3 + 1, 1)
3760 RETURN

4000 REM Subroutine to determine winner and update score
4010 IF playerChoice$ = computerChoice$ THEN PRINT : PRINT "Tie! Scores remain the same.": tieCount = tieCount + 1: RETURN
4020 IF (playerChoice$ = "R" AND computerChoice$ = "S") OR (playerChoice$ = "P" AND computerChoice$ = "R") OR (playerChoice$ = "S" AND computerChoice$ = "P") THEN GOSUB 4100: RETURN
4030 GOSUB 4200: RETURN

4100 REM Player wins
4110 PRINT CHR$(7): PRINT : PRINT "*** You win! ***"
4120 IF bonusRound = 1 THEN userScore = userScore + 2 ELSE userScore = userScore + 1
4130 RETURN

4200 REM Computer wins
4210 PRINT : PRINT "<<< Computer wins! >>>"
4220 IF bonusRound = 1 THEN computerScore = computerScore + 2 ELSE computerScore = computerScore + 1
4230 RETURN

5000 REM Subroutine to display scores
5010 PRINT : PRINT "Your score: "; userScore
5020 PRINT "Computer score: "; computerScore
5030 PRINT "Rounds played: "; roundCount
5040 RETURN

6000 REM Subroutine to display end game message
6010 PRINT : PRINT "Game over!"
6020 IF userScore > computerScore THEN PRINT "*** Congratulations, you won the game! ***"
6030 IF computerScore > userScore THEN PRINT "<<< Sorry, the computer won the game. >>>"
6040 IF userScore = computerScore THEN PRINT "=== The game is a tie. ==="
6050 PRINT : PRINT "Final Scores:"
6060 PRINT "  Your score: "; userScore
6070 PRINT "  Computer score: "; computerScore
6080 PRINT "  Total ties: "; tieCount
6090 PRINT
6100 RETURN

7000 REM Subroutine to initialize game state
7010 userScore = 0
7020 computerScore = 0
7030 roundCount = 1
7040 tieCount = 0
7050 FOR i = 1 TO 100
7060   userChoices$(i) = ""
7070   computerChoices$(i) = ""
7080 NEXT i
7090 RETURN

8000 REM Subroutine to display game statistics
8010 PRINT:PRINT "*********************************************"
8020 PRINT "*                Game Statistics            *"
8030 PRINT "*********************************************"
8040 PRINT "* Total rounds played: "; roundCount - 1
8050 PRINT "* Total ties: "; tieCount
8060 PRINT "* Total player wins: "; userScore
8070 PRINT "* Total computer wins: "; computerScore
8080 userRockCount = 0: userPaperCount = 0: userScissorsCount = 0
8090 computerRockCount = 0: computerPaperCount = 0: computerScissorsCount = 0
8100 FOR i = 1 TO roundCount - 1
8110   IF userChoices$(i) = "R" THEN userRockCount = userRockCount + 1
8120   IF userChoices$(i) = "P" THEN userPaperCount = userPaperCount + 1
8130   IF userChoices$(i) = "S" THEN userScissorsCount = userScissorsCount + 1
8140   IF computerChoices$(i) = "R" THEN computerRockCount = computerRockCount + 1
8150   IF computerChoices$(i) = "P" THEN computerPaperCount = computerPaperCount + 1
8160   IF computerChoices$(i) = "S" THEN computerScissorsCount = computerScissorsCount + 1
8170 NEXT i
8180 PRINT "* Player choices: Rock = "; userRockCount; ", Paper = "; userPaperCount; ", Scissors = "; userScissorsCount
8190 PRINT "* Computer choices: Rock = "; computerRockCount; ", Paper = "; computerPaperCount; ", Scissors = "; computerScissorsCount
8200 PRINT "*********************************************"
8210 RETURN