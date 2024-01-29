*** Settings ***
Documentation    A resource file with reusable keywords and variables.
...
...              The system specific keywords created here from our own
...              domain specific language. They utilize keywords provided
...              by the seleniumlibrary.
Library    SeleniumLibrary


*** Variables ***
${user_name}=               rahulshettyacademy
${invalid_password}=        123456
${valid_password}=          learning
${url}=                     https://rahulshettyacademy.com/loginpagePractise/
${browser_name}             Chrome

*** Keywords ***

open the browser with the mortgage url
    Open Browser    ${url}    browser=chrome    options=add_experimental_option("detach", ${true})
    Maximize Browser Window

open the browser with url
    Open Browser    ${url}    browser=${browser_name}
    Maximize Browser Window

Close Browser Session
    Close Browser

Wait Until element passed is located on Page
    [Arguments]    ${page_locator}
    Wait Until Element Is Visible    ${page_locator}    timeout=10s