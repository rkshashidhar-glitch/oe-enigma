DEFINE VARIABLE sourceFile AS CHARACTER NO-UNDO.
DEFINE VARIABLE messageIndex AS INTEGER NO-UNDO.

sourceFile = SESSION:PARAMETER.
SESSION:EXIT-CODE = 1.

IF sourceFile = ? OR sourceFile = "" THEN DO:
    PUT UNFORMATTED "Missing source filename. Supply -param <source-file>." SKIP.
    QUIT.
END.

DO ON STOP UNDO, LEAVE:
    COMPILE VALUE(sourceFile) NO-ERROR.

    SESSION:EXIT-CODE = IF COMPILER:ERROR THEN 1 ELSE 0.

    DO messageIndex = 1 TO COMPILER:NUM-MESSAGES:
        PUT UNFORMATTED
            COMPILER:GET-FILE-NAME(messageIndex) ":"
            COMPILER:GET-ROW(messageIndex) ":"
            COMPILER:GET-COLUMN(messageIndex) ": "
            COMPILER:GET-MESSAGE(messageIndex) SKIP.
    END.

    IF COMPILER:ERROR THEN
        PUT UNFORMATTED "Compilation failed: " sourceFile SKIP.
    ELSE
        PUT UNFORMATTED "Compilation succeeded: " sourceFile SKIP.
END.

QUIT.
