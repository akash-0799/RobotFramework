*** Settings ***

Documentation      To validate the login form
Library            SeleniumLibrary
Library            String
Library            Collections
Test Setup         open the browser with the mortgage url
Test Teardown     Close Browser
Resource           ../PO/Generic.robot

*** Test Cases ***

Validate Child Window Functionality
    [Tags]    NEWFEATURE
    Select the link of Child Window
    Verify the user is switched to Child Window
    Grab the email id in the Child Window
    Switch to Parent Window and enter the email


*** Keywords ***

# Sleep is better for checking whether the entire page is loaded or not

Select the link of Child Window
    Click Element    css:.blinkingText
    Sleep            5

Verify the user is switched to Child Window
    Switch Window    NEW
    Element Text Should Be    css:h1    DOCUMENTS REQUEST

Grab the email id in the Child Window
    ${text}=    Get Text    css:.red
    Log    ${text}
    Log To Console    --------------------------------------------------------------------------
    @{words}=    Split String    ${text}    at
    ${text_split}=    Get From List    ${words}    1
    Log    ${text_split}
    Log To Console    --------------------------------------------------------------------------
    @{words_2}=    Split String    ${text_split}
    ${email}=        Get From List    ${words_2}    0
    Log    ${email}
    Log To Console    --------------------------------------------------------------------------
    Set Global Variable    ${email}

Switch to Parent Window and enter the email
    Switch Window    MAIN
    Title Should Be    LoginPage Practise | Rahul Shetty Academy
    Input Text    id:username    ${email}