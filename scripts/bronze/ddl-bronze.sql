/*
DDL Script: Create Bronze Tables

Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	Run this script to re-define the DDL structure of 'bronze' Tables
*/

IF OBJECT_ID('bronze.xbox_players', 'U') IS NOT NULL
    DROP TABLE bronze.xbox_players;
GO

CREATE TABLE bronze.xbox_players(
    player_id INT,
    nickname NVARCHAR(50)
);
GO

IF OBJECT_ID('bronze.xbox_prices', 'U') IS NOT NULL
    DROP TABLE bronze.xbox_prices;
GO

CREATE TABLE bronze.xbox_prices(
    game_id INT,
    usd DECIMAL(10, 2),
    eur DECIMAL(10, 2),
    gbp DECIMAL(10, 2),
    jpy DECIMAL(10, 2),
    rub DECIMAL(10, 2),
    date_acquired DATETIME
);
GO

IF OBJECT_ID('bronze.xbox_purchased_games' , 'U') IS NOT NULL
    DROP TABLE bronze.xbox_purchased_games;
GO

CREATE TABLE bronze.xbox_purchased_games(
    player_id INT,
    library NVARCHAR(MAX)
);
GO

IF OBJECT_ID('bronze.xbox_games' , 'U') IS NOT NULL
    DROP TABLE bronze.xbox_games;
GO

CREATE TABLE bronze.xbox_games(
    game_id INT,
    title NVARCHAR(200),
    developers NVARCHAR(200), 
    publishers NVARCHAR(200),
    genres NVARCHAR(200),
    supported_languages NVARCHAR(200),
    release_date DATETIME
);
GO

IF OBJECT_ID('bronze.xbox_history' , 'U') IS NOT NULL
    DROP TABLE bronze.xbox_history;
GO

CREATE TABLE bronze.xbox_history(
    player_id INT,
    achievement_id NVARCHAR(25),
    date_acquired DATETIME
);
GO

IF OBJECT_ID('bronze.xbox_achievements' , 'U') IS NOT NULL
    DROP TABLE bronze.xbox_achievements;
GO

CREATE TABLE bronze.xbox_achievements(
    achievement_id NVARCHAR(25),
    game_id INT,
    title NVARCHAR(200),
    description NVARCHAR(300),
    points DECIMAL(6,2)
);
GO

IF OBJECT_ID('bronze.steam_achievements' , 'U') IS NOT NULL
    DROP TABLE bronze.steam_achievements;
GO

CREATE TABLE bronze.steam_achievements(
    achievement_id NVARCHAR(MAX),
    game_id INT,   
    title NVARCHAR(MAX),
    description NVARCHAR(MAX)
);
GO

IF OBJECT_ID('bronze.steam_friends', 'U') IS NOT NULL
    DROP TABLE bronze.steam_friends;
GO

CREATE TABLE bronze.steam_friends(
    player_id BIGINT,
    friends NVARCHAR(MAX)
);
GO

IF OBJECT_ID('bronze.steam_history', 'U') IS NOT NULL
    DROP TABLE bronze.steam_history;
GO

CREATE TABLE bronze.steam_history(
    player_id BIGINT,
    achievement_id NVARCHAR(200),
    date_acquired DATETIME
);
GO

IF OBJECT_ID('bronze.steam_games', 'U') IS NOT NULL
    DROP TABLE bronze.steam_games;
GO

CREATE TABLE bronze.steam_games(
    game_id INT,
    title NVARCHAR(300),
    developers NVARCHAR(800),
    publishers NVARCHAR(200),
    genres NVARCHAR(300),
    supported_languages NVARCHAR(1300),
    release_date DATETIME
);
GO

IF OBJECT_ID('bronze.steam_players', 'U') IS NOT NULL
    DROP TABLE bronze.steam_players;
GO

CREATE TABLE bronze.steam_players(
    player_id BIGINT,
    country NVARCHAR(50),
    created DATETIME
);
GO

IF OBJECT_ID('bronze.steam_prices', 'U') IS NOT NULL
    DROP TABLE bronze.steam_prices;
GO

CREATE TABLE bronze.steam_prices(
    game_id INT,
    usd DECIMAL(10, 2),
    eur DECIMAL(10, 2),
    gbp DECIMAL(10, 2),
    jpy DECIMAL(10, 2),
    rub DECIMAL(10, 2),
    date_acquired DATETIME
);
GO

IF OBJECT_ID('bronze.steam_purchased_games', 'U') IS NOT NULL
    DROP TABLE bronze.steam_purchased_games;
GO

CREATE TABLE bronze.steam_purchased_games(
    player_id BIGINT,
    library NVARCHAR(MAX)
);
GO

IF OBJECT_ID('bronze.steam_private_steamids', 'U') IS NOT NULL
    DROP TABLE bronze.steam_private_steamids;
GO

CREATE TABLE bronze.steam_private_steamids(
    player_id BIGINT
);
GO

IF OBJECT_ID('bronze.steam_reviews', 'U') IS NOT NULL
    DROP TABLE bronze.steam_reviews;
GO

CREATE TABLE bronze.steam_reviews(
    review_id INT,
    player_id BIGINT,
    game_id INT,
    review NVARCHAR(MAX),
    helpful INT,
    funny INT,
    awards INT,
    posted DATETIME
);
GO

IF OBJECT_ID('bronze.playstation_achievements', 'U') IS NOT NULL
    DROP TABLE bronze.playstation_achievements;
GO

CREATE TABLE bronze.playstation_achievements(
    achievement_id NVARCHAR(25),
    game_id INT,
    title NVARCHAR(150),
    description NVARCHAR(1100),
    rarity NVARCHAR(20)
);
GO

IF OBJECT_ID('bronze.playstation_games', 'U') IS NOT NULL
    DROP TABLE bronze.playstation_games;
GO

CREATE TABLE bronze.playstation_games(
    game_id INT,
    title NVARCHAR(150),
    platform NVARCHAR(15),
    developers NVARCHAR(100),
    publishers NVARCHAR(100),
    genres NVARCHAR(150),
    supported_languages NVARCHAR(400),
    release_date DATETIME
);
GO

IF OBJECT_ID('bronze.playstation_history', 'U') IS NOT NULL
    DROP TABLE bronze.playstation_history;
GO

CREATE TABLE bronze.playstation_history(
    player_id INT,
    achievement_id NVARCHAR(25),
    date_acquired DATETIME
);
GO

IF OBJECT_ID('bronze.playstation_purchased_games', 'U') IS NOT NULL
    DROP TABLE bronze.playstation_purchased_games;
GO

CREATE TABLE bronze.playstation_purchased_games(
    player_id INT,
    library NVARCHAR(MAX)
);
GO

IF OBJECT_ID('bronze.playstation_prices', 'U') IS NOT NULL
    DROP TABLE bronze.playstation_prices;
GO

CREATE TABLE bronze.playstation_prices(
    game_id INT,
    usd DECIMAL(10, 2),
    eur DECIMAL(10, 2),
    gbp DECIMAL(10, 2),
    jpy DECIMAL(10, 2),
    rub DECIMAL(10, 2),
    date_acquired DATETIME
);
GO

IF OBJECT_ID('bronze.playstation_players', 'U') IS NOT NULL
    DROP TABLE bronze.playstation_players;
GO

CREATE TABLE bronze.playstation_players(
    player_id INT,
    nickname NVARCHAR(20),
    country NVARCHAR(50)
);
GO