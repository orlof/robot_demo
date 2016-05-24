#!/bin/sh

virtualenv --no-site-packages .env
source .env/bin/activate
python -m pip install --upgrade pip
pip install -r requirements.txt

rm -rf reports

echo "#######################################"
echo "# Running portfolio a first time"
echo "# Environment: $1"
echo "# Included   : $2"
echo "#######################################"

pybot --outputdir reports --noncritical BUG --include $2 -P lib --variable BROWSER:ff --variable ENVIRONMENT:$1 tests

if [ $? -eq 0 ]; then
	exit 0
fi

cp reports/log.html  reports/first_run_log.html

echo
echo "#######################################"
echo "# Running again the tests that failed #"
echo "#######################################"
echo
pybot --outputdir reports --noncritical BUG --nostatusrc --rerunfailed reports/output.xml --output rerun.xml -P lib --variable BROWSER:ff --variable ENVIRONMENT:$1 tests

cp reports/log.html  reports/second_run_log.html

echo
echo "########################"
echo "# Merging output files #"
echo "########################"
echo
rebot --nostatusrc --noncritical BUG --outputdir reports --output output.xml --merge reports/output.xml  reports/rerun.xml
