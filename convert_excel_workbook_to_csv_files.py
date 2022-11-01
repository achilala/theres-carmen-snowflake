import os
import pandas as pd

# define input and output directories
PROJECT_NAME = "carmen_sightings"
EXCEL_FILE_EXTENSION = ".xlsx"
CSV_FILE_EXTENSION = ".csv"
INPUT_DIR = f"./{PROJECT_NAME}"
OUTPUT_DIR = "./seeds"
LIST_OF_FILES = os.listdir(INPUT_DIR)

def convert_excel_workbook_to_csv_files() -> None:
    # iterate over files in input directory
    for file in LIST_OF_FILES:
        # checking if is excel file
        if file.endswith(EXCEL_FILE_EXTENSION):
            excel_file = os.path.join(INPUT_DIR, file)
            excel_workbook = pd.read_excel(excel_file, sheet_name=None)

            # loop through the workbook and save csv
            for sheet_name, df in excel_workbook.items():
                csv_file = f"{OUTPUT_DIR}/{PROJECT_NAME}_{sheet_name.lower()}{CSV_FILE_EXTENSION}"
                
                # renamed a couple of columns with problematic names
                df.rename(
                    columns={
                         "报道": "date_agent"
                        ,"纬度": "latitude"
                        ,"经度": "longitude"
                        ,"long": "longitude"
                        ,"armed?": "has_weapon"
                        ,"chapeau?": "has_hat"
                        ,"coat?": "has_jacket"
                    }
                    ,inplace=True
                )

                # append to csv files when more than one input file
                if LIST_OF_FILES.index(file) == 0:
                    df.to_csv(csv_file, index=False)
                else:
                    df.to_csv(csv_file, index=False, mode="a")

            # archive input file when done or mark as read
            print("file read and archived")


convert_excel_workbook_to_csv_files()