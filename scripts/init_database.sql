/*
==============================================================================================
CREATE DATABASE & SCHEMAS
==============================================================================================

Purpose : 
  It creates a new database named 'DataWarehouse'.
  This Script do not check or delete the pre existing database of the same name.
  Moreover it add 3 schemas within the database : 'bronze' , 'silver', and 'gold'.

WARNING : Check for the database name you are creating if it exists then you get the error that database
already exist ,so in case of recreation of database with same name you must delete the previous one.
*/





-- Create Database 'DataWarehouse'
use master; -- this will help to switch the server to the main database (master) which give us access to create new databases.

create database DataWarehouse;

use DataWarehouse;

-- Create Schemas
create schema bronze;
go
create schema silver;
go
create schema gold;
go
