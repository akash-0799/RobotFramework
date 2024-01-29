*** Settings ***
Documentation      To validate the login form
Library            SeleniumLibrary
Library            DataDriver    file=resources/data.csv    encoding=utf_8    dialect=unix
Test Setup         open the browser with the mortgage url
Test Teardown      Close Browser
Test Template      Validate UnSuccessful Login
Resource           ../PO/Generic.robot

*** Variables ***
${Error_MessageLogin}=   css:.alert-danger

*** Test Cases ***

# Rule 1  the arguments must be exactly same as in csv file
# Rule 2  When file is corrupted or file not found: Run once with default credentials
# test case names we got dynamically from csv file
# if we don't provide test case name then the below statement will be default test case name
Login with user ${username} and password ${password}    xyz    12345

*** Keywords ***

# arguments must be exactly same in csv file
Validate UnSuccessful login
    [Arguments]            ${username}    ${password}
    Fill the login form    ${username}    ${password}
    wait untill it checks and display error message
    verify error message is correct

Fill the login form
    [Arguments]           ${username}        ${password}
    Input Text            id:username        ${username}
    Input Password        id:password        ${password}
    Click Button          signInBtn

wait untill it checks and display error message
    Wait Until Element Is Visible        ${Error_MessageLogin}

verify error message is correct
    ${result}=    Get Text        ${Error_MessageLogin}
    Should Be Equal As Strings       ${result}        Incorrect username/password.
    Element Text Should Be            ${Error_MessageLogin}    Incorrect username/password.