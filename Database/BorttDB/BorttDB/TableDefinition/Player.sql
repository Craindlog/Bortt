CREATE TABLE [dbo].[Player]
(
	[PlayerId] INT NOT NULL PRIMARY KEY, 
    [PlayerName] VARCHAR(255) NOT NULL, 
    [CreatedOn] DATETIME NOT NULL DEFAULT getdate()
)
