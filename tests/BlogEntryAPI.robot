*** Setting ***
Library           Selenium2Library
Library           BlogEntryUtils

*** Variable ***
${ENVIRONMENT}    nightly
${BROWSER}    ff
${SeleniumTimeout}    30

${Account_Login_dev}       teppo
${Account_Password_dev}    secret
${URL}     http://XYZ/

*** Keyword ***
Login
    [Arguments]    ${account}
    Input text    email    ${Account_Login_${account}}
    Input text    password    ${Account_Password_${account}}
    Click Button    LoginButton
    Wait Until Element Is Visible    LogoutButton

Logout
    Go To   ${URL}
    Wait Until Element Is Visible    xpath=//button[@id="LogoutButton" or @id="LoginButton"]
    ${is_logged_in}=    Run Keyword And Return Status    Element Should Be Visible    LogoutButton
    Run Keyword If    ${is_logged_in}    Click Element    LogoutButton

Create Blog Entry
    [Arguments]    ${title}=NDEF    ${message}=NDEF
    ${blog}=    Open Blog Entry Form
    ${blog.title}=    Set Blog Entry Title    ${title}
    ${blog.message}=    Set Blog Entry Message    ${message}
    Submit Blog Entry Form
    [Return]    ${blog}

Go to Blog Page
    Go To    ${URL}blog

Open Blog Entry Form
    Go To    ${URL}blog/new_entry
    ${blog}=    Create Data Dict
    [Return]    ${blog}

Submit Blog Entry Form
    Click Button    SubmitButton

Set Blog Entry Title
    [Arguments]    ${value}=NDEF
    ${value}=    Set Textfield    title    ${value}

Set Blog Entry Message
    [Arguments]    ${value}=NDEF
    ${value}=    Set Textfield    message    ${value}

Set Textfield
    [Arguments]    ${element}    ${value}
    Run Keyword If    "${value}"=="NDEF"    Generate Test Data    value=text
    Input Text    ${element}    ${value}
    Press Key    ${element}    \t
    [Return]    ${value}

Verify Blog Entry Title
    [Arguments]    ${value}
    Page Should Contain Element    xpath=//div[@id="title" and contains(text(), "${value}")]

Verify Blog Entry Message
    [Arguments]    ${value}
    Page Should Contain Element    xpath=//div[@id="message" and contains(text(), "${value}")]

###############################
# UTILITIES
###############################

Prepare Environment
    Set Suite Variable    ${URL}    ${Environment_Url_${ENVIRONMENT}}
    Prepare Browser
    ${revision}=    Get Text   revision-info
    Log    ${revision}

Cleanup Environment
    No Operation

Prepare browser
    Set Selenium Timeout    ${SeleniumTimeout}
    Set Screenshot Directory    reports/pics    True
    Open Browser    about:blank     browser=${BROWSER}
    Delete All Cookies
    Go To    ${URL}
    Location Should Contain    ${URL}
    Maximize Browser Window

Cleanup Browser
    Close OS Browsers

Prepare account
    [Arguments]    ${name}
    Prepare account with credentials    ${name}    Robot.${name}@mailinator.com    secret

Prepare account with credentials
    [Arguments]    ${name}  ${email}  ${password}
    Set Suite Variable    ${Account_Login_${name}}    ${email}
    Set Suite Variable    ${Account_Password_${name}}    ${password}

    Login or Register    ${name}    ${Account_Login_${name}}    ${Account_Password_${name}}
    Wait Until Element Is Visible    LogoutButton
    Click Element    LogoutButton

Login or Register
    [Arguments]    ${name}    ${email}    ${password}
    Logout

    Wait Until Element is Visible    email
    Input text    email    ${email}
    Input text    password    ${password}
    Click Button    LoginButton

    Wait Until Element Is Visible    xpath=//*[@id="LogoutButton" or @class="error-wrapper"]
    ${login_ok}=    Run Keyword And Return Status    Page Should Contain Element    LogoutButton
    Return From Keyword If    ${login_ok}

    Click Button    registerWithEmail
    Input Text    email    ${email}
    Input Text    reEmail    ${email}
    Input Text    password    ${password}
    Input Text    rePassword    ${password}
    Input Text    username    ${name}
    Click Button    xpath=//button[contains(@class, "registerButton")]
    Wait Until Element Is Visible    LogoutButton
