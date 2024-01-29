*** Settings ***
Documentation    All the page objects and keywords of LandingPage.
Library    SeleniumLibrary
Library    Collections

*** Variables ***
${shop_page_load}=           css:.nav-link

*** Keywords ***

Checkout
    Click Element    css:.btn-success
