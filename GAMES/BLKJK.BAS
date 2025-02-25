5 RANDOMIZE  ' SEED THE RANDOM NUMBER GENERATOR
10 PLAYER_SURRENDERED = 0  ' INITIALIZE PLAYER SURRENDERED FLAG
15 DIM CARD(312), VALUE(312), PLAYER_CARD(20), DEALER_CARD(10)  ' DECLARE ARRAYS FOR CARDS AND THEIR VALUES
20 DIM A$(1), UPPER_A$(1)  ' DECLARE VARIABLES FOR USER INPUT
25 FIRST_MOVE = 1  ' FLAG TO TRACK IF IT IS THE PLAYER'S FIRST MOVE
30 DEALER_PLAYED = 0  ' INITIALIZE DEALER PLAYED FLAG
33 PLAYER_BUSTED = 0  ' INITIALIZE PLAYER BUSTED FLAG
35 HAND = 0  ' INITIALIZE HAND TRACKING VARIABLE
36 PLAYER_SURRENDERS = 0  ' INITIALIZE PLAYER SURRENDER COUNTER
37 GOSUB 3800  ' INITIALIZE STATISTICS
40 GOSUB 4000  ' DISPLAY TITLE SCREEN
50 GOSUB 5000  ' DISPLAY INSTRUCTIONS
55 GOSUB 13000 ' DEALER OPENING MESSAGE SUBROUTINE
57 BANKROLL = 1000  ' INITIALIZE PLAYER'S BANKROLL

60 REM START OF GAME LOOP
70 IF BANKROLL <= 0 THEN GOSUB 7200: GOTO 90  ' END GAME IF BANKROLL IS ZERO OR LESS
75 FIRST_MOVE = 1  ' ENSURE FIRST_MOVE IS SET TO 1 AT THE START OF EACH GAME
80 GOSUB 1000  ' MAIN GAME SUBROUTINE
90 INPUT "DO YOU WANT TO PLAY AGAIN? (Y/N) "; A$
100 GOSUB 6000  ' CONVERT INPUT TO UPPERCASE
110 IF UPPER_A$ = "Y" THEN GOTO 70  ' RESTART GAME
120 IF UPPER_A$ = "N" THEN GOSUB 7000: GOSUB 7400: GOTO 15000
130 PRINT "INVALID INPUT. PLEASE ENTER Y OR N."
140 GOTO 90  ' ASK AGAIN

1000 REM MAIN GAME SUBROUTINE
1010 REM INITIALIZE CARDS AND VALUES
1020 FOR I = 1 TO 312 '6 decks (312 cards)
1030 CARD(I) = I  ' ASSIGN CARD NUMBER TO ARRAY
1040 VALUE(I) = (I - 1) MOD 13 + 1  ' ASSIGN CARD VALUE (1 TO 13)
1050 IF VALUE(I) > 10 THEN VALUE(I) = 10  ' FACE CARDS ARE WORTH 10
1060 IF VALUE(I) = 1 THEN VALUE(I) = 11  ' ACES INITIALLY WORTH 11
1070 NEXT I  ' MOVE TO THE NEXT CARD
1080 REM SHUFFLE CARDS USING FISHER-YATES ALGORITHM
1090 FOR I = 52 TO 2 STEP -1
1100 J = INT(RND * I) + 1  ' SELECT RANDOM POSITION
1110 IF I = J THEN GOTO 1140  ' SKIP SWAP IF I AND J ARE THE SAME
1120 T = CARD(I)  ' SWAP CARDS
1130 CARD(I) = CARD(J)
1140 CARD(J) = T
1145 NEXT I  ' MOVE TO THE NEXT CARD
1150 REM INITIALIZE GAME STATE
1151 DEALER_PLAYED = 0  ' RESET DEALER PLAYED FLAG
1152 PLAYER_BUSTED = 0  ' RESET PLAYER BUSTED FLAG
1160 PLAYER_TOTAL = 0
1170 DEALER_TOTAL = 0
1180 PLAYER_COUNT = 0
1190 DEALER_COUNT = 0
1200 NEXT_CARD_INDEX = 1  ' START DEALING FROM THE FIRST CARD
1210 PRINT "****************************"
1220 PRINT "CURRENT BANKROLL: $"; BANKROLL
1230 INPUT "ENTER YOUR BET: $"; BET$
1235 GOSUB 8500  ' VALIDATE BET INPUT
1240 IF VALID_BET = 0 THEN PRINT "INVALID BET! PLEASE ENTER A NUMBER.": GOTO 1230
1250 BET = VAL(BET$)  ' CONVERT VALID STRING INPUT TO A NUMERIC VALUE
1255 IF BET < 1 OR BET > BANKROLL THEN PRINT "INVALID BET AMOUNT!": GOTO 1230
1258 TOTAL_MONEY_BET = TOTAL_MONEY_BET + BET  ' UPDATE TOTAL MONEY BET
1259 PRINT "****************************"

1260 REM INITIAL DEAL
1270 FOR I = 1 TO 2
1280 PLAYER_COUNT = PLAYER_COUNT + 1  ' DEAL TO PLAYER
1290 PLAYER_CARD(PLAYER_COUNT) = CARD(NEXT_CARD_INDEX)
1300 PLAYER_TOTAL = PLAYER_TOTAL + VALUE(PLAYER_CARD(PLAYER_COUNT))
1310 NEXT_CARD_INDEX = NEXT_CARD_INDEX + 1
1320 IF I = 1 THEN GOTO 1330 ELSE GOTO 1380
1330 DEALER_COUNT = DEALER_COUNT + 1  ' DEAL ONE CARD TO DEALER (VISIBLE CARD)
1340 DEALER_CARD(DEALER_COUNT) = CARD(NEXT_CARD_INDEX)
1350 DEALER_TOTAL = DEALER_TOTAL + VALUE(DEALER_CARD(DEALER_COUNT))
1360 NEXT_CARD_INDEX = NEXT_CARD_INDEX + 1
1370 GOTO 1380
1380 NEXT I  ' REPEAT FOR THE SECOND CARD
1390 DEALER_COUNT = DEALER_COUNT + 1  ' DEAL SECOND CARD TO DEALER (HIDDEN CARD)
1400 DEALER_CARD(DEALER_COUNT) = CARD(NEXT_CARD_INDEX)
1410 REM DO NOT ADD HIDDEN CARD TO DEALER_TOTAL YET
1420 NEXT_CARD_INDEX = NEXT_CARD_INDEX + 1
1430 PRINT "****************************"
1440 PRINT "* DEALER'S VISIBLE CARD: "; VALUE(DEALER_CARD(1))
1450 PRINT "****************************"
1460 GOSUB 9500  ' DISPLAY AND DESCRIBE PLAYER'S INITIAL CARDS

1470 REM CHECK IF DEALER AND PLAYER BOTH HAVE 21 AFTER THE INITIAL DEAL
1480 DEALER_TOTAL = DEALER_TOTAL + VALUE(DEALER_CARD(2))  ' ADD HIDDEN CARD VALUE TO TOTAL
1490 IF DEALER_TOTAL = 21 AND PLAYER_TOTAL = 21 THEN PRINT "PUSH! BOTH YOU AND THE DEALER HAVE 21.": GOSUB 3963: GOTO 70
1495 IF DEALER_TOTAL = 21 THEN PRINT "DEALER HAS BLACKJACK! YOU LOSE!": PRINT CHR$(7): BANKROLL = BANKROLL - BET: GOSUB 4100: GOTO 70
1498 DEALER_TOTAL = DEALER_TOTAL - VALUE(DEALER_CARD(2))  ' REMOVE HIDDEN CARD VALUE TO RESTORE INITIAL STATE

1500 REM PLAYER'S TURN - INITIAL DECISION
1510 GOSUB 9500  ' DISPLAY AND DESCRIBE PLAYER'S CARDS
1580 IF PLAYER_TOTAL = 21 AND PLAYER_COUNT = 2 THEN PRINT "BLACKJACK! YOU WIN!": PRINT CHR$(7): PRINT "==> DEALER: BEGINNER'S LUCK!": BANKROLL = BANKROLL + BET * 2.5: GOSUB 3901: RETURN
1590 IF PLAYER_TOTAL = 21 THEN PRINT "YOU WIN!": PRINT CHR$(7): BANKROLL = BANKROLL + (BET * 2): GOSUB 3901: RETURN
1600 IF PLAYER_TOTAL > 21 THEN GOSUB 1990: IF PLAYER_TOTAL > 21 THEN RETURN  ' ADJUST ACES AND RETURN IF BUST
1610 PRINT "* DEALER'S VISIBLE CARD: "; VALUE(DEALER_CARD(1))
1620 GOSUB 10680  ' CALL THE PLAYER DECISION SUBROUTINE
1800 GOTO 3000  ' EXIT PLAYER'S TURN CLEANLY

1850 REM PLAYER DOUBLES DOWN
1860 IF BET * 2 > BANKROLL THEN PRINT CHR$(7):PRINT "INSUFFICIENT FUNDS TO DOUBLE DOWN!": GOTO 1620
1870 BET = BET * 2  ' DOUBLE THE BET
1880 GOSUB 2110  ' DEAL ONE MORE CARD TO PLAYER AND HANDLE BUST
1885 IF PLAYER_TOTAL > 21 THEN GOTO 1945  ' IF BUSTED, SKIP FINAL CARD MESSAGE
1890 PRINT "****************************"
1900 PRINT "* YOUR FINAL CARD: "; VALUE(PLAYER_CARD(PLAYER_COUNT))
1910 GOSUB 9500  ' DISPLAY AND DESCRIBE PLAYER'S CARDS
1920 IF PLAYER_TOTAL = 21 THEN PRINT CHR$(7): PRINT "YOU REACHED 21!": GOSUB 3000: RETURN  ' CORRECTED MESSAGE FOR NON-BLACKJACK 21
1945 RETURN

1950 REM PLAYER SURRENDERS
1955 PRINT "YOU CHOSE TO SURRENDER. YOU FORFEIT HALF OF YOUR BET."
1956 PRINT CHR$(7): PRINT "==> DEALER: SOMETIMES IT'S WISE TO CUT YOUR LOSSES."
1960 BANKROLL = BANKROLL - BET / 2  ' FORFEIT HALF THE BET
1961 TOTAL_MONEY_LOST = TOTAL_MONEY_LOST + BET / 2  ' CORRECTLY UPDATE MONEY LOST
1962 PLAYER_SURRENDERED = 1  ' SET PLAYER SURRENDERED FLAG
1963 PLAYER_SURRENDERS = PLAYER_SURRENDERS + 1  ' INCREMENT PLAYER SURRENDER COUNTER
1967 DEALER_PLAYED = 1  ' INDICATE THAT DEALER'S TURN SHOULD BE SKIPPED
1970 PRINT "CURRENT BANKROLL: $"; BANKROLL
1980 RETURN

1990 REM ADJUST TOTAL FOR ACES (FOR BOTH PLAYER AND DEALER)
1991 REM ADJUST ACES FOR PLAYER
1992 FOR I = 1 TO PLAYER_COUNT
1993 IF VALUE(PLAYER_CARD(I)) = 11 AND PLAYER_TOTAL > 21 THEN 
1994 PLAYER_TOTAL = PLAYER_TOTAL - 10
1995 VALUE(PLAYER_CARD(I)) = 1
1996 END IF
1999 NEXT I

2000 REM ADJUST ACES FOR DEALER
2001 FOR I = 1 TO DEALER_COUNT
2002 IF VALUE(DEALER_CARD(I)) = 11 AND DEALER_TOTAL > 21 THEN 
2003 DEALER_TOTAL = DEALER_TOTAL - 10
2004 VALUE(DEALER_CARD(I)) = 1
2005 END IF
2008 NEXT I
2009 RETURN

2110 REM DEAL ANOTHER CARD TO PLAYER
2120 PLAYER_COUNT = PLAYER_COUNT + 1
2130 PLAYER_CARD(PLAYER_COUNT) = CARD(NEXT_CARD_INDEX)
2140 NEXT_CARD_INDEX = NEXT_CARD_INDEX + 1
2150 PLAYER_TOTAL = PLAYER_TOTAL + VALUE(PLAYER_CARD(PLAYER_COUNT))
2160 GOSUB 1990  ' ADJUST ACES AFTER ADDING CARD
2170 PRINT "****************************"
2180 PRINT "* NEW CARD: "; VALUE(PLAYER_CARD(PLAYER_COUNT))
2190 PRINT " "
2195 GOSUB 9500  ' DISPLAY AND DESCRIBE PLAYER'S CARDS
2197 IF PLAYER_TOTAL > 21 THEN GOSUB 2200: RETURN  ' BUST AND EXIT TO GAME LOOP
2198 RETURN

2200 REM BUST MESSAGE SUBROUTINE
2201 PRINT CHR$(7): PRINT "BUSTED! YOU LOSE!"
2203 GOSUB 11000
2205 BANKROLL = BANKROLL - BET  ' DEDUCT THE BET AMOUNT
2206 IF BANKROLL < 0 THEN BANKROLL = 0
2207 GOSUB 4100  ' UPDATE LOSS STATISTICS
2208 PLAYER_BUSTED = 1  ' SET PLAYER BUSTED FLAG
2209 FIRST_MOVE = 1  ' RESET FIRST MOVE FLAG
2210 RETURN

3000 REM DEALER'S TURN
3010 IF PLAYER_BUSTED = 1 THEN RETURN  ' SKIP DEALER'S TURN IF PLAYER BUSTED
3020 IF DEALER_PLAYED = 1 THEN RETURN  ' SKIP DEALER'S TURN IF ALREADY PLAYED
3030 DEALER_PLAYED = 1  ' SET FLAG INDICATING DEALER HAS PLAYED
3040 GOSUB 14000 ' DEALER MY TURN MESSAGE ROUTINE

3050 REM REVEAL THE DEALER'S HIDDEN CARD AND ADD TO TOTAL
3060 DEALER_TOTAL = DEALER_TOTAL + VALUE(DEALER_CARD(2))  ' ADD HIDDEN CARD VALUE
3070 GOSUB 1990  ' ADJUST DEALER'S ACES IF NEEDED
3080 GOSUB 9700  ' DISPLAY DEALER'S CARDS

3090 REM DEALER HITS IF TOTAL IS LESS THAN 17
3100 WHILE DEALER_TOTAL < 17
3110 DEALER_COUNT = DEALER_COUNT + 1
3120 DEALER_CARD(DEALER_COUNT) = CARD(NEXT_CARD_INDEX)
3130 NEXT_CARD_INDEX = NEXT_CARD_INDEX + 1
3140 DEALER_TOTAL = DEALER_TOTAL + VALUE(DEALER_CARD(DEALER_COUNT))
3150 GOSUB 1990  ' ADJUST ACES AFTER ADDING CARD
3160 PRINT "****************************"
3170 PRINT "DEALER HITS: "; VALUE(DEALER_CARD(DEALER_COUNT))
3180 GOSUB 9700  ' DISPLAY DEALER'S CARDS
3190 WEND

3200 REM CHECK IF DEALER BUSTED
3210 IF DEALER_TOTAL > 21 THEN PRINT "****************************": PRINT "DEALER BUSTED! YOU WIN!": PRINT CHR$(7): BANKROLL = BANKROLL + BET: GOSUB 3901: GOTO 90

3220 REM DETERMINE WINNER
3230 PRINT "****************************"
3240 PRINT "DEALER STANDS WITH TOTAL: "; DEALER_TOTAL
3250 PRINT "YOUR TOTAL: "; PLAYER_TOTAL
3260 PRINT "****************************"
3270 IF PLAYER_TOTAL > DEALER_TOTAL THEN GOTO 3280
3285 GOTO 3330
3280 PRINT "YOU WIN!": PRINT CHR$(7)
3290 BANKROLL = BANKROLL + BET  ' ADD DOUBLE THE BET SINCE IT WAS ALREADY DEDUCTED ONCE
3300 PRINT "CURRENT BANKROLL: $"; BANKROLL
3310 GOSUB 3901
3320 GOTO 90
3330 IF DEALER_TOTAL > PLAYER_TOTAL THEN GOTO 3340
3335 GOTO 3345
3340 PRINT "DEALER WINS!": GOSUB 11000
3341 BANKROLL = BANKROLL - BET
3342 PRINT "CURRENT BANKROLL: $"; BANKROLL
3343 GOSUB 4100
3344 GOTO 90
3345 PRINT "IT'S A TIE!": GOSUB 12000
3350 GOSUB 3963  ' UPDATE STATISTICS FOR A TIE
3360 PRINT "CURRENT BANKROLL: $"; BANKROLL
3370 GOTO 90

3800 REM INITIALIZE STATISTICS
3810 TOTAL_GAMES_PLAYED = 0
3820 TOTAL_WINS = 0
3830 TOTAL_LOSSES = 0
3840 TOTAL_BLACKJACKS = 0
3850 TOTAL_BUSTS = 0
3860 HIGHEST_BANKROLL = 1000
3870 TOTAL_MONEY_BET = 0
3880 TOTAL_MONEY_WON = 0
3890 TOTAL_MONEY_LOST = 0
3891 TOTAL_TIES = 0
3900 RETURN

3901 REM UPDATE WIN STATISTICS
3910 TOTAL_GAMES_PLAYED = TOTAL_GAMES_PLAYED + 1  ' INCREMENT TOTAL GAMES PLAYED
3920 TOTAL_WINS = TOTAL_WINS + 1  ' INCREMENT TOTAL WINS
3930 IF PLAYER_TOTAL = 21 AND PLAYER_COUNT = 2 THEN TOTAL_BLACKJACKS = TOTAL_BLACKJACKS + 1  ' CHECK FOR BLACKJACK
3940 TOTAL_MONEY_WON = TOTAL_MONEY_WON + BET  ' UPDATE TOTAL MONEY WON
3950 IF BANKROLL > HIGHEST_BANKROLL THEN HIGHEST_BANKROLL = BANKROLL  ' UPDATE HIGHEST BANKROLL
3960 RETURN

3963 REM UPDATE TIE STATISTICS
3965 TOTAL_GAMES_PLAYED = TOTAL_GAMES_PLAYED + 1
3966 TOTAL_TIES = TOTAL_TIES + 1  ' INCREMENT TOTAL TIES
3967 RETURN

4000 REM TITLE SCREEN SUBROUTINE
4005 PRINT CHR$(12) ' CLEAR SCREEN
4010 PRINT "****************************************"
4015 PRINT "*                                      *"
4020 PRINT "*        WELCOME TO BLACKJACK          *"
4025 PRINT "*                                      *"
4030 PRINT "*      CREATED BY CHRISTOPHER          *"
4035 PRINT "*       D. VAN DER KAAY                *"
4040 PRINT "*                                      *"
4045 PRINT "****************************************"
4050 PRINT "*                                      *"
4055 PRINT "*   +----+  +----+  +----+  +----+     *"
4060 PRINT "*   | K  |  | Q  |  | J  |  | A  |     *"
4065 PRINT "*   | *  |  | #  |  | @  |  | %  |     *"
4070 PRINT "*   +----+  +----+  +----+  +----+     *"
4075 PRINT "*                                      *"
4080 PRINT "*   PRESS ENTER TO START THE GAME!     *"
4085 PRINT "*                                      *"
4090 PRINT "****************************************"
4095 INPUT ""; A$  ' WAIT FOR PLAYER TO PRESS ENTER
4096 RETURN

4100 REM UPDATE LOSS STATISTICS
4105 TOTAL_GAMES_PLAYED = TOTAL_GAMES_PLAYED + 1  ' INCREMENT TOTAL GAMES PLAYED
4110 IF PLAYER_SURRENDERED = 0 THEN TOTAL_LOSSES = TOTAL_LOSSES + 1  ' INCREMENT TOTAL LOSSES ONLY IF NOT SURRENDERED
4115 IF PLAYER_TOTAL > 21 THEN TOTAL_BUSTS = TOTAL_BUSTS + 1  ' CHECK FOR BUST
4120 IF PLAYER_SURRENDERED = 0 THEN TOTAL_MONEY_LOST = TOTAL_MONEY_LOST + BET  ' UPDATE TOTAL MONEY LOST ONLY IF NOT SURRENDERED
4125 PLAYER_SURRENDERED = 0  ' RESET PLAYER SURRENDERED FLAG FOR NEXT GAME
4130 RETURN


5000 REM INSTRUCTIONS SUBROUTINE
5005 PRINT CHR$(12)  ' CLEAR SCREEN
5010 PRINT "DO YOU WANT TO READ THE INSTRUCTIONS? (Y/N) "; 
5020 INPUT A$
5030 GOSUB 6000  ' CONVERT INPUT TO UPPERCASE
5040 IF UPPER_A$ = "Y" THEN GOTO 5062
5045 IF UPPER_A$ = "N" THEN RETURN
5050 PRINT "INVALID INPUT. PLEASE ENTER Y OR N."
5060 GOTO 5020  ' ASK AGAIN
5062 PRINT CHR$(12)
5064 PRINT "===================="
5070 PRINT "   INSTRUCTIONS     "
5080 PRINT "===================="
5090 PRINT
5100 PRINT "1. OBJECTIVE:"
5110 PRINT "   GET AS CLOSE TO 21 AS POSSIBLE WITHOUT EXCEEDING IT."
5120 PRINT
5130 PRINT "2. CARD VALUES:"
5140 PRINT "   - NUMBER CARDS (2-10) ARE FACE VALUE."
5150 PRINT "   - FACE CARDS (J, Q, K) ARE WORTH 10."
5160 PRINT "   - ACES CAN BE 1 OR 11."
5170 PRINT
5173 PRINT "PRESS ENTER TO CONTINUE..."
5175 INPUT ""; A$
5180 PRINT "3. GAMEPLAY:"
5190 PRINT "   - BOTH YOU AND THE DEALER START WITH TWO CARDS."
5200 PRINT "   - ONE OF THE DEALER'S CARDS IS FACE UP."
5210 PRINT "   - YOUR CARDS ARE FACE UP."
5220 PRINT "   - THE GAME USES 6 DECKS OF CARDS."
5230 PRINT
5240 PRINT "4. YOUR TURN:"
5250 PRINT "   - [H]IT: TAKE ANOTHER CARD."
5260 PRINT "   - [S]TAND: END YOUR TURN."
5270 PRINT "   - [D]OUBLE DOWN: DOUBLE YOUR BET, TAKE ONE FINAL CARD, AND END YOUR TURN."
5280 PRINT "   - [R] SURRENDER: FORFEIT HALF YOUR BET AND END YOUR TURN."
5290 PRINT
5295 PRINT "PRESS ENTER TO CONTINUE..."
5300 INPUT ""; A$
5310 PRINT CHR$(12)
5360 PRINT "5. DEALER'S TURN:"
5370 PRINT "   - DEALER HITS UNTIL THE TOTAL IS 17 OR MORE."
5380 PRINT "   - DEALER MUST STAND ON 17 OR HIGHER."
5390 PRINT "   - DEALER'S ACES ADJUST FROM 11 TO 1 IF NECESSARY TO AVOID BUSTING."
5400 PRINT
5410 PRINT "6. WINNING:"
5420 PRINT "   - IF YOUR TOTAL IS CLOSER TO 21 THAN THE DEALER'S, YOU WIN."
5430 PRINT "   - IF THE DEALER'S TOTAL IS CLOSER TO 21, THE DEALER WINS."
5440 PRINT "   - A TIE RESULTS IN NO CHANGE TO THE BANKROLL."
5450 PRINT
5460 PRINT "PRESS ENTER TO CONTINUE..."
5470 INPUT ""; A$
5480 PRINT CHR$(12)
5530 PRINT "7. SPECIAL RULES:"
5540 PRINT "   - THE GAME USES 6 DECKS OF CARDS."
5541 PRINT "   - NATURAL BLACKJACK (21 WITH THE FIRST TWO CARDS) PAYS 3:2."
5545 PRINT "     EXAMPLE: IF YOU BET $100 AND GET A NATURAL BLACKJACK, YOU WIN $150 PLUS YOUR ORIGINAL BET, FOR A TOTAL PAYOUT OF $250."
5550 PRINT "   - REGULAR 21 (WITH MORE THAN TWO CARDS) PAYS EVEN MONEY."
5555 PRINT "     EXAMPLE: IF YOU BET $100 AND REACH A TOTAL OF 21 WITH MORE THAN TWO CARDS, YOU WIN $100."
5560 PRINT "   - IF YOU BUST (EXCEED 21), YOU AUTOMATICALLY LOSE."
5565 PRINT "     EXAMPLE: IF YOU BET $200 AND YOUR HAND TOTAL EXCEEDS 21, YOU LOSE $200."
5570 PRINT "   - DEALER BUSTS IF THE TOTAL EXCEEDS 21."
5575 PRINT "     EXAMPLE: IF YOU BET $150 AND THE DEALER BUSTS, YOU WIN $150."
5580 PRINT "   - DOUBLE DOWN: YOU CAN DOUBLE YOUR BET, TAKE ONE FINAL CARD, AND END YOUR TURN."
5585 PRINT "     EXAMPLE: IF YOU BET $50 AND DOUBLE DOWN, YOU BET AN ADDITIONAL $50."
5586 PRINT "     IF YOU WIN WITH THIS HAND, YOUR TOTAL BET ($100) IS PAID OUT."
5590 PRINT "   - SURRENDER: FORFEIT HALF YOUR BET AND END YOUR TURN."
5595 PRINT "     EXAMPLE: IF YOU BET $80 AND SURRENDER, YOU LOSE $40 AND RETAIN $40."
5600 PRINT "   - IF THE DEALER HAS A NATURAL 21 (BLACKJACK) AND YOU DO NOT, YOU LOSE YOUR BET."
5605 PRINT "     EXAMPLE: IF YOU BET $100 AND THE DEALER HAS A NATURAL 21 WHILE YOU DO NOT, YOU LOSE $100."
5608 PRINT "   - IF BOTH YOU AND THE DEALER HAVE A NATURAL 21, IT IS A PUSH (TIE)."
5610 PRINT
5613 PRINT "PRESS ENTER TO CONTINUE..."
5615 INPUT ""; A$  ' WAIT FOR PLAYER TO PRESS ENTER
5620 PRINT "8. TIPS:"
5630 PRINT "   - STAND IF YOUR TOTAL IS 12-16 AND DEALER SHOWS 2-6."
5640 PRINT "   - HIT IF YOUR TOTAL IS 12-16 AND DEALER SHOWS 7 OR MORE."
5650 PRINT "   - ALWAYS HIT IF YOUR TOTAL IS 11 OR LESS."
5660 PRINT "   - DOUBLE DOWN WITH A TOTAL OF 10 OR 11 WHEN DEALER SHOWS LOWER THAN 10."
5670 PRINT "   - SURRENDER IF THE SITUATION LOOKS UNFAVORABLE AND SAVE HALF YOUR BET."
5680 PRINT
5690 PRINT "PRESS ENTER TO CONTINUE..."
5700 INPUT ""; A$  ' WAIT FOR PLAYER TO PRESS ENTER
5705 RETURN

6000 REM CONVERT INPUT TO UPPERCASE
6010 UPPER_A$ = ""
6020 FOR I = 1 TO LEN(A$)
6030 A = ASC(MID$(A$, I, 1))  ' GET ASCII CODE OF CHARACTER
6040 IF A >= 97 THEN GOTO 6050
6045 GOTO 6070
6050 IF A <= 122 THEN A = A - 32
6060 GOTO 6080
6070 UPPER_A$ = UPPER_A$ + CHR$(A)
6075 GOTO 6090
6080 UPPER_A$ = UPPER_A$ + CHR$(A)
6090 NEXT I
6100 RETURN

7000 REM EXIT SCREEN SUBROUTINE
7010 PRINT CHR$(12) ' CLEAR SCREEN
7020 PRINT "CURRENT BANKROLL: $"; BANKROLL
7030 PRINT
7040 PRINT "*********************************"
7050 PRINT "*                               *"
7060 PRINT "*       THINK YOU'VE HAD        *"
7070 PRINT "*       ENOUGH FOR TODAY?       *"
7080 PRINT "*                               *"
7090 PRINT "*       THANKS FOR PLAYING      *"
7100 PRINT "*       BLACKJACK WITH ME!      *"
7110 PRINT "*                               *"
7120 PRINT "*********************************"
7130 PRINT "CREATED BY CHRISTOPHER D. VAN DER KAAY"
7135 PRINT
7140 PRINT "SEE YOU NEXT TIME—IF YOU DARE!"
7150 RETURN

7200 REM BANKRUPT SCREEN SUBROUTINE
7210 PRINT CHR$(12) ' CLEAR SCREEN
7220 PRINT "CURRENT BANKROLL: $"; BANKROLL
7230 PRINT
7240 PRINT "*********************************"
7250 PRINT "*                               *"
7260 PRINT "*          BANKRUPT!            *"
7270 PRINT "*        GAME OVER!             *"
7280 PRINT "*                               *"
7290 PRINT "*********************************"
7285 PRINT
7300 PRINT "LOOKS LIKE YOU'RE OUT OF FUNDS. TOUGH LUCK!"
7310 PRINT "DON'T LET IT GET TO YOU. EVEN THE BEST HAVE BAD DAYS."
7320 PRINT "REMEMBER, BLACKJACK IS ALL ABOUT STRATEGY AND KEEPING YOUR COOL."
7330 PRINT "COME BACK AND TRY AGAIN—MAYBE NEXT TIME YOU'LL HAVE WHAT IT TAKES TO BEAT ME!"
7340 PRINT CHR$(7)
7350 GOSUB 7400  ' ASK TO VIEW STATISTICS
7360 END

7400 REM ASK TO VIEW STATISTICS
7410 INPUT "DO YOU WANT TO VIEW GAME STATISTICS? (Y/N) "; A$
7420 GOSUB 6000  ' CONVERT INPUT TO UPPERCASE
7430 IF UPPER_A$ = "Y" THEN GOSUB 7500: RETURN
7440 IF UPPER_A$ = "N" THEN RETURN
7450 PRINT "INVALID INPUT. PLEASE ENTER Y OR N."
7460 GOTO 7410  ' ASK AGAIN

7500 REM DISPLAY GAME STATISTICS
7510 PRINT CHR$(12) ' CLEAR SCREEN
7520 PRINT "*********************************"
7530 PRINT "*      PLAYER GAME STATISTICS   *"
7540 PRINT "*********************************"
7550 PRINT "* TOTAL GAMES PLAYED:     "; TOTAL_GAMES_PLAYED
7551 PRINT "* TOTAL WINS:             "; TOTAL_WINS
7552 PRINT "* TOTAL LOSSES:           "; TOTAL_LOSSES
7553 PRINT "* TOTAL TIES:             "; TOTAL_TIES
7554 PRINT "* TOTAL BLACKJACKS:       "; TOTAL_BLACKJACKS
7555 PRINT "* TOTAL BUSTS:            "; TOTAL_BUSTS
7556 PRINT "* TOTAL SURRENDERS:       "; PLAYER_SURRENDERS
7557 PRINT "*********************************"
7558 PRINT "*      FINANCIAL STATS          *"
7560 PRINT "* HIGHEST BANKROLL:      $"; HIGHEST_BANKROLL
7561 PRINT "* TOTAL MONEY BET:       $"; TOTAL_MONEY_BET
7562 PRINT "* TOTAL MONEY WON:       $"; TOTAL_MONEY_WON
7563 PRINT "* TOTAL MONEY LOST:      $"; TOTAL_MONEY_LOST
7640 PRINT "*********************************"
7650 PRINT "PRESS ENTER TO CONTINUE..."
7660 INPUT ""; A$  ' WAIT FOR PLAYER TO PRESS ENTER
7670 RETURN

8000 REM ADJUST DEALER'S TOTAL FOR ACES
8010 FOR I = 1 TO DEALER_COUNT
8020 IF VALUE(DEALER_CARD(I)) = 11 THEN GOTO 8030
8030 IF DEALER_TOTAL > 21 THEN DEALER_TOTAL = DEALER_TOTAL - 10: VALUE(DEALER_CARD(I)) = 1
8040 NEXT I
8050 RETURN

8500 REM VALIDATE BET INPUT
8510 VALID_BET = 1  ' ASSUME INPUT IS VALID INITIALLY
8520 FOR I = 1 TO LEN(BET$)
8530 CHAR$ = MID$(BET$, I, 1)
8540 IF CHAR$ < "0" OR CHAR$ > "9" THEN VALID_BET = 0: GOTO 8560
8550 NEXT I
8560 RETURN

9500 REM DISPLAY AND DESCRIBE PLAYER'S CARDS
9510 PRINT "****************************"
9520 PRINT "* YOUR CARDS: ";
9530 FOR I = 1 TO PLAYER_COUNT
9540 PRINT VALUE(PLAYER_CARD(I));
9550 PRINT " ";
9560 NEXT I
9570 PRINT "    TOTAL: "; PLAYER_TOTAL
9580 PRINT "****************************"
9590 RETURN

9700 REM DISPLAY DEALER'S CARDS
9710 PRINT "****************************"
9720 PRINT "* DEALER'S CARDS: ";
9730 FOR I = 1 TO DEALER_COUNT
9740 PRINT VALUE(DEALER_CARD(I));
9750 PRINT " ";
9760 NEXT I
9770 PRINT "    TOTAL: "; DEALER_TOTAL
9780 PRINT "****************************"
9790 RETURN

10680 REM PLAYER'S DECISION SUBROUTINE
10690 PRINT "* DO YOU WANT TO [H]IT, [S]TAND, [D]OUBLE DOWN, [R] SURRENDER? ";
10700 INPUT A$
10720 GOSUB 6000  ' CONVERT INPUT TO UPPERCASE
10730 IF FIRST_MOVE = 0 AND (UPPER_A$ = "D" OR UPPER_A$ = "R") THEN PRINT CHR$(7): PRINT "==> DEALER: YOU CAN ONLY PERFORM THIS ACTION ON YOUR FIRST MOVE!": GOTO 10690
10740 IF UPPER_A$ <> "H" AND UPPER_A$ <> "S" AND UPPER_A$ <> "D" AND UPPER_A$ <> "R" THEN PRINT CHR$(7): PRINT "==> DEALER: INVALID INPUT. PLEASE ENTER H, S, D, OR R.": GOTO 10690
10750 IF UPPER_A$ = "H" THEN GOSUB 2110: FIRST_MOVE = 0: IF PLAYER_TOTAL > 21 THEN RETURN ELSE GOTO 10680
10760 IF UPPER_A$ = "S" THEN PRINT CHR$(7): PRINT "==> DEALER: PLAYING IT SAFE, HUH?": FIRST_MOVE = 0: GOSUB 3000: RETURN
10770 IF UPPER_A$ = "D" THEN GOSUB 1850: FIRST_MOVE = 0: RETURN
10780 IF UPPER_A$ = "R" THEN GOSUB 1950: FIRST_MOVE = 0: RETURN
10830 RETURN

11000 REM DEALER WIN MESSAGES SUBROUTINE
11010 RANDOMIZE
11020 MESSAGE_NUMBER = INT(RND * 5) + 1
11030 ON MESSAGE_NUMBER GOTO 11040, 11050, 11060, 11070, 11080
11040 PRINT CHR$(7): PRINT "==> DEALER: BETTER LUCK NEXT TIME!": RETURN
11050 PRINT CHR$(7): PRINT "==> DEALER: YOU CAN'T WIN THEM ALL!": RETURN
11060 PRINT CHR$(7): PRINT "==> DEALER: CLOSE, BUT NO CIGAR!": RETURN
11070 PRINT CHR$(7): PRINT "==> DEALER: MAYBE NEXT TIME!": RETURN
11080 PRINT CHR$(7): PRINT "==> DEALER: THE HOUSE ALWAYS WINS!": RETURN

12000 REM DEALER TIE MESSAGES SUBROUTINE
12010 RANDOMIZE
12020 MESSAGE_NUMBER = INT(RND * 5) + 1
12030 ON MESSAGE_NUMBER GOTO 12040, 12050, 12060, 12070, 12080
12040 PRINT CHR$(7): PRINT "==> DEALER: A TIE? HOW BORING!": RETURN
12050 PRINT CHR$(7): PRINT "==> DEALER: NO WINNER THIS TIME!": RETURN
12060 PRINT CHR$(7): PRINT "==> DEALER: WELL, THAT WAS UNEXPECTED!": RETURN
12070 PRINT CHR$(7): PRINT "==> DEALER: A DRAW? THAT'S RARE!": RETURN
12080 PRINT CHR$(7): PRINT "==> DEALER: A STALEMATE! INTERESTING!": RETURN

13000 REM DEALER OPENING MESSAGE SUBROUTINE
13010 RANDOMIZE
13020 MESSAGE_NUMBER = INT(RND * 5) + 1
13030 ON MESSAGE_NUMBER GOTO 13040, 13050, 13060, 13070, 13080
13040 PRINT CHR$(7): PRINT "==> DEALER: LET'S SEE IF YOU CAN BEAT ME TODAY!": RETURN
13050 PRINT CHR$(7): PRINT "==> DEALER: LET'S PLAY. BUT DON'T GET YOUR HOPES UP TOO HIGH!": RETURN
13060 PRINT CHR$(7): PRINT "==> DEALER: THINK YOU CAN OUTSMART ME? LET'S SEE WHAT YOU'VE GOT!": RETURN
13070 PRINT CHR$(7): PRINT "==> DEALER: I'VE SEEN BETTER PLAYERS. PROVE ME WRONG!": RETURN
13080 PRINT CHR$(7): PRINT "==> DEALER: READY TO LOSE AGAIN? BRING IT ON!": RETURN

14000 REM DEALER MY TURN MESSAGE ROUTINE
14010 RANDOMIZE
14020 MESSAGE_NUMBER = INT(RND * 5) + 1
14030 ON MESSAGE_NUMBER GOTO 14040, 14050, 14060, 14070, 14080
14040 PRINT CHR$(7): PRINT "==> DEALER: ALRIGHT, MY TURN!": RETURN
14050 PRINT CHR$(7): PRINT "==> DEALER: LET ME TAKE OVER FROM HERE!": RETURN
14060 PRINT CHR$(7): PRINT "==> DEALER: NOW WATCH A PRO IN ACTION!": RETURN
14070 PRINT CHR$(7): PRINT "==> DEALER: STEP ASIDE, IT'S MY TURN!": RETURN
14080 PRINT CHR$(7): PRINT "==> DEALER: TIME FOR ME TO TAKE THE SPOTLIGHT!": RETURN
15000 REM END OF GAME AND CREDITS
15010 PRINT CHR$(12) ' CLEAR SCREEN
15020 PRINT "*************************************"
15030 PRINT "*                                   *"
15040 PRINT "*        THANK YOU FOR PLAYING      *"
15050 PRINT "*                                   *"
15060 PRINT "*          BLACKJACK GAME           *"
15070 PRINT "*                                   *"
15080 PRINT "*        CREATED BY CHRISTOPHER     *"
15090 PRINT "*         D. VAN DER KAAY           *"
15100 PRINT "*                                   *"
15110 PRINT "*************************************"
15120 PRINT "*                                   *"
15130 PRINT "*  WE HOPE YOU ENJOYED THE GAME!    *"
15140 PRINT "*                                   *"
15150 PRINT "*   PLEASE PLAY AGAIN SOON!         *"
15160 PRINT "*                                   *"
15170 PRINT "*************************************"
15180 END
