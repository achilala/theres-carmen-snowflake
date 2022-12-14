#!/bin/bash

echo "*** please wait while the environment is being setup... ***"

export $(grep -v '^#' .env | xargs)
echo "*** exported environment variables ***"

python3 -m venv py3-env
source py3-env/bin/activate
python3 -m pip install --upgrade pip
python3 -m pip install -r requirements.txt

python3 convert_excel_workbook_to_csv_files.py

echo "*** setup is done... ***"

echo "**** testing connection... ***"
dbt debug