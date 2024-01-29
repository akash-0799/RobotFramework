*** Settings ***
Documentation    All the page objects and keywords of LandingPage.
Library    SeleniumLibrary
Resource    Generic.robot

*** Variables ***
${Error_MessageLogin}=       css:.alert-danger

*** Keywords ***

Fill the login form
    [Arguments]           ${username}        ${password}

    Input Text            id:username    ${username}
    Input Password        id:password    ${password}
    Click Button          signInBtn

wait until element is located in the page
    # Here we are writing generic keyword with locator which point to Generic.robot
    # Keyword entry is there but inyternal logic is sending back to the place where we write common code
    Wait Until element passed is located on Page    ${Error_MessageLogin}

verify error message is correct
    Element Text Should Be            ${Error_MessageLogin}    Incorrect username/password.

Fill the login details and login form
    Input Text            id:username    rahulshettyacademy
    Input Password        id:password    library
    Click Element         xpath://input[@value='user']
    Wait Until Element Is Visible    css:.modal-body    timeout=20s
    Sleep    1s
    Click Element             xpath://button[text()="Okay"]
    Wait Until Element Is Not Visible    css:.modal-body    timeout=2s
    # We can use below code also
    # Wait Until Keyword Succeeds    5s    1s    Element Should Be Visible    css:.modal-body
    # Wait Until Keyword Succeeds    5s    1s    Element Should Not Be Visible    css:.modal-body
    Select From List By Value    css:select.form-control    teach
    Select Checkbox    terms
    Checkbox Should Be Selected    terms
