Create PROCEDURE [dbo].[GetCategories]
AS
Begin
	SELECT c.Id 'CategoryId', c.Name 'CategoryName',sc.Id 'SubCategoryId',sc.Name 'SubCategoryName' from Category c 
	join SubCategory sc on c.Id = sc.CategoryId 
	where c.IsActive = 1 and sc.IsActive = 1 
	order by c.Name, sc.Name
End
RETURN 0
