# This is how we can paramterise the test with different parameters

# to declare module name
*** Settings ***
Documentation      To validate the login form
Library            SeleniumLibrary
Test Setup         open the browser with the mortgage url
Test Teardown      Close Browser
Test Template      Validate UnSuccessful Login
Resource           ../PO/Generic.robot

*** Variables ***
${Error_MessageLogin}=   css:.alert-danger

*** Test Cases ***        username        password
Invalid username          asadad          learning
Invalid password          rahulshetty     learn
special characters        x@$             learning


*** Keywords ***

# It is not a test case it becomes the test template for test data parametrisation for multiple data sets
# Do not forgeet to catch the argument
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
    Should Be Equal As Strings       ${result}                    Incorrect username/password.
    Element Text Should Be           ${Error_MessageLogin}        Incorrect username/password.