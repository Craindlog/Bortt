﻿/*
Deployment script for BorttDB

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BorttDB"
:setvar DefaultFilePrefix "BorttDB"
:setvar DefaultDataPath "C:\Users\Adam\AppData\Local\Microsoft\VisualStudio\SSDT\BorttDB"
:setvar DefaultLogPath "C:\Users\Adam\AppData\Local\Microsoft\VisualStudio\SSDT\BorttDB"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE,
                DISABLE_BROKER 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367)) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'Rename refactoring operation with key 8523f71a-e612-4089-bfc1-7733d7496293 is skipped, element [dbo].[Group].[Id] (SqlSimpleColumn) will not be renamed to GroupID';


GO
PRINT N'Creating [dbo].[Group]...';


GO
CREATE TABLE [dbo].[Group] (
    [GroupID]       INT           NOT NULL,
    [GroupName]     VARCHAR (255) NOT NULL,
    [GroupPassword] VARCHAR (255) NULL,
    [CreateDate]    DATETIME      NOT NULL,
    PRIMARY KEY CLUSTERED ([GroupID] ASC)
);


GO
PRINT N'Creating unnamed constraint on [dbo].[Group]...';


GO
ALTER TABLE [dbo].[Group]
    ADD DEFAULT getdate() FOR [CreateDate];


GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '8523f71a-e612-4089-bfc1-7733d7496293')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('8523f71a-e612-4089-bfc1-7733d7496293')

GO

GO
PRINT N'Update complete.';


GO
