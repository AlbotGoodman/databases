-- MOONMISSIONS

-- G

SELECT 
    Spacecraft, 
    [Launch date], 
    [Carrier rocket], 
    Operator, 
    [Mission type] 
INTO SuccessfulMissions 
FROM MoonMissions 
WHERE Outcome = 'Successful';

GO

UPDATE SuccessfulMissions
SET Operator = TRIM(Operator) 

GO


-- USERS

-- G

SELECT 
    ID,
    UserName,
    [Password],
    FirstName,
    LastName,
    CONCAT(FirstName, ' ', LastName) as [Name],
    CASE 
        WHEN CAST(SUBSTRING(ID, 10, 1) AS INT) % 2 = 0 THEN 'Female'
        ELSE 'Male'
    END AS Gender,
    Email,
    Phone
INTO NewUsers
FROM Users;

GO

SELECT 
    UserName,
    COUNT(UserName) as Duplicates
FROM NewUsers
GROUP BY UserName
HAVING COUNT(UserName) > 1;

GO

ALTER TABLE NewUsers
ALTER COLUMN UserName NVARCHAR(12);
DECLARE @Counter AS INT = 3;
DECLARE @Duplicates AS INT = 1;
WHILE @Duplicates > 0
BEGIN 
    DROP TABLE IF EXISTS #Dupes;
    SELECT UserName
    INTO #Dupes
    FROM NewUsers 
    GROUP BY UserName 
    HAVING COUNT(UserName) > 1;
    SELECT @Duplicates = COUNT(*) FROM #Dupes;
    UPDATE NewUsers
    SET UserName = CONCAT(
        LOWER(LEFT(TRANSLATE(FirstName, 'åäö', 'aao'), @Counter)),
        LOWER(LEFT(TRANSLATE(LastName, 'åäö', 'aao'), @Counter))
    )
    WHERE UserName IN (SELECT UserName FROM #Dupes);
    SET @Counter = @Counter + 1;
    DROP TABLE #Dupes;
    IF @Counter > 10  -- just a fail safe
    BEGIN 
        BREAK;
    END
END 

GO

DELETE FROM NewUsers
WHERE CAST(SUBSTRING(ID, 1, 1) AS INT) < 7 AND Gender = 'Female';

GO

INSERT INTO NewUsers (
    ID, 
    UserName,  -- Could be generated
    [Password], 
    FirstName, 
    LastName, 
    [Name],  -- Could be generated
    Gender,  -- Could be generated
    Email, 
    Phone
)
VALUES (
    '670327-6521', 
    'malfre',  -- Could be generated
    '1efa1bhwua7ppb0twn1tr1wu6702dkss', 
    'Malin', 
    'Frenning', 
    'Malin Frenning',  -- Could be generated
    'Female',  -- Could be generated
    'malin.frenning@ri.se', 
    '010-5165389'
);

GO


-- Company (Joins)

-- G

select 
    p.Id,
    p.ProductName,
    s.CompanyName,
    c.CategoryName
from 
    company.products p 
    join company.suppliers s on p.SupplierId = s.Id 
    join company.categories c on p.CategoryId = c.Id

GO

select 
    r.Id,
    r.RegionDescription,
    count(e.EmployeeId) as 'NumberOfEmployees'
from 
    company.regions r 
    join company.territories t on r.Id = t.RegionId
    join company.employee_territory e on t.Id = e.TerritoryId
group by 
    r.Id,
    r.RegionDescription

GO