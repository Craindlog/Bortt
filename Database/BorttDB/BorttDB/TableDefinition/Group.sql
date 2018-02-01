
CREATE TABLE [dbo].[Group]
(
	[GroupID] INT NOT NULL IDENTITY (1, 1) PRIMARY KEY, 
	[GroupName] VARCHAR(255) NOT NULL, 
	[GroupPassword] VARCHAR(255) NULL, 
	[CreateDate] DATETIME NOT NULL DEFAULT getdate()
)

