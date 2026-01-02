*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Library           String
Resource          ../resources/keywords.robot
Test Setup        Open Workshop Registration Page
Test Teardown     Capture Screenshot And Close Browser
Suite Teardown    Close Workshop Browser

*** Variables ***
${URL}            http://127.0.0.1:5500/StarterFiles/Registration.html
${SCREENSHOT_DIR}    screenshots

*** Test Cases ***
Register Success
    Fill Registration Form    Somyod    Sodsai    somyod@kkumail.com    091-001-1234    CS KKU
    Submit Registration
    Verify Success Page

Register Success No Organization
    Fill Registration Form    Somyod    Sodsai    somyod@kkumail.com    091-001-1234
    Submit Registration
    Verify Success Page

Empty First Name
    Fill Registration Form    ${EMPTY}    Sodsai    somyod@kkumail.com    091-001-1234    CS KKU
    Submit Registration
    Verify Error Message    *Please enter your first name!!

Empty Last Name
    Fill Registration Form    Somyod    ${EMPTY}    somyod@kkumail.com    091-001-1234    CS KKU
    Submit Registration
    Verify Error Message    *Please enter your last name!!

Empty First and Last Name
    Fill Registration Form    ${EMPTY}    ${EMPTY}    somyod@kkumail.com    091-001-1234    CS KKU
    Submit Registration
    Verify Error Message    *Please enter your name!!

Empty Email
    Fill Registration Form    Somyod    Sodsai    ${EMPTY}    091-001-1234    CS KKU
    Submit Registration
    Verify Error Message    *Please enter your email!!

Empty Phone Number
    Fill Registration Form    Somyod    Sodsai    somyod@kkumail.com    ${EMPTY}    CS KKU
    Submit Registration
    Verify Error Message    *Please enter your phone number!!

Invalid Phone Number
    Fill Registration Form    Somyod    Sodsai    somyod@kkumail.com    1234    CS KKU
    Submit Registration
    Verify Error Message    Please enter a valid phone number!!

*** Keywords ***
Open Workshop Registration Page
    Create Directory    ${SCREENSHOT_DIR}
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    id=firstname    5s

Close Workshop Browser
    Close Browser

Capture Screenshot And Close Browser
    [Arguments]    ${status}=${TEST STATUS}
    ${safe_test_name}=    Replace String Using Regexp    ${TEST NAME}    ${SPACE}    _
    ${file}=    Set Variable    ${SCREENSHOT_DIR}/${safe_test_name}_${status}.png
    Capture Page Screenshot    ${file}
    Close Browser
