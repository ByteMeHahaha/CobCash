      *Screen for user input (the "EFT transaction")
       01  SC-Payment-Screen
           BACKGROUND-COLOUR 7  *> White
           FOREGROUND-COLOUR 0. *> Black
      *    Clears the terminal screen.
           05 BLANK SCREEN.
      *    Screen heading
           05 LINE 2 COL 3 VALUE "Final Payment".
           05 LINE 3 COL 3 VALUE "----------------------".

      *    Cardholder Name label
           05 LINE 6 COL 3 VALUE "Cardholder Name: ".
      *    Cardholder Name input
           05 LINE 6 COL PLUS 1 PIC X(45) USING WS-Holder-Name
              REVERSE-VIDEO *> Reverses the colours of the input field
              REQUIRED. *> Can"t continue without filling this field in.
      *    Card PIN number label
           05 LINE 7 COL 3 VALUE "Card PIN: ".
      *    Card PIN number input
           05 LINE 7 COLUMN PLUS 1 PIC 9(5) USING WS-PIN
              REVERSE-VIDEO
              REQUIRED
              AUTO-SKIP
              SECURE. *> Mask input with asterisks

      *    Divider line
           05 LINE 8 COL 3 VALUE "======================================
      -    "================================".

      *    Funds transfer heading
           05 LINE 10 COL 3 VALUE "Details About Purchase".
           05 LINE 11 COL 3 VALUE "----------------------".

           05 LINE 13 COL 3 VALUE "Amount Owed: ".
           05 LINE 13 COL PLUS 1 PIC $ZZZZZ9.99 FROM WS-Owed.

           05 LINE 14 COL 3 VALUE "Amount Paid: ".
           05 LINE 14 COL PLUS 1 PIC $ZZZZZ9.99 USING WS-Paid
              REVERSE-VIDEO
              REQUIRED.
