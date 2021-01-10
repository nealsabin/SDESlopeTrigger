/* Calculate Slope Trigger*/
CREATE TRIGGER SlopeCalc
	ON /*'Adds delta table'*/
	FOR UPDATE, INSERT
AS 
BEGIN
	SET NOCOUNT ON;

	DECLARE @UPELEV decimal(5,2),
			@DOWNELEV decimal(5,2),
			@Length decimal(18,2)

	SELECT @UPELEV = /*'upstream elevation column name'*/, @DOWNELEV = /*'down stream elevation column name'*/, @Length = /*'length column'*/
	FROM Inserted;

	IF @UPELEV IS NOT NULL AND @DOWNELEV IS NOT NULL AND @Length IS NOT NULL AND @Length > 0
	BEGIN
		UPDATE /*'Adds delta table'*/
			SET /*'Slope column'*/ = (((@UPELEV - @DOWNELEV) / @Length) *100)
			WHERE /*'OBJECTID column'*/ IN (SELECT /*'OBJECTID column'*/ FROM Inserted);
	END;
	ELSE 
		UPDATE /*'Adds delta table'*/
		SET /*'Slope column'*/ = NULL
		WHERE /*'OBJECTID column'*/ IN (SELECT /*'OBJECTID column'*/ FROM Inserted);
END


