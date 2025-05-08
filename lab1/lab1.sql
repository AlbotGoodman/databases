-- MOONMISSIONS

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

asd 

GO



select * from SuccessfulMissions;