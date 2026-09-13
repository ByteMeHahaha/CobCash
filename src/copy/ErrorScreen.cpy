      *Screen showed on program error.
       01 SC-Error-Screen.
           05 BLANK SCREEN.

           05 LINE 2 COL 3 VALUE "Error!"
              BACKGROUND-COLOUR 14 *> Yellow
              FOREGROUND-COLOUR 4 *> Red
              BLINK.

           05 LINE 4 COL 3 VALUE "Error Message: ".
           05 LINE 4 COL PLUS 1 PIC X(25) FROM WS-Error-Msg.

           05 LINE 5 COL 3 VALUE "Error Code: ".
           05 LINE 5 COL PLUS 1 PIC ZZ9 FROM WS-Error-Code.

           05 LINE 8 COL 3 VALUE "Press Enter to Exit".
