/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'silver' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/

-- ====================================================================
-- Checking 'silver.xbox_players'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT player_id, COUNT(*) AS duplicates 
FROM silver.xbox_players
GROUP BY player_id 
HAVING COUNT(*) > 1 OR player_id IS NULL;

-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT nickname
FROM silver.xbox_players
WHERE nickname != TRIM(nickname);

-- ====================================================================
-- Checking 'silver.xbox_games'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT game_id, COUNT(*) AS duplicates 
FROM silver.xbox_games	
GROUP BY game_id 
HAVING COUNT(*) > 1 OR game_id IS NULL

-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT title 
FROM silver.xbox_games
WHERE title != TRIM(title)

-- Check for NULL titles
-- Expectation: No Result
SELECT * FROM silver.xbox_games
WHERE title IS NULL

-- ====================================================================
-- Checking 'silver.xbox_prices'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT game_id, date_acquired, COUNT(*) AS duplicates
FROM silver.xbox_prices
GROUP BY game_id, date_acquired
HAVING COUNT(*) >1 OR game_id IS NULL OR date_acquired IS NULL

-- Check for data consistency between related fields
-- Expectation: No Results
SELECT game_id
FROM silver.xbox_prices
WHERE game_id NOT IN (
	SELECT game_id FROM silver.xbox_games
)

-- ====================================================================
-- Checking 'silver.xbox_purchased_games'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT player_id, COUNT(*) AS duplicates
FROM silver.xbox_purchased_games
GROUP BY player_id HAVING COUNT(*) > 1 OR player_id IS NULL

-- Check for data consistency between related fields
-- Expectation: No Results
SELECT * FROM silver.xbox_purchased_games
WHERE player_id NOT IN (
	SELECT player_id from silver.xbox_players
)

-- ====================================================================
-- Checking 'silver.xbox_achievements'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT achievement_id, COUNT(*) AS duplicates
FROM silver.xbox_achievements
GROUP BY achievement_id HAVING COUNT(*) > 1 or achievement_id IS NULL

-- Check for data consistency between related fields
-- Expectation: No Results
SELECT xa.game_id
FROM silver.xbox_achievements xa
WHERE NOT EXISTS (
    SELECT 1 
    FROM silver.xbox_games xg
    WHERE xa.game_id = xg.game_id
)

-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT * 
FROM silver.xbox_achievements 
WHERE title != TRIM(title) OR description != TRIM(description)

-- ====================================================================
-- Checking 'silver.xbox_history'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT player_id, achievement_id, COUNT(*) AS duplicates
FROM silver.xbox_history
GROUP BY player_id, achievement_id HAVING COUNT(*) > 1 OR player_id IS NULL OR achievement_id IS NULL

-- Check for data consistency between related fields
-- Expectation: No Results
SELECT xh.player_id
FROM silver.xbox_history xh
WHERE NOT EXISTS (
    SELECT 1
    FROM silver.xbox_players xp
    WHERE xh.player_id = xp.player_id
)

SELECT xh.achievement_id
FROM silver.xbox_history xh
WHERE NOT EXISTS (
    SELECT 1
    FROM silver.xbox_achievements xa
    WHERE xh.achievement_id = xa.achievement_id
)


-- ====================================================================
-- Checking 'silver.playstation_players'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT player_id, COUNT(*) AS duplicates
FROM silver.playstation_players
GROUP BY player_id HAVING COUNT(*) > 1 OR player_id IS NULL

-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT * 
FROM silver.playstation_players
WHERE nickname != TRIM(nickname) OR country != TRIM(country)


-- ====================================================================
-- Checking 'silver.playstation_games'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT game_id, COUNT(*) AS duplicates
FROM silver.playstation_games
GROUP BY game_id HAVING COUNT(*) > 1 OR game_id IS NULL

-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT *
FROM silver.playstation_games
WHERE title != TRIM(title) OR platform != TRIM(platform)

-- ====================================================================
-- Checking 'silver.playstation_achievements'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT achievement_id, COUNT(*) AS duplicates
FROM silver.playstation_achievements
GROUP BY achievement_id HAVING COUNT(*) > 1 OR achievement_id IS NULL

-- Check for data consistency between related fields
-- Expectation: No Results
SELECT pa.game_id
FROM silver.playstation_achievements pa
WHERE NOT EXISTS (
    SELECT 1 
    FROM silver.playstation_games pg 
    WHERE pa.game_id = pg.game_id
)

-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT *
FROM silver.playstation_achievements
WHERE title != TRIM(title) OR description != TRIM(description);

-- ====================================================================
-- Checking 'silver.playstation_prices'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT game_id, date_acquired, COUNT(*) AS duplicates
FROM silver.playstation_prices
GROUP BY game_id, date_acquired HAVING COUNT(*) > 1 OR game_id IS NULL OR date_acquired IS NULL

-- Check for data consistency between related fields
-- Expectation: No Results
SELECT pp.game_id
FROM silver.playstation_prices pp 
WHERE NOT EXISTS (
    SELECT 1
    FROM silver.playstation_games pg 
    WHERE pp.game_id = pg.game_id
)

-- ====================================================================
-- Checking 'silver.playstation_purchased_games'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT player_id, COUNT(*) AS duplicates
FROM silver.playstation_purchased_games
GROUP BY player_id HAVING COUNT(*) > 1 OR player_id IS NULL

-- Check for data consistency between related fields
-- Expectation: No Results
SELECT ppg.player_id
FROM silver.playstation_purchased_games ppg
WHERE NOT EXISTS(
    SELECT 1 
    FROM silver.playstation_players pp 
    WHERE ppg.player_id = pp.player_id
)

-- ====================================================================
-- Checking 'silver.playstation_history'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT player_id, achievement_id, COUNT(*) AS duplicates
FROM silver.playstation_history
GROUP BY player_id, achievement_id HAVING COUNT(*) > 1 OR player_id IS NULL OR achievement_id IS NULL

-- Check for data consistency between related fields
-- Expectation: No Results
SELECT ph.player_id
FROM silver.playstation_history ph 
WHERE NOT EXISTS(
    SELECT 1
    FROM silver.playstation_players pp 
    WHERE ph.player_id = pp.player_id
)

SELECT ph.achievement_id
FROM silver.playstation_history ph
WHERE NOT EXISTS(
    SELECT 1 
    FROM silver.playstation_achievements pa
    WHERE pa.achievement_id = ph.achievement_id
) 

-- ====================================================================
-- Checking 'silver.steam_players'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT player_id, COUNT(*) AS duplicates
FROM silver.steam_players
GROUP BY player_id HAVING COUNT(*) > 1 OR player_id IS NULL

-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT *
FROM silver.steam_players
WHERE country != TRIM(country)

-- ====================================================================
-- Checking 'silver.steam_games'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT game_id, COUNT(*) AS duplicates
FROM silver.steam_games
GROUP BY game_id HAVING COUNT(*) > 1 OR game_id IS NULL

-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT *
FROM silver.steam_games
WHERE title != TRIM(title)

-- ====================================================================
-- Checking 'silver.steam_private_steamids'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT player_id, COUNT(*) AS duplicates
FROM silver.steam_private_steamids
GROUP BY player_id HAVING COUNT(*) > 1 OR player_id IS NULL

-- ====================================================================
-- Checking 'silver.steam_achievements'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT achievement_id COLLATE SQL_Latin1_General_CP1_CS_AS AS achievement_id, COUNT(*) AS duplicates
FROM silver.steam_achievements
GROUP BY achievement_id COLLATE SQL_Latin1_General_CP1_CS_AS 
HAVING COUNT(*) > 1 OR achievement_id COLLATE SQL_Latin1_General_CP1_CS_AS IS NULL

-- Check for data consistency between related fields
-- Expectation: No Results
SELECT sa.game_id
FROM silver.steam_achievements sa 
WHERE NOT EXISTS(
    SELECT 1 
    FROM silver.steam_games sg
    WHERE sa.game_id = sg.game_id
)

-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT * 
FROM silver.steam_achievements
WHERE title != TRIM(title) OR description != TRIM(description)

-- ====================================================================
-- Checking 'silver.steam_friends'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT player_id, COUNT(*) AS duplicates
FROM silver.steam_friends
GROUP BY player_id HAVING COUNT(*) > 1 OR player_id IS NULL

-- Check for data consistency between related fields
-- Expectation: No Results
SELECT sf.player_id
FROM silver.steam_friends sf 
WHERE NOT EXISTS (
    SELECT 1 
    FROM silver.steam_players sp 
    WHERE sf.player_id = sp.player_id
)

-- ====================================================================
-- Checking 'silver.steam_purchased_games'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT player_id, COUNT(*) AS duplicates
FROM silver.steam_purchased_games
GROUP BY player_id HAVING COUNT(*) > 1 OR player_id IS NULL

-- Check for data consistency between related fields
-- Expectation: No Results
SELECT spg.player_id
FROM silver.steam_purchased_games spg 
WHERE NOT EXISTS (
    SELECT 1 
    FROM silver.steam_players sp 
    WHERE spg.player_id = sp.player_id
)

-- ====================================================================
-- Checking 'silver.steam_history'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT player_id, achievement_id, COUNT(*) AS duplicates
FROM silver.steam_history
GROUP BY player_id, achievement_id HAVING COUNT(*) > 1 OR player_id IS NULL OR achievement_id IS NULL

-- Check for data consistency between related fields
-- Expectation: No Results
SELECT sh.player_id
FROM silver.steam_history sh
WHERE NOT EXISTS (
    SELECT 1
    FROM silver.steam_players sp
    WHERE sh.player_id = sp.player_id
)

SELECT sh.achievement_id
FROM silver.steam_history sh
WHERE NOT EXISTS (
    SELECT 1
    FROM silver.steam_achievements sa
    WHERE sh.achievement_id = sa.achievement_id
)

-- ====================================================================
-- Checking 'silver.steam_reviews'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT review_id, COUNT(*) AS duplicates
FROM silver.steam_reviews
GROUP BY review_id HAVING COUNT(*) > 1 OR review_id IS NULL

-- Check for data consistency between related fields
-- Expectation: No Results
SELECT sr.player_id
FROM silver.steam_reviews sr
WHERE NOT EXISTS(
    SELECT 1
    FROM silver.steam_players sp 
    WHERE sr.player_id = sp.player_id
)   

SELECT sr.game_id
FROM silver.steam_reviews sr
WHERE NOT EXISTS(
    SELECT 1
    FROM silver.steam_games sg
    WHERE sr.game_id = sg.game_id
)   

-- Check for Null columns
-- Exceptation: No Result
SELECT * 
FROM silver.steam_reviews 
WHERE review IS NULL OR helpful IS NULL OR funny IS NULL OR awards IS NULL

-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT *
FROM silver.steam_reviews 
WHERE review != TRIM(review)

-- ====================================================================
-- Checking 'silver.steam_prices'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT game_id, date_acquired, COUNT(*) AS duplicates
FROM silver.steam_prices
GROUP BY game_id, date_acquired HAVING COUNT(*) > 1 OR game_id IS NULL OR date_acquired IS NULL

-- Check for data consistency between related fields
-- Expectation: No Results
SELECT sp.game_id
FROM silver.steam_prices sp 
WHERE NOT EXISTS(
    SELECT 1
    FROM silver.steam_games sg
    WHERE sp.game_id = sg.game_id
)