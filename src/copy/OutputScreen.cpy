      *Screen for user-friendly output
       01 SC-Output-Screen
           BACKGROUND-COLOUR 7  *> White
           FOREGROUND-COLOUR 0. *> Black

      *    Empties the screen.
           05 BLANK SCREEN.

      *    Payment Summary heading
           05 LINE 2 COL 3
              VALUE "Payment Summary (Press enter to exit)".
           05 LINE 3 COL 3
              VALUE "-------------------------------------".

      *    Display each value entered by the user
           05 LINE 5 COL 3 VALUE "Cardholder Name: ".
           05 LINE 5 COL PLUS 1 PIC X(45) FROM WS-Holder-Name.

           05 LINE 6 COL 3 VALUE "Owed: ".
           05 LINE 6 COL PLUS 3 *> Equalises spacing for all 3 labels
              PIC $$$$,$$9.99 FROM WS-Disp-Owed.

           05 LINE 7 COL 3 VALUE "Paid: ".
           05 LINE 7 COL PLUS 3 PIC $$$$,$$9.99 FROM WS-Disp-Paid.

           05 LINE 8 COL 3 VALUE "Change: ".
           05 LINE 8 COL PLUS 1 PIC $$$$,$$9.99 FROM WS-Disp-Change.

      *    Tell the user to check the newly created Receipt file
           05 LINE 10 COL 3
              VALUE "Please review your receipt (Receipt.txt)".
