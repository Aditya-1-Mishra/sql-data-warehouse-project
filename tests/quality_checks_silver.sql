/*
=========================================
Quality check Script is the sql commands that i run while performing ETL.
=========================================
Alert :
   - Those commands can be considered as a rough work .It doesn't have integrity.
   - Warnings and Error may raise. 
*/

-- check for nulls or duplicates in primary key
-- expectation: no result
select 
cst_id,
count(*)
from silver.crm_cust_info
group by cst_id
having count(*)>1 or cst_id is null

select * 
from bronze.crm_cust_info
where cst_id is null

/* delete from bronze.crm_cust_info
where cst_id is null */




-- check for unwanted spaces
-- expectations : no result
select cst_firstname
from silver.crm_cust_info
where cst_firstname != trim(cst_firstname)

-- data standardization & consistency
select distinct cst_marital_status
from silver.crm_cust_info

select * from silver.crm_cust_info



select prd_nm
from bronze.crm_prd_info
where prd_nm != trim(prd_nm)

-- check invalid date orders
select * 
from bronze.crm_prd_info
where prd_end_dt < prd_start_dt


select sls_prd_key
from bronze.crm_sales_details
where sls_order_dt > sls_ship_dt


-- check data consistency: between sales , quantity and price
-- >> sales = quantity * price
-- >> values must not be null , zero or negative
select distinct
sls_sales as old_sls_sales,
sls_quantity,
sls_price as old_sls_price,

case when sls_sales is null or sls_sales <=0 or sls_sales ! = sls_quantity * abs(sls_price) 
	then sls_quantity * abs(sls_price)
	else sls_sales
end as sls_sales,
case when sls_price is null or sls_price<=0
	then  sls_sales / nullif(sls_quantity , 0)
	else sls_price
end as sls_price
from silver.crm_sales_details
where sls_sales != sls_quantity * sls_price 
or sls_sales is null or sls_quantity is null or sls_price is null
or sls_sales <= 0 or sls_quantity <=0 or sls_price <=0

select * from  silver.crm_sales_details


-- identify out of range dates
select distinct
bdate from bronze.erp_cust_az12
where bdate < '1924-01-01' or bdate > getdate()

-- data standardization & consistency 
select distinct gen
from bronze.erp_cust_az12

select distinct gen,
case when upper(trim(gen)) in ('F' ,'Female') then 'Female'
	when upper(trim(gen)) in ('M' ,'Male') then 'Male'
	else 'n/a'
end as gen
from bronze.erp_cust_az12



select * from silver.erp_cust_az12

select distinct cntry from bronze.erp_loc_a101


-- check unwanted spaces
select * from bronze.erp_px_cat_g1v2
where cat ! = trim(cat) or subcat != trim(subcat) or maintenance != trim(maintenance)

-- data standardization & consistency
select distinct
cat 
from bronze.erp_px_cat_g1v2
