# to declare module name
*** Settings ***
Documentation    To validate the login form
Library    SeleniumLibrary
Test Teardown    Close Browser
# Resource

# To declare variable globally
*** Variables ***
${Error_MessageLogin}=    css:.alert-danger    

# In robot framework test cases is collection of keyword
*** Test Cases ***
Validate UnSuccessful login
    open the browser with the mortgage url
    Fill the login form
    wait untill it checks and display error message
    verify error message is correct

# These are the business keywords we need to tie them up with actual selenium keywords
*** Keywords ***

open the browser with the mortgage url
    Create Webdriver    Chrome
    Go To    https://rahulshettyacademy.com/loginpagePractise/

# For Input Password password will not log into the log file
# For id we can write directly but not for xpath and css

Fill the login form
    Input Text            xpath://input[@id='username']    rahulshettyacademy
    Input Password        id:password    123456
    Click Button          signInBtn

wait untill it checks and display error message
    Wait Until Element Is Visible        ${Error_MessageLogin}

verify error message is correct
    ${result}=    Get Text            ${Error_MessageLogin}
    Should Be Equal As Strings       ${result}        Incorrect username/password.
    Element Text Should Be        ${Error_MessageLogin}        Incorrect username/password.