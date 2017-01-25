CREATE PROCEDURE dbo.Add_Update_SubCategory
    @ReturnValue int out,
	@Id int = 0,
	@Name varchar(100),	
	@Description varchar(255),
	@CreatedBy varchar(100),
	@CategoryId int,
	@IsActive bit
AS
Begin

    IF EXISTS (SELECT 1 FROM SubCategory WHERE Id = @Id)
	Begin
	  If EXISTS (SELECT 1 FROM SubCategory s inner join FileMetadata f on s.Id = f.SubCategoryId WHERE s.Id = @Id and s.IsActive = 1) and @IsActive = 0
	  Begin
	     set @ReturnValue = 0
		 return;
	  End
	  update SubCategory set Name = @Name,Description = @Description,CreatedBy = @CreatedBy,CategoryId = @CategoryId,LastUpdated = GETDATE(),IsActive = @IsActive where Id = @Id
	  set @ReturnValue = @Id
	End
	Else
	Begin
	Insert into SubCategory (
	Name,
	Description,
	CategoryId,
	CreatedBy,
	LastUpdated,
	IsActive) values (
	@Name,
	@Description,
	@CategoryId,
	@CreatedBy,
	GETDATE(),
	@IsActive)
	set @ReturnValue = SCOPE_IDENTITY()
	End
End
