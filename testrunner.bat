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
echo # Browser    : %3
echo #######################################

call pybot --include %2 --noncritical BUG --outputdir reports -P lib --variable BROWSER:%3 --variable ENVIRONMENT:%1 tests

EXIT /B 0