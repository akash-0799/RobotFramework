*** Settings ***
Library     Collections
*** Test Cases ***
Sum values from list
        @{listOfNumber}=    Create List        1   2   3   4   5
        ${sum}=   Set Variable      0
        FOR    ${number}   IN  @{listOfNumber}
            ${sum}=       Evaluate    ${sum}+${number}
        END
        Log to console     ${sum}