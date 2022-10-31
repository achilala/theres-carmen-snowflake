#!/bin/bash

export $(grep -v '^#' .env | xargs)
echo "*** exported environment variables ***"

# build dbt
dbt clean && dbt deps && dbt build && dbt docs generate && dbt docs serve