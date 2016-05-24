*** Setting ***
Suite Setup       Prepare Environment and Setup Accounts
Suite Teardown    Cleanup Environment
Test Setup        Prepare Browser
Test Teardown     Cleanup Browser
Test Timeout      4 minutes
Resource          Adaptation.robot

*** Test Case ***
Tommy creates blog entry
    [Tags]    GOOD    SMOKE
    As Tommy, login
    As Tommy, create blog entry
    As Tommy, verify blog entry
    As Tommy, logout

Gina can see Tommys blog entry
    [Tags]    GOOD
    As Tommy, login
    As Tommy, create blog entry
    As Tommy, logout

    As Gina, login
    As Gina, verify blog entry
    As Gina, logout

*** Keyword ***

Prepare Environment and Setup Accounts
    Prepare Environment
    Prepare Account    Tommy
    Prepare Account    Gina
