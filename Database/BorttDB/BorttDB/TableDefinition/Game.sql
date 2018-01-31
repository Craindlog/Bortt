CREATE TABLE [dbo].[Game]
(
	[GameId] INT NOT NULL PRIMARY KEY, 
    [GameName] VARCHAR(255) NOT NULL, 
    [BggLink] NCHAR(10) NULL, 
    [PlayersMin] INT NOT NULL DEFAULT 1, 
    [PlayersMax] INT NOT NULL DEFAULT 999
)
