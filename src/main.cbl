       IDENTIFICATION DIVISION.
       PROGRAM-ID. CobCash.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *    Declare the file to write the receipt report to
           SELECT Receipt-File ASSIGN TO "Receipt.txt"
           ORGANISATION SEQUENTIAL
      *    Lock the file for use in this program only
           SHARING WITH NO OTHER.

       DATA DIVISION.
       FILE SECTION.
      *File description for the receipt file "Receipt.txt".
       FD  Receipt-File
      *Link "Receipt.txt" to its corresponding report
           REPORT IS Receipt-Report.

       WORKING-STORAGE SECTION.
      *Data about the card.
       01  WS-Card-Data.
      *    The cardholder name
           05 WS-Holder-Name PIC X(45).
      *    Card PIN
           05 WS-PIN PIC 9(5).
      *Plain numeric fields for calculating and storing financial data.
       01  WS-Calc-Finances.
      *    Amount Paid (for calculations)
           05 WS-Paid PIC 999999V99 VALUE 0.
      *    Amount owed (for calculations)
           05 WS-Owed PIC 999999V99 VALUE 0.
      *    Change left over (for calculations)
           05 WS-Change PIC 999999V99 VALUE 0.
      *Edited numeric fields for displaying financial data.
       01  WS-Disp-Finances.
      *    Amount Paid (for display)
           05 WS-Disp-Paid PIC $$$$,$$9.99 VALUE 0.
      *    Amount Owed (for display)
           05 WS-Disp-Owed PIC $$$$,$$9.99 VALUE 0.
      *    Change left over (for display)
           05 WS-Disp-Change PIC $$$$,$$9.99 VALUE 0.
      *Error fields
       01  WS-Error-Values.
           05 WS-Error-Msg PIC X(25) VALUE "Unspecified Error".
           05 WS-Error-Code PIC ZZ9 VALUE 0.
      *Today's date, for use in the REPORT section.
       01  WS-Date PIC 9999/99/99.
      *Miscellaneous data item for report formatting
       01  WS-Equals-Divider PIC X(45) VALUE ALL "=".

      *Items Screen "Tables" (arrays)
       01  WS-Items-Tables.
      *    Item names "Table"
           05 WS-Items PIC X(20) OCCURS 5 TIMES.
      *    Item Prices "Table"
           05 WS-Prices PIC 999999V99 OCCURS 5 TIMES.
      *    Item quantities "table"
           05 WS-Quantities PIC 999 OCCURS 5 TIMES.
      *    Index for PERFORM loops on these tables
           05 I USAGE INDEX.

       REPORT SECTION.
      *The receipt report description
       RD  Receipt-Report
           CONTROLS ARE FINAL *> Don't group fields
           PAGE LIMIT IS 11 LINES *> File is 11 lines long
               HEADING 1 *> heading at line 1
               FIRST DETAIL 5 *> Start of body at line 5
               LAST DETAIL 10. *> End of body at line 10

      *The heading of the receipt
       01  TYPE IS PAGE HEADING.
           05 LINE PLUS 1. *> Line 1 of receipt
      *        A divider made up of "=" signs
               10 COL 1 PIC X(45) SOURCE WS-Equals-Divider.
           05 LINE PLUS 2.
               10 COL 1 VALUE "CobCash Receipt". *> Title
               10 COL 25 PIC 9999/99/99 SOURCE WS-Date. *> Today's date
           05 LINE PLUS 2.
      *        A divider made up of "=" signs
               10 COL 1 PIC X(45) SOURCE WS-Equals-Divider.

      *Receipt body
       01  TYPE CONTROL FOOTING FINAL.
           05 LINE PLUS 1.
              10 COL 1 VALUE "Cardholder Name:".
              10 COL 25 PIC X(45) SOURCE WS-Holder-Name.
           05 LINE PLUS 1.
              10 COL 1 VALUE "Amt. Owed:".
              10 COL 25 PIC $ZZZ,ZZ9.99 SOURCE WS-Owed.
           05 LINE PLUS 1.
              10 COL 1 VALUE "Amt. Paid:".
              10 COL 25 PIC $ZZZ,ZZ9.99 SOURCE WS-Paid.
           05 LINE PLUS 1.
              10 COL 1 VALUE "Change:".
              10 COL 25 PIC $ZZZ,ZZ9.99 SOURCE WS-Change.
           05 LINE PLUS 2.
              10 COL 1 VALUE "Thank you for your patronage!".

       SCREEN SECTION.
      *The screens are defined in separate copybooks for scalability
       COPY "PaymentScreen.cpy".
       COPY "ProcessingScreen.cpy".
       COPY "OutputScreen.cpy".
       COPY "ErrorScreen.cpy".
       COPY "ItemScreen.cpy".

       PROCEDURE DIVISION.
       VariableInitialisation. *> Initialise all the data in this app
      *Initialise data items without a VALUE clause
           INITIALISE WS-Card-Data.
           INITIALISE WS-Date.

      *    Initialise the table items
           PERFORM VARYING I FROM 1 BY 1 UNTIL I EQUALS 5
               INITIALISE WS-Items(I)
               INITIALISE WS-Prices(I)
               INITIALISE WS-Quantities(I)
           END-PERFORM.

      *    Store today's date for use in the report
           MOVE FUNCTION CURRENT-DATE(1:8)
               TO WS-Date.

       AcceptUserInput. *> Show the user input screens
      *    Open the Receipt.txt file and start recording values
      *    for its report.
           OPEN OUTPUT Receipt-File.
           INITIATE Receipt-Report.

      *    Display the item input screen
           DISPLAY SC-Item-Screen.
           ACCEPT SC-Item-Screen.

           PERFORM VARYING I FROM 1 BY 1 UNTIL I EQUALS 5
               COMPUTE
                   WS-Owed = WS-Owed + WS-Prices(I) * WS-Quantities(I)
               END-COMPUTE
           END-PERFORM.

      *    Display the payment screen
           DISPLAY SC-Payment-Screen.
           ACCEPT SC-Payment-Screen.

       Process-User-Input. *> Process user input
      *    Display the processing screen
           DISPLAY SC-Processing-Screen.

           IF WS-Owed > WS-Paid THEN
      *        Assign an appropriate error message
               MOVE "Insufficient Funds" TO WS-Error-Msg
      *        Assign an appropriate error code
               MOVE 101 TO WS-Error-Code

      *        Allow the user to see the processing screen
               CONTINUE AFTER 1 SECONDS

      *        Display the error screen
               DISPLAY SC-Error-Screen
               ACCEPT OMITTED

      *        Stop recording the report data and close its file
               TERMINATE Receipt-Report
               CLOSE Receipt-File

      *        Close the app with the error code "1"
               STOP RUN WITH ERROR 1
           END-IF.

      *    Calculate the change from the transaction
           COMPUTE WS-Change = WS-Paid - WS-Owed.

      *    Move the calculation values to their display variables
           MOVE WS-Change TO WS-Disp-Change.
           MOVE WS-Owed TO WS-Disp-Owed.
           MOVE WS-Paid TO WS-Disp-Paid.

      *    Allows the user to actually see the processing screen
           CONTINUE AFTER 2 SECONDS.

       FinishProgram. *> Close loose ends in the program
      *    Generate the report and terminate it
           GENERATE Receipt-Report.
           TERMINATE Receipt-Report.

           CLOSE Receipt-File.

      *    Display the output screen
           DISPLAY SC-Output-Screen.

      *    Press enter to continue
           ACCEPT OMITTED.

      *    Stop program
           STOP RUN.
       END PROGRAM CobCash.
