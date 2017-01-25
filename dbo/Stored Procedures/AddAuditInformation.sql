CREATE PROCEDURE [dbo].[AddAuditInformation]
	@Id int output,
	@UserId varchar(100),
	@PlanId varchar(10), 
	@FileMetadataId int,
	@OperationId int,
	@Description varchar(255)
AS
Begin	
  Insert into Audit(UserId,PlanId,FileMetadataId,OperationId,Description,CreatedOn) 
  Values 
  (@UserId,@PlanId,@FileMetadataId,@OperationId,@Description,GETDATE())
  set @Id = SCOPE_IDENTITY()
End
