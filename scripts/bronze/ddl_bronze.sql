/*
==========================================================================================
DDL Script : Create Bronze Tables
==========================================================================================
Script Purpose :
 Created a table for the corrosponding data we are gonna fetch through crm and erp.
 This Script drops the existing tables if they do.
*/

-- Source Crm tables
if object_id ('bronze.crm_cust_info','u') is not null
	drop table bronze.crm_cust_info;

create table bronze.crm_cust_info(
cst_id int,
cst_key nvarchar(50),
cst_firstname nvarchar(50),
cst_lastname nvarchar(50),
cst_material_status nvarchar(50),
cst_gndr varchar(10),
cst_create_date date
);


if object_id ('bronze.crm_prd_info','u') is not null
	drop table bronze.crm_prd_info;

create table bronze.crm_prd_info(
prd_id int,
prd_key nvarchar(50),
prd_nm nvarchar(50),
prd_cost int,
prd_line nvarchar(50),
prd_start_dt date,
prd_end_dt date
);


if object_id ('bronze.crm_sales_details','u') is not null
	drop table bronze.crm_sales_details;

create table bronze.crm_sales_details(
sls_ord_num nvarchar(50),
sls_prd_key nvarchar(50),
sls_cust_id int,
sls_order_dt int,
sls_ship_dt date,
sls_due_dt date,
sls_sales int,
sls_quantity int,
sls_price int
);


-- Source Erp tables

if object_id ('bronze.erp_cust_az12','u') is not null
	drop table bronze.erp_cust_az12;

create table bronze.erp_cust_az12(
CID nvarchar(50),
BDATE date,
GEN varchar(10)
);


if object_id ('bronze.erp_loc_a101','u') is not null
	drop table bronze.erp_loc_a101;

create table bronze.erp_loc_a101(
CID nvarchar(50),
CNTRY varchar(20)
);


if object_id ('bronze.erp_px_cat_g1v2','u') is not null
	drop table bronze.erp_px_cat_g1v2;

create table bronze.erp_px_cat_g1v2(
ID varchar(15),
CAT varchar(30),
SUBCAT varchar(50),
MAINTENANCE varchar(10)
);
