
/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' and the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
Warning: 
    Running this script will drop the entire 'Datawarehouse' database if exists.
    All data in the database will be permaentley deleted. Proceed with caution and ensure you have proper backups before running this scrit.
*/

-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;

-- Create Schemas
CREATE SCHEMA bronze;

CREATE SCHEMA silver;

CREATE SCHEMA gold;
