#!/bin/sh

rm -rf reports

echo "#######################################"
echo "# Running portfolio a first time"
echo "# Environment: $1"
echo "# Included   : $2"
echo "# Browser    : $3"
echo "#######################################"

pybot --include $2 --noncritical BUG --outputdir reports -P lib --variable BROWSER:$3 --variable ENVIRONMENT:$1 tests
