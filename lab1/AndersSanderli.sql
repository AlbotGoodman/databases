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

-- VG

UPDATE MoonMissions 
SET Spacecraft = TRIM(SUBSTRING(Spacecraft, 1, CHARINDEX('(', Spacecraft) -1))
WHERE CHARINDEX('(', Spacecraft) > 0

GO

SELECT 
    Operator, 
    [Mission type],
    COUNT(*) AS [Mission count]
FROM SuccessfulMissions
GROUP BY 
    Operator, 
    [Mission type]
HAVING COUNT(*) > 1
ORDER BY 
    Operator, 
    [Mission type]

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

-- VG

SELECT 
    Gender,
    AVG(
        DATEDIFF(
            YEAR, 
            CAST('19' + 
                LEFT([id], 2) + '-' + 
                SUBSTRING([id], 3, 2) + '-' + 
                SUBSTRING([id], 5, 2) AS DATE), 
            CAST(GETDATE() AS DATE)
        )
    ) AS [Average age]
FROM NewUsers
GROUP BY Gender

GO


-- Company (Joins)

-- G

SELECT 
    p.Id,
    p.ProductName,
    s.CompanyName,
    c.CategoryName
FROM 
    company.products p 
    JOIN company.suppliers s on p.SupplierId = s.Id 
    JOIN company.categories c on p.CategoryId = c.Id

GO

SELECT 
    r.Id,
    r.RegionDescription,
    COUNT(e.EmployeeId) AS 'NumberOfEmployees'
FROM 
    company.regions r 
    JOIN company.territories t ON r.Id = t.RegionId
    JOIN company.employee_territory e ON t.Id = e.TerritoryId
GROUP BY 
    r.Id,
    r.RegionDescription

GO

-- VG

SELECT
    e.Id,
    CONCAT(e.TitleOfCourtesy, ' ', e.FirstName, ' ', e.LastName) AS [Name],
    CASE 
        WHEN e2.Id IS NULL
        THEN 'Nobody!'
        ELSE CONCAT(e2.TitleOfCourtesy, ' ', e2.FirstName, ' ', e2.LastName)
    END AS [Reports to]
FROM company.employees e 
LEFT JOIN company.employees e2 ON e2.Id = e.ReportsTo

select * from company.employees