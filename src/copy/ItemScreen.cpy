       01  SC-Item-Screen
           BACKGROUND-COLOUR 7  *> White
           FOREGROUND-COLOUR 0. *> Black

           05 BLANK SCREEN.

           05 LINE 2 COL 3 VALUE "Items (Item 1 Required)".
           05 LINE 3 COL 3 VALUE "-----------------------".

           05 LINE 5 COL 3 VALUE "Item".
           05 LINE 5 COL PLUS 31 VALUE "Price".
           05 LINE 5 COL PLUS 19 VALUE "Qty.".

           05 LINE 6 COL 1 VALUE "--------------------------------------
      -    "---------------------------------------".

           05 LINE 8 COL 1 VALUE '1'.
           05 LINE 8 COL 3 PIC X(20) USING WS-Items(1)
              REVERSE-VIDEO
              REQUIRED.
           05 LINE 8 COL PLUS 15 PIC $ZZZZZ9.99 USING WS-Prices(1)
              REVERSE-VIDEO
              REQUIRED.
           05 LINE 8 COL PLUS 15 PIC ZZ9 USING WS-Quantities(1)
              REVERSE-VIDEO
              REQUIRED.

           05 LINE 9 COL 1 VALUE '2'.
           05 LINE 9 COL 3 PIC X(20) USING WS-Items(2)
              REVERSE-VIDEO.
           05 LINE 9 COL PLUS 15 PIC $ZZZZZ9.99 USING WS-Prices(2)
              REVERSE-VIDEO.
           05 LINE 9 COL PLUS 15 PIC ZZ9 USING WS-Quantities(2)
              REVERSE-VIDEO.

           05 LINE 10 COL 1 VALUE '3'.
           05 LINE 10 COL 3 PIC X(20) USING WS-Items(3)
              REVERSE-VIDEO.
           05 LINE 10 COL PLUS 15 PIC $ZZZZZ9.99 USING WS-Prices(3)
              REVERSE-VIDEO.
           05 LINE 10 COL PLUS 15 PIC ZZ9 USING WS-Quantities(3)
              REVERSE-VIDEO.

           05 LINE 11 COL 1 VALUE '4'.
           05 LINE 11 COL 3 PIC X(20) USING WS-Items(4)
              REVERSE-VIDEO.
           05 LINE 11 COL PLUS 15 PIC $ZZZZZ9.99 USING WS-Prices(4)
              REVERSE-VIDEO.
           05 LINE 11 COL PLUS 15 PIC ZZ9 USING WS-Quantities(4)
              REVERSE-VIDEO.

           05 LINE 12 COL 1 VALUE '5'.
           05 LINE 12 COL 3 PIC X(20) USING WS-Items(5)
              REVERSE-VIDEO.
           05 LINE 12 COL PLUS 15 PIC $ZZZZZ9.99 USING WS-Prices(5)
              REVERSE-VIDEO.
           05 LINE 12 COL PLUS 15 PIC ZZ9 USING WS-Quantities(5)
              REVERSE-VIDEO.
