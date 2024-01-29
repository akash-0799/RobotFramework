*** Settings ***
Documentation    All the page objects and keywords of LandingPage.
Library    SeleniumLibrary
Library    Collections
Resource    Generic.robot

*** Variables ***
${shop_page_load}=           css:.nav-link

*** Keywords ***

wait until element is located in the page
    # Here we are writing generic keyword with locator which point to Generic.robot
    # Keyword entry is there but inyternal logic is sending back to the place where we write common code
    Wait Until element passed is located on Page    ${shop_page_load}

Verify Card titles in the shop page

    @{expected_list}=    Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    ${elements}=         Get Webelements    CSS:.card-title
    @{actual_list}=      Create List

    FOR    ${element}    IN    @{elements}
        Log    ${element.text}
        Append To List    ${actual_list}    ${element.text}
    END
    Lists Should Be Equal        ${expected_list}        ${actual_list}

Select the Card
    [Arguments]    ${card_name}
    ${elements}=    Get Webelements    CSS:.card-title
    ${index}=    Set Variable    1
    FOR    ${element}    IN    @{elements}
        Exit For Loop If    '${card_name}' == '${element.text}'
        ${index}=    Evaluate    ${index} + 1
    END
    Click Button    xpath:(//button[@class='btn btn-info'])[${index}]

