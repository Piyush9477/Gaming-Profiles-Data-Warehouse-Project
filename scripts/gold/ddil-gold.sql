/*
DDL Script: Create Gold Views

Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
*/

-- =============================================================================
-- Create Dimension: gold.vw_dim_players
-- =============================================================================
IF OBJECT_ID('gold.vw_dim_players', 'V') IS NOT NULL
    DROP VIEW gold.vw_dim_players;
GO

CREATE VIEW gold.vw_dim_players AS
WITH combined_players AS (
    SELECT 
        player_id,
        'n/a' AS nickname,
        country,
        'steam' AS platform
    FROM silver.steam_players
    UNION ALL
    SELECT 
        player_id,
        nickname,
        'n/a' AS country,
        'xbox' AS platform
    FROM silver.xbox_players
    UNION ALL
    SELECT
        player_id,
        nickname,
        country,
        'playstation' AS platform
    FROM silver.playstation_players
)
SELECT 
    ROW_NUMBER() OVER(ORDER BY platform, player_id) AS player_sk,
    *
FROM combined_players;
GO

-- =============================================================================
-- Create Dimension: gold.vw_dim_games
-- =============================================================================
IF OBJECT_ID('gold.vw_dim_games', 'V') IS NOT NULL
    DROP VIEW gold.vw_dim_games;
GO

CREATE VIEW gold.vw_dim_games AS
WITH combined_games AS (
    SELECT 
        game_id,
        title,
        release_date,
        'steam' AS platform,
        genres,
        developers,
        publishers,
        supported_languages
    FROM silver.steam_games
    UNION ALL
    SELECT 
        game_id,
        title,
        release_date,
        'xbox' AS platform,
        genres,
        developers,
        publishers,
        supported_languages
    FROM silver.xbox_games
    UNION ALL
    SELECT 
        game_id,
        title,
        release_date,
        platform,
        genres,
        developers,
        publishers,
        supported_languages
    FROM silver.playstation_games
)
SELECT 
    ROW_NUMBER() OVER(ORDER BY platform, game_id) AS game_sk,
    *
FROM combined_games;
GO

-- =============================================================================
-- Create Dimension: gold.vw_dim_achievements
-- =============================================================================
IF OBJECT_ID('gold.vw_dim_achievements', 'V') IS NOT NULL
    DROP VIEW gold.vw_dim_achievements;
GO

CREATE VIEW gold.vw_dim_achievements AS
WITH combined_achievements AS(
    SELECT
        achievement_id,
        game_id,
        title,
        description,
        NULL AS points,
        'steam' AS platform
    FROM silver.steam_achievements
    UNION ALL
    SELECT
        achievement_id,
        game_id,
        title,
        description,
        points,
        'xbox' AS platform
    FROM silver.xbox_achievements
    UNION ALL
    SELECT
        achievement_id,
        game_id,
        title,
        description,
        NULL AS points,
        'playstation' AS platform
    FROM silver.playstation_achievements
)
SELECT 
    ROW_NUMBER() OVER(ORDER BY platform, achievement_id) AS achievement_sk,
    *
FROM combined_achievements;
GO

-- =============================================================================
-- Create Dimension: gold.vw_fact_achievement_earned
-- =============================================================================
IF OBJECT_ID('gold.vw_fact_achievement_earned', 'V') IS NOT NULL
    DROP VIEW gold.vw_fact_achievement_earned;
GO

CREATE VIEW gold.vw_fact_achievement_earned AS
WITH combined_history AS (
    SELECT 
        player_id, achievement_id, date_acquired, 'xbox' AS platform
    FROM silver.xbox_history
    UNION ALL
    SELECT 
        player_id, achievement_id, date_acquired, 'playstation' AS platform
    FROM silver.playstation_history
    UNION ALL
    SELECT 
        player_id, achievement_id, date_acquired, 'steam' AS platform
    FROM silver.steam_history
)
SELECT 
    p.player_sk,
    a.achievement_sk,
    g.game_sk,
    h.date_acquired,
    h.platform,
    a.points
FROM combined_history h 
JOIN gold.vw_dim_players p ON h.player_id = p.player_id AND p.platform = h.platform
JOIN gold.vw_dim_achievements a ON h.achievement_id = a.achievement_id AND a.platform = h.platform
JOIN gold.vw_dim_games g ON a.game_id = g.game_id AND 
    (
        (h.platform != 'playstation' AND h.platform = g.platform) OR
        (h.platform = 'playstation' AND g.platform LIKE 'PS%')
    );
GO

-- =============================================================================
-- Create Dimension: gold.vw_fact_game_prices
-- =============================================================================
IF OBJECT_ID('gold.vw_fact_game_prices', 'V') IS NOT NULL
    DROP VIEW gold.vw_fact_game_prices;
GO

CREATE VIEW gold.vw_fact_game_prices AS
WITH combined_prices AS (
    SELECT
        game_id, date_acquired, 'xbox' AS platform, usd, eur, gbp, jpy, rub
    FROM silver.xbox_prices
    UNION ALL 
    SELECT
        game_id, date_acquired, 'playstation' AS platform, usd, eur, gbp, jpy, rub
    FROM silver.playstation_prices
    UNION ALL 
    SELECT
        game_id, date_acquired, 'steam' AS platform, usd, eur, gbp, jpy, rub
    FROM silver.steam_prices
)
SELECT 
    g.game_sk,
    p.date_acquired,
    p.platform,
    p.usd,
    p.eur,
    p.gbp,
    p.jpy,
    p.rub
FROM combined_prices p
LEFT JOIN gold.vw_dim_games g 
    ON p.game_id = g.game_id AND 
    (
        (p.platform != 'playstation' AND p.platform = g.platform) OR
        (p.platform = 'playstation' AND g.platform LIKE 'PS%')
    );
GO