*** Settings ***
Documentation    To validate the login form
Library          SeleniumLibrary
Library          Collections
Library          ../customLibraries/Shop.py
Test Setup       open the browser with url
Suite Setup
Suite Teardown
Test Teardown    Close Browser Session
Resource         ../PO/Generic.robot
Resource         ../PO/LandingPage.robot
Resource         ../PO/ShopPage.robot
Resource         ../PO/CheckoutPage.robot
Resource         ../PO/ConfirmationPage.robot

*** Variables ***

# Test data can be placed here but the locators of the particular page should be in the pae object file only
@{listofproducts}            Blackberry    Nokia Edge
${country_name}              India

*** Test Cases ***
Validate UnSuccessful login
    [Tags]    SMOKE    REGRESSION
    LandingPage.Fill The Login Form        ${user_name}        ${invalid_password}
    LandingPage.wait until element is located in the page
    LandingPage.verify error message is correct

Validate Cards display in the shopping page
    [Tags]    REGRESSION
    # Conflict of same keyword can be avoided by specifying it using particular usinh PO name
    LandingPage.Fill The Login Form        ${user_name}        ${valid_password}
    ShopPage.wait until element is located in the page
    ShopPage.Verify Card titles in the shop page
    add items to cart and checkout        ${listofproducts}
    CheckoutPage.Checkout
    ConfirmationPage.Enter the Country and Check the Terms and Conditions        ${country_name}
    ConfirmationPage.Purchase the Producr and Confirm the Purchase

Select the form and fill login details
    LandingPage.Fill the login details and login form


# To run all the tests : robot . --> for executing all the test cases in folder
# To run all the tests parallely : pabot . after installing pabot plugin: pip install -U robotframework-pabot
# Split execution on test level,  pabot --testlevelsplit [path to tests]
# For executing test cases by test case name ---> robot -t "Test Case Name" with file name or with .
# we can run it also by regular expression eg:  "Validate*"
# If we want to run eg: smoke test cases to check build is good ---> by using tag name present in any file
# It can be done by robot --include <tagname> .
# For multiple tags robot --include <tagname1>OR/AND<tagname2> .
# For excluding a particular tag robot --include <tagname> .
# For executing tests by suite name:  robot --suite <foldername> . <--- from anywhere in the framework
# For execute only failed tests: robot --rerunfailed output.xml .
# From run command for controlling variable --> eg: robot --variable browser_name:Firefox testDemo7.robot
# We can use tags also with this: robot --variable browser_name:Firefox --include SMOKEORREGRESSION testDemo7.robot
# This is applicable to global variable only anywhere not specific to Generic.robot
# For sharing value from one keyword to another keyword first you need to set it a global variable

