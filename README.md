# Gaming-Profiles-Data-Warehouse-Project
## Project Overview
This project involves building a centralized Data Warehouse in SQL Server using a Gaming Profiles Dataset from Kaggle. The goal is to consolidate gaming data from Steam, PlayStation, and Xbox to analyze player behavior, game pricing trends, and achievement completion rates across platforms. 

## Key Features
Data Integration: Consolidated data for profiles, game prices, and achievements.
ETL Process: Performed data cleaning and transformation using SQL scripts to ensure consistency (eg., standardizing date formats).
Data Modeling: Developing fact and dimension tables optimized for analytical queries.

## Data Source
The dataset used for this data warehousing project is sourced from Kaggle:
*   **Dataset:** [Gaming Profiles 2025 (Steam, PlayStation, Xbox)](https://www.kaggle.com/datasets/artyomkruglov/gaming-profiles-2025-steam-playstation-xbox)

## Repository Structure
```text
.
├──docs/                                    # Project documentation and architecture details
    ├──Data Dictionary.pdf                  # Documentation for different tables and its attributes
    ├──data_flow_diagram.png                # Image file for data flow diagram
    ├──data_model.png                       # Image file for data model
├──scripts                                  # SQL scripts for ETL and transformations
    ├──bronze                               # Scripts for extracting and loading raw data
        ├──ddl-bronze.sql                   # DDL script for bronze layer
        ├──proc_load_bronze.sql             # Script to create stored procedure to load data in bronze layer
    ├──silver                               # Scripts for cleaning and transforming data
        ├──ddl-silver.sql                   # DDL script for silver layer
        ├──proc_load_silver.sql             # Script to create stored procedure to load data in silver layer
    ├──gold                                 # Scripts for creating analytical models
        ├──ddl-gold.sql                     # DDL script for gold layer
    ├──test                                 # Test scripts
        ├──query_check_silver.sql           # Script to perform, quality checks across silver layer
    ├──init-database.sql                    # Script to initialize new database and schemas
├──LICENSE                                  # License information for the repository
├──README.md                                # Project overview and instructions
```

## License
This project is licensed under the [MIT License](https://github.com/Piyush9477/Gaming-Profiles-Data-Warehouse-Project/blob/main/LICENSE)
