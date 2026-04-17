/*
Stored Procedure: Load Bronze Layer (Source -> Bronze)

Script Purpose:
	This stored procedure loads data into the 'bronze' schema from external CSV files.
	It performs the following actions:
	- Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '=====================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '=====================================================';

		PRINT '-----------------------------------------------------';
		PRINT 'Loading xbox Tables';
		PRINT '-----------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.xbox_players';
		TRUNCATE TABLE bronze.xbox_players;

		PRINT '>>Inserting Data Into Table: bronze.xbox_players'
		BULK INSERT bronze.xbox_players
		FROM 'C:\sql-datasets\gaming-profiles-2025-steam-playstation-xbox\xbox\players.csv'
		WITH(
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.xbox_prices';
		TRUNCATE TABLE bronze.xbox_prices;

		PRINT '>>Inserting Data Into Table: bronze.xbox_prices'
		BULK INSERT bronze.xbox_prices
		FROM 'C:\sql-datasets\gaming-profiles-2025-steam-playstation-xbox\xbox\prices.csv'
		WITH(
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.xbox_purchased_games';
		TRUNCATE TABLE bronze.xbox_purchased_games;

		PRINT '>>Inserting Data Into Table: bronze.xbox_purchased_games'
		BULK INSERT bronze.xbox_purchased_games
		FROM 'C:\sql-datasets\gaming-profiles-2025-steam-playstation-xbox\xbox\purchased_games.csv'
		WITH(
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.xbox_games';
		TRUNCATE TABLE bronze.xbox_games;

		PRINT '>>Inserting Data Into Table: bronze.xbox_games'
		BULK INSERT bronze.xbox_games
		FROM 'C:\sql-datasets\gaming-profiles-2025-steam-playstation-xbox\xbox\games.csv'
		WITH(
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.xbox_history';
		TRUNCATE TABLE bronze.xbox_history;

		PRINT '>>Inserting Data Into Table: bronze.xbox_history'
		BULK INSERT bronze.xbox_history
		FROM 'C:\sql-datasets\gaming-profiles-2025-steam-playstation-xbox\xbox\history.csv'
		WITH(
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.xbox_achievements';
		TRUNCATE TABLE bronze.xbox_achievements;

		PRINT '>>Inserting Data Into Table: bronze.xbox_achievements'
		BULK INSERT bronze.xbox_achievements
		FROM 'C:\sql-datasets\gaming-profiles-2025-steam-playstation-xbox\xbox\achievements.csv'
		WITH(
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	
		PRINT '-----------------------------------------------------';
		PRINT 'Loading steam Tables';
		PRINT '-----------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.steam_achievements';
		TRUNCATE TABLE bronze.steam_achievements;

		PRINT '>>Inserting Data Into Table: bronze.steam_achievements'
		BULK INSERT bronze.steam_achievements
		FROM 'C:\sql-datasets\gaming-profiles-2025-steam-playstation-xbox\steam\achievements.csv'
		WITH(
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.steam_friends';
		TRUNCATE TABLE bronze.steam_friends;

		PRINT '>>Inserting Data Into Table: bronze.steam_friends'
		BULK INSERT bronze.steam_friends
		FROM 'C:\sql-datasets\gaming-profiles-2025-steam-playstation-xbox\steam\friends.csv'
		WITH(
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';
	
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.steam_history';
		TRUNCATE TABLE bronze.steam_history;
	
		PRINT '>>Inserting Data Into Table: bronze.steam_history'
		BULK INSERT bronze.steam_history
		FROM 'C:\sql-datasets\gaming-profiles-2025-steam-playstation-xbox\steam\history.csv'
		WITH(
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';
	
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.steam_games';
		TRUNCATE TABLE bronze.steam_games;
	
		PRINT '>>Inserting Data Into Table: bronze.steam_games'
		BULK INSERT bronze.steam_games
		FROM 'C:\sql-datasets\gaming-profiles-2025-steam-playstation-xbox\steam\games.csv'
		WITH(
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';
	
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.steam_players';
		TRUNCATE TABLE bronze.steam_players;
	
		PRINT '>>Inserting Data Into Table: bronze.steam_players'
		BULK INSERT bronze.steam_players
		FROM 'C:\sql-datasets\gaming-profiles-2025-steam-playstation-xbox\steam\players.csv'
		WITH(
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';
	
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.steam_prices';
		TRUNCATE TABLE bronze.steam_prices;
	
		PRINT '>>Inserting Data Into Table: bronze.steam_prices'
		BULK INSERT bronze.steam_prices
		FROM 'C:\sql-datasets\gaming-profiles-2025-steam-playstation-xbox\steam\prices.csv'
		WITH(
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';
	
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.steam_purchased_games';
		TRUNCATE TABLE bronze.steam_purchased_games;
	
		PRINT '>>Inserting Data Into Table: bronze.steam_purchased_games'
		BULK INSERT bronze.steam_purchased_games
		FROM 'C:\sql-datasets\gaming-profiles-2025-steam-playstation-xbox\steam\purchased_games.csv'
		WITH(
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';
	
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.steam_private_steamids';
		TRUNCATE TABLE bronze.steam_private_steamids;
	
		PRINT '>>Inserting Data Into Table: bronze.steam_private_steamids'
		BULK INSERT bronze.steam_private_steamids
		FROM 'C:\sql-datasets\gaming-profiles-2025-steam-playstation-xbox\steam\private_steamids.csv'
		WITH(
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';
	
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.steam_reviews';
		TRUNCATE TABLE bronze.steam_reviews;
	
		PRINT '>>Inserting Data Into Table: bronze.steam_reviews'
		BULK INSERT bronze.steam_reviews
		FROM 'C:\sql-datasets\gaming-profiles-2025-steam-playstation-xbox\steam\reviews.csv'
		WITH(
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

		PRINT '-----------------------------------------------------';
		PRINT 'Loading playstation Tables';
		PRINT '-----------------------------------------------------';
	
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.playstation_achievements';
		TRUNCATE TABLE bronze.playstation_achievements;
	
		PRINT '>>Inserting Data Into Table: bronze.playstation_achievements'
		BULK INSERT bronze.playstation_achievements
		FROM 'C:\sql-datasets\gaming-profiles-2025-steam-playstation-xbox\playstation\achievements.csv'
		WITH(
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';
	
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.playstation_games';
		TRUNCATE TABLE bronze.playstation_games;
	
		PRINT '>>Inserting Data Into Table: bronze.playstation_games'
		BULK INSERT bronze.playstation_games
		FROM 'C:\sql-datasets\gaming-profiles-2025-steam-playstation-xbox\playstation\games.csv'
		WITH(
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';
	
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.playstation_history';
		TRUNCATE TABLE bronze.playstation_history;
	
		PRINT '>>Inserting Data Into Table: bronze.playstation_history'
		BULK INSERT bronze.playstation_history
		FROM 'C:\sql-datasets\gaming-profiles-2025-steam-playstation-xbox\playstation\history.csv'
		WITH(
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';
	
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.playstation_purchased_games';
		TRUNCATE TABLE bronze.playstation_purchased_games;
	
		PRINT '>>Inserting Data Into Table: bronze.playstation_purchased_games'
		BULK INSERT bronze.playstation_purchased_games
		FROM 'C:\sql-datasets\gaming-profiles-2025-steam-playstation-xbox\playstation\purchased_games.csv'
		WITH(
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';
	
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.playstation_prices';
		TRUNCATE TABLE bronze.playstation_prices;
	
		PRINT '>>Inserting Data Into Table: bronze.playstation_prices'
		BULK INSERT bronze.playstation_prices
		FROM 'C:\sql-datasets\gaming-profiles-2025-steam-playstation-xbox\playstation\prices.csv'
		WITH(
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';
	
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.playstation_players';
		TRUNCATE TABLE bronze.playstation_players;
	
		PRINT '>>Inserting Data Into Table: bronze.playstation_players'
		BULK INSERT bronze.playstation_players
		FROM 'C:\sql-datasets\gaming-profiles-2025-steam-playstation-xbox\playstation\players.csv'
		WITH(
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	
		SET @batch_end_time = GETDATE();
		PRINT '=====================================================';
		PRINT 'Loading Bronze Layer is completed.';
		PRINT '		-Total Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds'
		PRINT '=====================================================';
	END TRY
	BEGIN CATCH 
		PRINT '=====================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message: ' + ERROR_MESSAGE();
		PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '=====================================================';
	END CATCH
END