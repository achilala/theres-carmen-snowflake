# Getting started
Much of this project is containerized, shouldn't require much to get up and running, other than for the following dependencies:

> 1. _git_
> 2. _Docker_
> 2. _Bash or WSL_

## Clone Project from Repos
Find my forked version of the project in my repos:
```ps
git clone https://github.com/achilala/theres-carmen-snowflake.git

cd theres-carmen-snowflake
```

## How-to Setup the Environment
In the root folder, if none already exists, create an environment file `.env` with the following variables and values:
```sh
DBT_SNOWFLAKE_ACCOUNT=""
DBT_SNOWFLAKE_USER=""
DBT_SNOWFLAKE_PASSWORD=""
DBT_SNOWFLAKE_ROLE=""
DBT_SNOWFLAKE_WAREHOUSE=""
DBT_SNOWFLAKE_DATABASE=""
DBT_SNOWFLAKE_SCHEMA=
DBT_SNOWFLAKE_THREADS=10
DBT_SNOWFLAKE_QUERY_TAG=""
```

## How-to Start-up the Environment
Execute the `setup.sh` file to create a python virtual environment and install the necessary dependencies:
```ps
./setup.sh

source py3-env/bin/activate
```

Generate dbt `seed` files from the excel file by executing `convert_excel_workbook_to_csv_files.py` from the cli:
```ps
python3 convert_excel_workbook_to_csv_files.py
```

## How-to run dbt
To build the dbt models and generate the dbt catalogue `execute` this batch file:
```ps
./build_dbt.sh
```

or invoke the commands from the `bash` cli:

```ps
dbt clean
dbt deps
dbt build
dbt docs generate
dbt docs serve
```

## Where-to Find the generate dbt Docs
locally
> [http://localhost:8080](http://localhost:8080)

## Analytics

* A bit of house keeping
     - There was nothing much in the way of business keys in the dataset other than the lat long coordinates and the country code
     - No way of telling whether or not a witness/agent by the same name was the same person. My assumption is that witness name plus city is the same witness and agent name plus HQ is the same agent

* Answers the following questions:

    a. For each month, which agency region is Carmen Sandiego most likely to be found?
    
    ![img.png](docs/question_a_results.PNG)

    b. Also for each month, what is the probability that Ms. Sandiego is armed __AND__ wearing a jacket, but __NOT__ a hat?
    
    ![img.png](docs/question_b_results.PNG)

         What general observations about Ms. Sandiego can you make from this?

         Not much to see here to be honest, other than that this combination of general observations hadly occurs. Ms. Sandiego is hadly armed and is spotted wearing a hat more than half the time.

    ![img.png](docs/general_observation_stats.PNG)

    c. What are the three most occuring behaviors of Ms. Sandiego?

    ![img.png](docs/question_c_results.PNG)

    d. For each month, what is the probability Ms. Sandiego exhibits one of her three most occurring behaviors?
    
    ![img.png](docs/question_d_results.PNG)