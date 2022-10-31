#!/bin/bash

# build dbt
dbt clean && dbt deps && dbt build && dbt docs generate && dbt docs serve