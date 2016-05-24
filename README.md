# README #

This repository contains test automation source code for BlogEntry

    git clone somethign...

## INSTALLATION ##

These installation instructions are for setting up a Windows test automation client. Adapt these to create clients or development environments for other operating systems.

### Prerequisites ###

Firefox browser [latest]

    https://www.mozilla.org/en-US/firefox/new/


Python [2.7.x]

    https://www.python.org/

* Choose to add python.exe to PATH in installed components tab

Required Python packages:

1. Robot Framework [http://robotframework.org/](http://robotframework.org/)
1. Selenium 2 (WebDriver) library for Robot Framework [https://github.com/rtomac/robotframework-selenium2library](https://github.com/rtomac/robotframework-selenium2library)
1. psutil

All of the above can be installed with (use sudo if not in virtualenv)

    pip install -r requirements.txt

CI test runner script (testrunner2x.*) will automatically install above mentioned python dependencies to local virtualenv. This process requires virtualenv to in CI-servers:

    sudo pip install virtualenv

Git [latest]

    http://git-scm.com/downloads

* When Windows Git installer asks about "Adjusting your PATH environment", select "Use Git from Windows Command Prompt"
* Default is ok for all other options

#### Configure SSH ####

Generate new SSH key pair and copy the public key to BitBucket deployment keys. BitBucket deployment keys provide safe read-only access to repository.

Generate a new key-pair with ssh-keygen. Start "Git Bash" (from Start menu) and run the following command with default values:

    ssh-keygen

Copy the following text to a file "~/.ssh/config":

```
#!text
Host bitbucket
    HostName altssh.bitbucket.org
    Port 443
    User git
    IdentityFile ~/.ssh/id_rsa
```

Install the public key to BitBucket in

    https://bitbucket.org/organization/project/admin/deploy-keys

and Copy/Paste the whole contents of ~/.ssh/id_rsa.pub by selecting "Add Key".

Clone the repository to your local machine:

    git clone ssh://bitbucket/organization/project

## USAGE ##

### Test Execution ###

Go to repository and run the test runner script

    cd repository_name
    testrunner.bat (nightly|dev) smokeNOTbug
       or
    ./testrunner.sh (nightly|dev) smokeNOTbug

### Test Development (TODO) ###

All trash files are purposedly left out from .gitignore to enable cleaning of repository with:

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

        ```
        Log  http://someurl...
        ```

* INDEV
    * Test in development

Other Tags maybe used for testing purposes
