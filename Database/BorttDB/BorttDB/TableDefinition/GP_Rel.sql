CREATE TABLE [dbo].[GP_Rel]
(
	[GroupPlayerId] INT NOT NULL IDENTITY (1, 1) PRIMARY KEY,
	[GroupId] INT NOT NULL,
	[PlayerId] INT NOT NULL,
	[JoinDate] DATETIME NOT NULL DEFAULT GETDATE(),
	[ActiveUntil] DATETIME NOT NULL DEFAULT '12/31/9999'
)

GO

CREATE INDEX [IX_GP_Rel_GroupId] ON [dbo].[GP_Rel] ([GroupId])
GO

CREATE INDEX [IX_GP_Rel_PlayerId] ON [dbo].[GP_Rel] ([PlayerId])
GO
