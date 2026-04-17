/*
Stored Procedure: Load Silver Layer (Bronze -> Silver)

Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to 
    populate the 'silver' schema tables from the 'bronze' schema.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and cleansed data from Bronze into Silver tables.
		
Parameters:
    None. 
	This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC Silver.load_silver;
*/
CREATE OR ALTER PROCEDURE silver.load_silver AS 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '=====================================================';
		PRINT 'Loading Silver Layer';
		PRINT '=====================================================';

		PRINT '-----------------------------------------------------';
		PRINT 'Loading xbox Tables';
		PRINT '-----------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: silver.xbox_players';
		TRUNCATE TABLE silver.xbox_players;
		PRINT '>>Inserting Data Into The Table: silver.xbox_players';
		INSERT INTO silver.xbox_players (
			player_id,
			nickname
		)
		SELECT 
			player_id,
			TRIM(nickname) AS nickname
		FROM bronze.xbox_players;
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: silver.xbox_games';
		TRUNCATE TABLE silver.xbox_games;
		PRINT '>>Inserting Data Into The Table: silver.xbox_games';
		INSERT INTO silver.xbox_games(
			game_id,
			title,
			developers,
			publishers,
			genres, 
			supported_languages,
			release_date
		)
		SELECT 
			game_id,
			title,
			ISNULL(developers, 'n/a'),
			ISNULL(publishers, 'n/a'),
			ISNULL(genres, 'n/a'), 
			ISNULL(supported_languages, 'n/a'),
			release_date
		FROM bronze.xbox_games;
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: silver.xbox_prices';
		TRUNCATE TABLE silver.xbox_prices;
		PRINT '>>Inserting Data Into The Table: silver.xbox_prices';
		INSERT INTO silver.xbox_prices (
			game_id,
			usd,
			eur,
			gbp,
			jpy,
			rub,
			date_acquired
		)
		SELECT 
			p.game_id,
			p.usd,
			p.eur,
			p.gbp,
			p.jpy,
			p.rub,
			p.date_acquired
		FROM bronze.xbox_prices p JOIN silver.xbox_games g
			ON p.game_id = g.game_id;
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: silver.xbox_purchased_games';
		TRUNCATE TABLE silver.xbox_purchased_games;
		PRINT '>>Inserting Data Into The Table: silver.xbox_purchased_games';
		INSERT INTO silver.xbox_purchased_games (
			player_id,
			library
		)
		SELECT 
			pg.player_id,
			pg.library
		FROM bronze.xbox_purchased_games pg JOIN silver.xbox_players p 
			ON pg.player_id = p.player_id;
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: silver.xbox_achievements';
		TRUNCATE TABLE silver.xbox_achievements;
		PRINT '>>Inserting Data Into The Table: silver.xbox_achievements';
		INSERT INTO silver.xbox_achievements(
			achievement_id,
			game_id,
			title,
			description,
			points 
		)
		SELECT
			xa.achievement_id,
			xa.game_id,
			xa.title,
			xa.description,
			xa.points
		FROM bronze.xbox_achievements xa JOIN silver.xbox_games xg 
			ON xa.game_id = xg.game_id;
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: silver.xbox_history'
		TRUNCATE TABLE silver.xbox_history;
		PRINT '>>Inserting Data Into The Table: silver.xbox_history'
		INSERT INTO silver.xbox_history(
			player_id,
			achievement_id,
			date_acquired
		)
		SELECT 
			xh.player_id,
			xh.achievement_id,
			xh.date_acquired
		FROM bronze.xbox_history xh 
		JOIN silver.xbox_players xp 
			ON xh.player_id = xp.player_id
		JOIN silver.xbox_achievements xa 
			ON xh.achievement_id = xa.achievement_id;
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

		PRINT '-----------------------------------------------------';
		PRINT 'Loading playstation Tables';
		PRINT '-----------------------------------------------------';
	
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: silver.playstation_players';
		TRUNCATE TABLE silver.playstation_players;
		PRINT '>>Inserting Data Into The Table: silver.playstation_players';
		INSERT INTO silver.playstation_players(
			player_id,
			nickname,
			country
		)
		SELECT 
			player_id,
			nickname,
			country
		FROM bronze.playstation_players;
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: silver.playstation_games';
		TRUNCATE TABLE silver.playstation_games;
		PRINT '>>Inserting Data Into The Table: silver.playstation_games';
		INSERT INTO silver.playstation_games(
			game_id,
			title,
			platform,
			developers,
			publishers,
			genres,
			supported_languages,
			release_date
		)
		SELECT 
			game_id,
			title,
			platform,
			ISNULL(developers, 'n/a'),
			ISNULL(publishers, 'n/a'),
			ISNULL(genres, 'n/a'),
			ISNULL(supported_languages, 'n/a'),
			release_date
		FROM bronze.playstation_games;
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: silver.playstation_achievements';
		TRUNCATE TABLE silver.playstation_achievements;
		PRINT '>>Inserting Data Into The Table: silver.playstation_achievements';
		INSERT INTO silver.playstation_achievements(
			achievement_id,
			game_id,
			title,
			description,
			rarity
		)
		SELECT 
			pa.achievement_id,
			pa.game_id,
			pa.title,
			pa.description,
			pa.rarity
		FROM bronze.playstation_achievements pa JOIN silver.playstation_games pg
			ON pa.game_id = pg.game_id;
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: silver.playstation_prices';
		TRUNCATE TABLE silver.playstation_prices;
		PRINT '>>Inserting Data Into The Table: silver.playstation_prices';
		INSERT INTO silver.playstation_prices(
			game_id,
			usd,
			eur,
			gbp,
			jpy,
			rub,
			date_acquired
		)
		SELECT 
			pp.game_id,
			pp.usd,
			pp.eur,
			pp.gbp,
			pp.jpy,
			pp.rub,
			pp.date_acquired
		FROM bronze.playstation_prices pp JOIN silver.playstation_games pg
			ON pp.game_id = pg.game_id;
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: silver.playstation_purchased_games';
		TRUNCATE TABLE silver.playstation_purchased_games;
		PRINT '>>Inserting Data Into The Table: silver.playstation_purchased_games';
		INSERT INTO silver.playstation_purchased_games(
			player_id,
			library
		)
		SELECT 
			player_id,
			library
		FROM bronze.playstation_purchased_games;
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: silver.playstation_history';
		TRUNCATE TABLE silver.playstation_history;
		PRINT '>>Inserting Data Into The Table: silver.playstation_history';
		INSERT INTO silver.playstation_history(
			player_id,
			achievement_id,
			date_acquired
		)
		SELECT 
			ph.player_id,
			ph.achievement_id,
			ph.date_acquired
		FROM bronze.playstation_history ph
		JOIN silver.playstation_players pp
			ON ph.player_id = pp.player_id
		JOIN silver.playstation_achievements pa
			ON ph.achievement_id = pa.achievement_id;
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	
		PRINT '-----------------------------------------------------';
		PRINT 'Loading steam Tables';
		PRINT '-----------------------------------------------------';
	
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: silver.steam_players';
		TRUNCATE TABLE silver.steam_players;
		PRINT '>>Inserting Data Into The Table: silver.steam_players';
		INSERT INTO silver.steam_players(
			player_id,
			country,
			created
		)
		SELECT 
			player_id,
			ISNULL(country, 'n/a'),
			created
		FROM bronze.steam_players;
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: silver.steam_games';
		TRUNCATE TABLE silver.steam_games;
		PRINT '>>Inserting Data Into The Table: silver.steam_games';
		INSERT INTO silver.steam_games(
			game_id,
			title,
			developers,
			publishers,
			genres,
			supported_languages,
			release_date
		)
		SELECT 
			game_id,
			TRIM(ISNULL(title, 'n/a')),
			ISNULL(developers, 'n/a'),
			ISNULL(publishers, 'n/a'),
			ISNULL(genres, 'n/a'),
			ISNULL(supported_languages, 'n/a'),
			release_date
		FROM bronze.steam_games;
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: silver.steam_private_steamids';
		TRUNCATE TABLE silver.steam_private_steamids;
		PRINT '>>Inserting Data Into The Table: silver.steam_private_steamids';
		INSERT INTO silver.steam_private_steamids(
			player_id
		)
		SELECT player_id
		FROM bronze.steam_private_steamids;
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: silver.steam_achievements';
		TRUNCATE TABLE silver.steam_achievements;
		PRINT '>>Inserting Data Into The Table: silver.steam_achievements';
		INSERT INTO silver.steam_achievements(
			achievement_id,
			game_id,
			title,
			description
		)
		SELECT 
			sa.achievement_id,
			sa.game_id,
			TRIM(ISNULL(sa.title, 'n/a')),
			TRIM(ISNULL(sa.description, 'n/a'))
		FROM bronze.steam_achievements sa
		JOIN silver.steam_games sg 
			ON sa.game_id = sg.game_id;
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: silver.steam_friends';
		TRUNCATE TABLE silver.steam_friends;
		PRINT '>>Inserting Data Into The Table: silver.steam_friends';
		INSERT INTO silver.steam_friends(
			player_id,
			friends
		)
		SELECT 
			sf.player_id,
			sf.friends
		FROM bronze.steam_friends sf 
		JOIN silver.steam_players sp	
			ON sf.player_id = sp.player_id;
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: silver.steam_purchased_games';
		TRUNCATE TABLE silver.steam_purchased_games;
		PRINT '>>Inserting Data Into The Table: silver.steam_purchased_games';
		INSERT INTO silver.steam_purchased_games(
			player_id,
			library
		)
		SELECT 
			spg.player_id,
			ISNULL(spg.library, 'n/a')
		FROM bronze.steam_purchased_games spg
		JOIN silver.steam_players sp 
			ON spg.player_id = sp.player_id;
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: silver.steam_history';
		TRUNCATE TABLE silver.steam_history;
		PRINT '>>Inserting Data Into The Table: silver.steam_history';
		INSERT INTO silver.steam_history(
			player_id,
			achievement_id,
			date_acquired
		)
		SELECT 
			sh.player_id,
			sh.achievement_id,
			sh.date_acquired
		FROM bronze.steam_history sh
		JOIN silver.steam_players sp 
			ON sh.player_id = sp.player_id
		JOIN silver.steam_achievements sa 
			ON sh.achievement_id = sa.achievement_id;
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: silver.steam_reviews';
		TRUNCATE TABLE silver.steam_reviews;
		PRINT '>>Inserting Data Into The Table: silver.steam_reviews';
		INSERT INTO silver.steam_reviews(
			review_id,
			player_id,
			game_id,
			review,
			helpful,
			funny,
			awards,
			posted
		)
		SELECT 
			sr.review_id,
			sr.player_id,
			sr.game_id,
			ISNULL(sr.review, 'n/a'),
			sr.helpful,
			sr.funny,
			sr.awards,
			sr.posted
		FROM bronze.steam_reviews sr
		JOIN silver.steam_players sp 
			ON sr.player_id = sp.player_id
		JOIN silver.steam_games sg
			ON sr.game_id = sg.game_id
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: silver.steam_prices';
		TRUNCATE TABLE silver.steam_prices;
		PRINT '>>Inserting Data Into The Table: silver.steam_prices';
		INSERT INTO silver.steam_prices(
			game_id,
			date_acquired,
			usd,
			eur,
			gbp,
			jpy,
			rub
		)
		SELECT
			sp.game_id,
			sp.date_acquired,
			sp.usd,
			sp.eur,
			sp.gbp,
			sp.jpy,
			sp.rub
		FROM bronze.steam_prices sp 
		JOIN silver.steam_games sg
			ON sp.game_id = sg.game_id;
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

		SET @batch_end_time = GETDATE();
		PRINT '=====================================================';
		PRINT 'Loading Silver Layer is completed.';
		PRINT '		-Total Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds'
		PRINT '=====================================================';
	END TRY
	BEGIN CATCH
		PRINT '=====================================================';
		PRINT 'ERROR OCCURED DURING LOADING SILVER LAYER';
		PRINT 'Error Message: ' + ERROR_MESSAGE();
		PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '=====================================================';
	END CATCH
END