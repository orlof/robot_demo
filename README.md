# README #

This repository contains Test Automation for BlogEntry example.

    git clone git@github.com:orlof/robot_demo.git

## INSTALLATION ##

These installation instructions are for setting up a Windows test automation client. Adapt these to create clients or development environments for other operating systems.

### Prerequisites ###

Install Firefox browser [latest]

    https://www.mozilla.org/en-US/firefox/new/


Python [2.7.x]

    https://www.python.org/

* Choose to add python.exe to PATH in installed components tab

Required Python packages:

1. Robot Framework [http://robotframework.org/](http://robotframework.org/)
1. Selenium 2 (WebDriver) library for Robot Framework [https://github.com/rtomac/robotframework-selenium2library](https://github.com/rtomac/robotframework-selenium2library)
1. psutil

All of the above can be installed with pip:

    pip install robotframework
    pip install robotframework-selenium2library
    pip install psutil

Another way is to use pip's builtin requirements management:

    pip install -r requirements.txt

CI test runner script (testrunner2x.*) will automatically install above mentioned python dependencies to local virtualenv. This process requires virtualenv installed in CI-servers:

    sudo pip install virtualenv

Git [latest]

    http://git-scm.com/downloads

* When Windows Git installer asks about "Adjusting your PATH environment", select "Use Git from Windows Command Prompt"
* Default is ok for all other options

## USAGE ##

### Test Execution ###

Go to repository and run the test runner script

    cd repository_name
    testrunner.bat (nightly|dev) smokeNOTbug
       or
    ./testrunner.sh (nightly|dev) smokeNOTbug

### Test Development (TODO) ###

All trash files are left out from .gitignore to enable cleaning of repository with:

    git clean -fd


### Branching Model ###

This repository utilizes Gitflow branching model with following exceptions

* Master releases are not made and other test teams must use develop branch

### Tagging model ###
* GOOD
    * Test case is functioning correctly and is part of nightly test set
* SMOKE
    * Deployment acceptance test case
* BUG
    * Reported bug causes the test case to FAIL. Add a link to the bug report as the first keyword
    
        ```Log  https://github.com/orlof/robot_demo/issues/1```
* INDEV
    * Test in development

Other Tags maybe used for testing purposes
