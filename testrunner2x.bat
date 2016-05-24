@echo off

virtualenv --no-site-packages .env
call .env\Scripts\activate.bat
python -m pip install --upgrade pip
pip install -r requirements.txt

rmdir /s /q reports

echo #######################################
echo # Running portfolio a first time
echo # Environment: %1
echo # Included   : %2
echo #######################################

call pybot --outputdir reports --include %2 -P lib --noncritical BUG --variable BROWSER:ff --variable ENVIRONMENT:%1 tests

IF %ERRORLEVEL% EQU 0 EXIT /B 0

copy reports\log.html  reports\first_run_log.html

echo #######################################
echo # Running again the tests that failed
echo #######################################

call pybot --outputdir reports --rerunfailed reports\output.xml --noncritical BUG --output rerun.xml -P lib --variable BROWSER:ff --variable ENVIRONMENT:%1 tests
set RC=%ERRORLEVEL%

copy reports\log.html  reports\second_run_log.html

echo #######################################
echo # Merging output files
echo #######################################

call rebot --nostatusrc --noncritical BUG --outputdir reports --output output.xml --merge reports\output.xml reports\rerun.xml
:: exit /B %RC%
:: allow additional build steps to be run
EXIT /B 0