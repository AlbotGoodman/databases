-- 1 

---- a

select * from #elements

select 
    symbol,
    [name] 
from #elements
where left([name], len(symbol)) = symbol

---- b

select 
    symbol,
    [name]
from #elements 
where 
    [name] like '[hlb]%' or 
    [name] in ('Carbon', 'Nitrogen', 'Oxygen')

---- c 

select 
    symbol,
    [name]
from #elements 
where [number] < 5

-- 2 

select 
    period, -- 1,2,3
    min(number) as 'from', -- 1,3,11
    max(number) as 'to', -- 2,10,12
    string_agg(symbol, ', ') as 'elements' -- alla symboler, kommaseparerade
from #elements
group by period;

-- 3

create table #periodic_elements (
    period int,
    [from] int,
    [to] int,
    [elements] nvarchar(max)
);

select * from #periodic_elements

---- a

insert into #periodic_elements ([period], [from], [to], [elements])
select
    [period],
    min([number]) as [from],
    max([number]) as [to],
    string_agg([symbol], ', ') as [elements]
from #elements
group by [period];

---- b 

-- nej, listar flera symboler i en cell

-- 4

select 
    period,
    [number]  -- this isn't listed in group by so it fails for that reason, either include it or aggregate it
from #elements 
group by period;

-- 5 = 1NF yes, 2NF yes, 3NF yes

create table #course (
    courseID int primary key,
    [name] nvarchar(120),
    credits int
);

create table #student (
    studentID int primary key,
    [name] nvarchar(32)
);

create table #student_grade (
    courseID int references #course,
    studentID int references #student, 
    grade nvarchar(2),
    primary key (courseID, studentID)
);

-- 6

insert into #course (courseID, [name], credits) values
(1, 'Mathematics', 5),
(2, 'Physics', 4),
(3, 'Chemistry', 3);

insert into #student (studentID, [name]) values
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

insert into #student_grade (courseID, studentID, grade) values
(1, 1, 'A'),
(2, 1, 'B'),
(3, 1, 'A'),
(1, 2, 'C'),
(2, 2, 'B'),
(3, 3, 'A');

GO

select 
    s.name, 
    c.name,
    g.grade
from #student s
join #student_grade g on s.studentID = g.studentID
join #course c on g.courseID = c.courseID