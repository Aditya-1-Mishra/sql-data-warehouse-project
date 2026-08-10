/* 
============================================================================================
Stored Procedure : Load Bronze Layer ( Source ==> Bronze )
============================================================================================

Script Purpose:
  This stored Procedure loads data into 'bronze' schema from external CSV files.
  It Performs :
  - Truncates the pre-existing tables if they do before loading.
  - Uses the `Bulk Insert` command to load data from csv files to bronze tables.

Usage Example :
  -- execution of stored procedure.
    exec bronze.load_bronze 
*/

-- FULL LOAD
-- created stored procedure to quickly update the table since this operation is going to to used frequently.

create or alter procedure bronze.load_bronze as

begin
	declare @start_time datetime , @end_time datetime ,@batch_start_time datetime,@batch_end_time datetime ;
	begin try
		set @batch_start_time = getdate();


		print '==================================';
		print 'Loading Bronze Layer';

		print 'Loading CRM Tables';

		set @start_time = getdate();
		truncate table bronze.crm_cust_info; -- first we make the table empty and then load it from scratch

		bulk insert bronze.crm_cust_info
		from 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
		firstrow =2, -- by this we tell the sql that 1st row is header and our data start from 2nd row
		fieldterminator = ',', -- to specify how data is separated in file
		tablock 
		);

		select count(*) from bronze.crm_cust_info
		set @end_time = getdate();
		print '>> Load Duration : ' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds';



		set @start_time = getdate();
		truncate table bronze.crm_prd_info

		bulk insert bronze.crm_prd_info
		from 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with(
		firstrow =2,
		fieldterminator = ',',
		tablock
		);
		set @end_time = getdate();
		print '>> Load Duration : ' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds';



		set @start_time = getdate();
		truncate table bronze.crm_sales_details

		bulk insert bronze.crm_sales_details
		from 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with(
		firstrow =2,
		fieldterminator = ',',
		tablock
		);
		set @end_time = getdate();
		print '>> Load Duration : ' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds';


		print 'Loading ERP Tables';
		set @start_time = getdate();
		truncate table bronze.erp_cust_az12

		bulk insert bronze.erp_cust_az12
		from 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with(
		firstrow =2,
		fieldterminator = ',',
		tablock
		);
		set @end_time = getdate();
		print '>> Load Duration : ' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds';


		set @start_time = getdate();
		truncate table bronze.erp_loc_a101

		bulk insert bronze.erp_loc_a101
		from 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with(
		firstrow =2,
		fieldterminator = ',',
		tablock
		);
		set @end_time = getdate();
		print '>> Load Duration : ' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds';


		set @start_time = getdate();
		truncate table bronze.erp_px_cat_g1v2

		bulk insert bronze.erp_px_cat_g1v2
		from 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with(
		firstrow =2,
		fieldterminator = ',',
		tablock
		);
		set @end_time = getdate();
		print '>> Load Duration : ' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds';


		set @batch_end_time = getdate();
		print '>> Load Duration of Bronze Layer: ' + cast(datediff(second,@batch_start_time,@batch_end_time) as nvarchar) + 'seconds';
	end try

	begin catch
		print 'Error Occured During Loading Bronze Layer';
		print 'Error Message' + error_message();
		print 'Error Message' + cast(error_number() as nvarchar);
	end catch
end
