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

-- while-loop that increases 
-- the number of letters to include 
-- until there are no duplicates?


declare @counter as int = 3
declare @duplicates as int = 1
while @duplicates > 0
-- allt nedanför måste jag göra om så att det fungerar med det ovanför
    select username 
    from newusers2 
    group by username 
    having count(username) > 1
begin 
    update newusers2
    set username = concat(
        lower(left(translate(firstname, 'åäö', 'aao'), @counter)),
        lower(left(translate(lastname, 'åäö', 'aao'), @counter))
    )
    set @counter = @counter + 1
end 



select * from newusers2;
