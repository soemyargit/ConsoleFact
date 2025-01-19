Declare @TmpEmployee Table
(
	[EmployeeName] NVarChar(250),
	[EffectiveDate] DateTime,
	[FieldType] NVarChar(80),
	[FieldValue] NVarChar(80)	
)

Insert Into @TmpEmployee([EmployeeName], [EffectiveDate], [FieldType], [FieldValue])
Values('Tay Hui Boon', '01/01/2005', 'Title','Project Engineer')
Insert Into @TmpEmployee([EmployeeName], [EffectiveDate], [FieldType], [FieldValue])
Values('Tay Hui Boon', '01/01/2005', 'Department','IT Department')
Insert Into @TmpEmployee([EmployeeName], [EffectiveDate], [FieldType], [FieldValue])
Values('Tay Hui Boon', '01/01/2007', 'Title','Assistant Project Manager')
Insert Into @TmpEmployee([EmployeeName], [EffectiveDate], [FieldType], [FieldValue])
Values('Ong Lay Keow', '01/01/2006', 'Title','Software Engineer')
Insert Into @TmpEmployee([EmployeeName], [EffectiveDate], [FieldType], [FieldValue])
Values('Ong Lay Keow', '01/01/2006', 'Department','IT Department')

select * from @TmpEmployee

Declare @TmpData Table
(
	EmployeeName NVarChar(250),
	EffectiveDate DateTime,
	FieldType NvarChar(80),
	FieldValue NvarChar(80)
)

Declare @TmpResult Table
(
	EmployeeName NVarChar(250),
	EffectiveDate DateTime,
	Title NvarChar(80),
	Department NvarChar(80)
)


;WITH CTE AS (
    SELECT EmployeeName,
           MAX(CASE WHEN FieldType = 'Title' THEN EffectiveDate END) 'EffectiveDate'
    FROM @TmpEmployee
    GROUP BY EmployeeName
)
Insert Into @TmpData (EmployeeName, EffectiveDate, FieldType, FieldValue)
SELECT c.EmployeeName, c.EffectiveDate, t.FieldType, t.FieldValue
FROM CTE c inner join @TmpEmployee t on c.EmployeeName= t.EmployeeName and c.EffectiveDate = t.EffectiveDate
WHERE t.FieldType = 'Title'
order by c.EmployeeName

;WITH CTED AS (
    SELECT EmployeeName,
           MAX(CASE WHEN FieldType = 'Department' THEN EffectiveDate END) 'EffectiveDate'
    FROM @TmpEmployee
    GROUP BY EmployeeName
)
Insert Into @TmpData (EmployeeName, EffectiveDate, FieldType, FieldValue)
SELECT c.EmployeeName, td.EffectiveDate, t.FieldType, t.FieldValue
FROM CTED c inner join @TmpEmployee t on c.EmployeeName= t.EmployeeName and c.EffectiveDate = t.EffectiveDate
Inner Join @TmpData td on c.EmployeeName = td.EmployeeName
WHERE t.FieldType = 'Department'
order by c.EmployeeName

select Distinct EmployeeName, EffectiveDate 
Into #tmpdata
from @TmpData

DECLARE @EmpName NVarChar(250)
DECLARE @EffDate DateTime
DECLARE @Title NVarChar(80)
DECLARE @Dept NVarChar(80)

SET @EmpName = (select top 1 EmployeeName From #tmpdata Order By EmployeeName)
WHILE (@EmpName IS NOT NULL)
BEGIN
	select @EffDate = EffectiveDate From @TmpData WHERE EmployeeName = @EmpName
	select @Title = FieldValue From @TmpData WHERE EmployeeName = @EmpName AND FieldType = 'Title'
	select @Dept = FieldValue From @TmpData WHERE EmployeeName = @EmpName AND FieldType = 'Department'

	INSERT INTO @TmpResult (EmployeeName, EffectiveDate, Title, Department)
	VALUES (@EmpName, @EffDate, @Title, @Dept)

	DELETE FROM #tmpdata WHERE EmployeeName = @EmpName
	SET @EmpName = (select top 1 EmployeeName From #tmpdata Order By EmployeeName)
END

SELECT * FROM @TmpResult

IF OBJECT_ID('tempdb..#tmpdata')IS NOT NULL
	DROP TABLE #tmpdata








