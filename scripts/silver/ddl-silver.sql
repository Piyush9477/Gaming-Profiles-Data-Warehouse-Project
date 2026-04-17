/*
DDL Script: Create silver Tables

Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
	Run this script to re-define the DDL structure of 'silver' Tables
*/
IF OBJECT_ID('silver.xbox_players', 'U') IS NOT NULL
    DROP TABLE silver.xbox_players;
GO

CREATE TABLE silver.xbox_players(
    player_id INT,
    nickname NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.xbox_prices', 'U') IS NOT NULL
    DROP TABLE silver.xbox_prices;
GO

CREATE TABLE silver.xbox_prices(
    game_id INT,
    usd DECIMAL(10, 2),
    eur DECIMAL(10, 2),
    gbp DECIMAL(10, 2),
    jpy DECIMAL(10, 2),
    rub DECIMAL(10, 2),
    date_acquired DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.xbox_purchased_games' , 'U') IS NOT NULL
    DROP TABLE silver.xbox_purchased_games;
GO

CREATE TABLE silver.xbox_purchased_games(
    player_id INT,
    library NVARCHAR(MAX),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.xbox_games' , 'U') IS NOT NULL
    DROP TABLE silver.xbox_games;
GO

CREATE TABLE silver.xbox_games(
    game_id INT,
    title NVARCHAR(200),
    developers NVARCHAR(200), 
    publishers NVARCHAR(200),
    genres NVARCHAR(200),
    supported_languages NVARCHAR(200),
    release_date DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.xbox_history' , 'U') IS NOT NULL
    DROP TABLE silver.xbox_history;
GO

CREATE TABLE silver.xbox_history(
    player_id INT,
    achievement_id NVARCHAR(25),
    date_acquired DATETIME,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.xbox_achievements' , 'U') IS NOT NULL
    DROP TABLE silver.xbox_achievements;
GO

CREATE TABLE silver.xbox_achievements(
    achievement_id NVARCHAR(25),
    game_id INT,
    title NVARCHAR(200),
    description NVARCHAR(300),
    points DECIMAL(6,2),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.steam_achievements' , 'U') IS NOT NULL
    DROP TABLE silver.steam_achievements;
GO

CREATE TABLE silver.steam_achievements(
    achievement_id NVARCHAR(MAX),
    game_id INT,   
    title NVARCHAR(MAX),
    description NVARCHAR(MAX),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.steam_friends', 'U') IS NOT NULL
    DROP TABLE silver.steam_friends;
GO

CREATE TABLE silver.steam_friends(
    player_id BIGINT,
    friends NVARCHAR(MAX),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID('silver.steam_history', 'U') IS NOT NULL
    DROP TABLE silver.steam_history;
GO

CREATE TABLE silver.steam_history(
    player_id BIGINT,
    achievement_id NVARCHAR(200),
    date_acquired DATETIME,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.steam_games', 'U') IS NOT NULL
    DROP TABLE silver.steam_games;
GO

CREATE TABLE silver.steam_games(
    game_id INT,
    title NVARCHAR(300),
    developers NVARCHAR(800),
    publishers NVARCHAR(200),
    genres NVARCHAR(300),
    supported_languages NVARCHAR(1300),
    release_date DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.steam_players', 'U') IS NOT NULL
    DROP TABLE silver.steam_players;
GO

CREATE TABLE silver.steam_players(
    player_id BIGINT,
    country NVARCHAR(50),
    created DATETIME,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.steam_prices', 'U') IS NOT NULL
    DROP TABLE silver.steam_prices;
GO

CREATE TABLE silver.steam_prices(
    game_id INT,
    usd DECIMAL(10, 2),
    eur DECIMAL(10, 2),
    gbp DECIMAL(10, 2),
    jpy DECIMAL(10, 2),
    rub DECIMAL(10, 2),
    date_acquired DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.steam_purchased_games', 'U') IS NOT NULL
    DROP TABLE silver.steam_purchased_games;
GO

CREATE TABLE silver.steam_purchased_games(
    player_id BIGINT,
    library NVARCHAR(MAX),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.steam_private_steamids', 'U') IS NOT NULL
    DROP TABLE silver.steam_private_steamids;
GO

CREATE TABLE silver.steam_private_steamids(
    player_id BIGINT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.steam_reviews', 'U') IS NOT NULL
    DROP TABLE silver.steam_reviews;
GO

CREATE TABLE silver.steam_reviews(
    review_id INT,
    player_id BIGINT,
    game_id INT,
    review NVARCHAR(MAX),
    helpful INT,
    funny INT,
    awards INT,
    posted DATETIME,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.playstation_achievements', 'U') IS NOT NULL
    DROP TABLE silver.playstation_achievements;
GO

CREATE TABLE silver.playstation_achievements(
    achievement_id NVARCHAR(25),
    game_id INT,
    title NVARCHAR(150),
    description NVARCHAR(1100),
    rarity NVARCHAR(20),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.playstation_games', 'U') IS NOT NULL
    DROP TABLE silver.playstation_games;
GO

CREATE TABLE silver.playstation_games(
    game_id INT,
    title NVARCHAR(150),
    platform NVARCHAR(15),
    developers NVARCHAR(100),
    publishers NVARCHAR(100),
    genres NVARCHAR(150),
    supported_languages NVARCHAR(400),
    release_date DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.playstation_history', 'U') IS NOT NULL
    DROP TABLE silver.playstation_history;
GO

CREATE TABLE silver.playstation_history(
    player_id INT,
    achievement_id NVARCHAR(25),
    date_acquired DATETIME,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.playstation_purchased_games', 'U') IS NOT NULL
    DROP TABLE silver.playstation_purchased_games;
GO

CREATE TABLE silver.playstation_purchased_games(
    player_id INT,
    library NVARCHAR(MAX),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.playstation_prices', 'U') IS NOT NULL
    DROP TABLE silver.playstation_prices;
GO

CREATE TABLE silver.playstation_prices(
    game_id INT,
    usd DECIMAL(10, 2),
    eur DECIMAL(10, 2),
    gbp DECIMAL(10, 2),
    jpy DECIMAL(10, 2),
    rub DECIMAL(10, 2),
    date_acquired DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.playstation_players', 'U') IS NOT NULL
    DROP TABLE silver.playstation_players;
GO

CREATE TABLE silver.playstation_players(
    player_id INT,
    nickname NVARCHAR(20),
    country NVARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO