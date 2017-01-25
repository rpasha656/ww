CREATE PROCEDURE dbo.Add_Update_Category
    @ReturnValue int out,
	@Id int = 0,
	@Name varchar(100),	
	@Description varchar(255),
	@CreatedBy varchar(100),
	@IsActive bit
AS
Begin

    IF EXISTS (SELECT 1 FROM Category WHERE Id = @Id)
	Begin
	 If EXISTS (SELECT 1 FROM Category c inner join SubCategory s on c.Id = s.CategoryId WHERE c.Id = @Id and c.IsActive = 1 and s.IsActive = 1) and @IsActive = 0
	  Begin
	     set @ReturnValue = 0
		 return;
	  End	
	  update Category set Name = @Name,Description = @Description,CreatedBy = @CreatedBy,LastUpdated = GETDATE(),IsActive = @IsActive  where Id = @Id
	  set @ReturnValue = @Id
	End
	Else
	Begin
	Insert into Category (
	Name,
	Description,
	CreatedBy,
	LastUpdated,
	IsActive) values (
	@Name,
	@Description,
	@CreatedBy,
	GETDATE(),
	@IsActive)
	set @ReturnValue = SCOPE_IDENTITY()
	End
End
