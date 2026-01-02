*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    http://127.0.0.1:5500/StarterFiles/Registration.html

*** Keywords ***
Open Workshop Registration Page
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Title Should Be    Registration

Close Workshop Browser
    Close Browser

Fill Registration Form
    [Arguments]    ${firstname}    ${lastname}    ${email}    ${phone}    ${organization}=${EMPTY}
    Input Text    id=firstname    ${firstname}
    Input Text    id=lastname     ${lastname}
    Input Text    id=email        ${email}
    Input Text    id=phone        ${phone}
    Run Keyword If    '${organization}' != ''    Input Text    id=organization    ${organization}

Submit Registration
    Click Button    id=registerButton
    Sleep    1s

Verify Success Page
    Title Should Be    Success
    Page Should Contain    Thank you for registering with us.
    Page Should Contain    We will send a confirmation to your email soon.

Verify Error Message
    [Arguments]    ${message}
    Element Text Should Be    id=errors    ${message}
