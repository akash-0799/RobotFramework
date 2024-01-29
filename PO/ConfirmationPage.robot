*** Settings ***
Documentation    All the page objects and keywords of LandingPage.
Library    SeleniumLibrary
Library    Collections
Resource   ../PO/Generic.robot

*** Variables ***
${shop_page_load}=           css:.nav-link

*** Keywords ***
Enter the Country and Check the Terms and Conditions
    [Arguments]    ${country_name}
    Input Text    country        ${country_name}
    Wait Until element passed is located on Page    xpath://a[text()='${country_name}']
    Click Element    xpath://a[text()='${country_name}']
    Click Element        css:.checkbox-primary label


Purchase the Producr and Confirm the Purchase
    Click Element    css:.btn-success
    Page Should Contain    Success!
