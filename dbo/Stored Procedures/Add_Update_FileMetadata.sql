CREATE PROCEDURE dbo.Add_Update_FileMetadata
    @ReturnValue int out,
	@Id int = 0,
	@PlanName varchar(10),
	@CategoryId int,
	@SubCategoryId int,
	@FileName varchar(255),
	@FileExtensionId int,
	@SposId int,
	@SposUrl varchar(max),
	@StatusDate datetime,
	@ExpirationDate datetime,
	@AccessedOn datetime,
	@StatusId int,
	@DisplayName varchar(255),
	@FileSize int = 0
AS
Begin

    IF EXISTS (SELECT 1 FROM FileMetadata WHERE Id = @Id)
	Begin
	  update FileMetadata set CategoryId = @CategoryId,SubCategoryId = @SubCategoryId,FileName = @FileName,ExpirationDate = @ExpirationDate, DisplayName=@DisplayName, FileSize= @FileSize  where Id = @Id
	  If EXISTS (SELECT 1 FROM Spos WHERE SposId = @SposId)
	  Begin
		update Spos set SposUrl = @SposUrl where SposId = @SposId
	  End
	  set @ReturnValue = @Id
	End
	Else
	Begin
	Insert into FileMetadata (
	PlanName,
	CategoryId,
	SubCategoryId,
	FileName,
	FileExtensionId,
	SposId,
	StatusDate,
	ExpirationDate,
	AccessedOn,
	CreatedOn,
	StatusId,
	DisplayName,
	FileSize) values (@PlanName,
	@CategoryId,
	@SubCategoryId,
	@FileName,
	@FileExtensionId,
	@SposId,
	@StatusDate,
	@ExpirationDate,
	@AccessedOn,
	GETDATE(),
	@StatusId,
	@DisplayName,
	@FileSize)
	set @ReturnValue = SCOPE_IDENTITY()
	If @SposId = 0
	  Begin
		Insert into Spos (SposId,SposUrl) values (@SposId,@SposUrl)
	  End
	End
End
