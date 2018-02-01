CREATE TABLE [dbo].[PG_Rel]
(
	[PlayerGameId] INT NOT NULL IDENTITY (1, 1) PRIMARY KEY,
	[PlayerId] INT NOT NULL,
	[GameId] INT NOT NULL,
	[DateOwned] DATETIME NOT NULL DEFAULT GETDATE()

)

GO

CREATE INDEX [IX_PG_Rel_PlayerId] ON [dbo].[PG_Rel] ([PlayerId])
GO

CREATE INDEX [IX_PG_Rel_GameId] ON [dbo].[PG_Rel] ([GameId])
GO
