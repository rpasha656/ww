CREATE PROCEDURE [dbo].[GetSubCategories]	
AS
Begin
	SELECT Id,Name from SubCategory order by Name
End
RETURN 0
