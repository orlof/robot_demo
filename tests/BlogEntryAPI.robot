*** Setting ***
Library           Selenium2LibraryStub
Library           BlogEntryUtils

*** Keyword ***
Login
    [Arguments]    &{Account}
    Input text    login    ${Account.Login}
    Input text    password    ${Account.Password}
    Click Button    LoginButton
    Wait Until Element Is Visible    LogoutButton

Logout
    Go To   ${Url}
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
    Go To    ${Url}blog

Open Blog Entry Form
    Go To    ${Url}blog/new_entry
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
    Prepare Browser
    ${revision}=    Get Text   revision-info
    Log    ${revision}

Cleanup Environment
    Cleanup Browser

Prepare browser
    Set Selenium Timeout    ${SeleniumTimeout}
    Set Screenshot Directory    reports/pics    True
    Open Browser    about:blank     browser=${BROWSER}
    Delete All Cookies
    Go To    ${Url}
    Location Should Contain    ${Url}
    Maximize Browser Window

Cleanup Browser
    Close OS Browsers

Prepare account
    [Arguments]    ${name}
    Prepare account with credentials    &{Account.${name}}

Prepare account with credentials
    [Arguments]    &{Account}
    Log Many  &{Account}
    Login or Register    &{Account}
    Wait Until Element Is Visible    LogoutButton
    Click Element    LogoutButton

Login or Register
    [Arguments]    ${Name}    ${Login}    ${Password}
    Logout

    Wait Until Element is Visible    login
    Input text    login    ${Login}
    Input text    password    ${Password}
    Click Button    LoginButton

    Wait Until Element Is Visible    xpath=//*[@id="LogoutButton" or @class="error-wrapper"]
    ${login_ok}=    Run Keyword And Return Status    Page Should Contain Element    LogoutButton
    Return From Keyword If    ${login_ok}

    Click Button    register
    Input Text    name    ${Name}
    Input Text    login    ${Login}
    Input Text    password    ${password}
    Click Button    xpath=//button[contains(@class, "registerButton")]
    Wait Until Element Is Visible    LogoutButton
