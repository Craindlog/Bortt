/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

--INSERT INTO BorttDB.dbo.[Group] (GroupID, GroupName, GroupPassword) VALUES (1, 'TestGroup' , 'password')

DECLARE @GRP_ID INT = (SELECT GroupID FROM BorttDB.dbo.[Group] WHERE GroupName = 'TestGroup')
SELECT * FROM BorttDB.dbo.[Group] WHERE GroupID = @GRP_ID
GO
