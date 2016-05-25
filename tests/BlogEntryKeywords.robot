*** Setting ***
Library           BlogEntryUtils
Resource          BlogEntryAPI.robot

*** Keyword ***

###############################
# ACTIONS
###############################

As ${me}, login
    Login    &{Account.${me}}

As ${me}, logout
    Logout

As ${me}, create blog entry
    ${blog}=    Create Blog Entry
    Set Test Variable    ${blog}

###############################
# VERIFICATIONS
###############################
As ${me}, verify blog entry
    Go To Blog Page
    Verify blog entry title    ${blog.title}
    Verify blog entry message    ${blog.message}
