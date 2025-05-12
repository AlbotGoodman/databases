-- ISO-SQL
select cast(5.6 as int)

-- Convert �r specifikt f�r T-SQL
select convert(int, 5.6);
select convert(nvarchar, getdate(), 121)

-- Vill man konvertera numerics eller datetime till str�ngar av ett visst format anv�nds funktionen format()
select format(getdate(), 'yyyy-MM-dd HH:mm:ss.fff');
