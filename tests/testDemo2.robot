*** Settings ***
Documentation    To validate the login form
Library          SeleniumLibrary
Library          Collections
Test Setup       open the browser with the mortgage url
Test Teardown    Close Browser Session
Resource         ../PO/Generic.robot


*** Variables ***

${Error_MessageLogin}=       css:.alert-danger
${shop_page_load}=           css:.nav-link

*** Test Cases ***

Validate UnSuccessful login
    [Tags]    SMOKE
    Fill the login form        ${user_name}        ${invalid_password}
    wait until element is located in the page      ${Error_MessageLogin}
    verify error message is correct

Validate Cards display in the shopping page
    Fill The Login Form        ${user_name}        ${valid_password}
    wait until element is located in the page      ${shop_page_load}
    Verify Card titles in the shop page
    Select the Card        Samsung Note 8

Select the form and fill login details
    Fill the login details and login form


*** Keywords ***

Fill the login form
    [Arguments]           ${username}        ${password}

    Input Text            id:username    ${username}
    Input Password        id:password    ${password}
    Click Button          signInBtn

wait until element is located in the page

    [Arguments]        ${element}
    Wait Until Element Is Visible        ${element}

verify error message is correct

    ${result}=    Get Text        ${Error_MessageLogin}
    Should Be Equal As Strings       ${result}        Incorrect username/password.
    Element Text Should Be            ${Error_MessageLogin}    Incorrect username/password.

# @ is used for creating new lists
Verify Card titles in the shop page

    @{expected_list}=    Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    @{elements}=         Get Webelements    CSS:.card-title
    @{actual_list}=      Create List

    FOR    ${element}    IN    @{elements}
        Log    ${element.text}
        Append To List    ${actual_list}    ${element.text}
    END
    Lists Should Be Equal        ${expected_list}        ${actual_list}

# to assign a value to the variable we use a keyword called Set Variable in robot framework
Select the Card
    [Arguments]    ${card_name}
    ${elements}=    Get Webelements    CSS:.card-title
    ${index}=    Set Variable    1
    FOR    ${element}    IN    @{elements}
        Exit For Loop If    '${card_name}' == '${element.text}'
        ${index}=    Evaluate    ${index} + 1
    END
    Click Button    xpath:(//button[@class='btn btn-info'])[${index}]

Fill the login details and login form
    Input Text            id:username    rahulshettyacademy
    Input Password        id:password    library
    Click Element         xpath://input[@value='user']
    Sleep    2s
    Wait Until Element Is Visible    xpath://button[@id='okayBtn']
    Click Element         okayBtn
    Wait Until Element Is Not Visible    xpath://button[@id='okayBtn']
    Select From List By Value    css:select.form-control    teach
    Select Checkbox    terms
    Checkbox Should Be Selected    terms
