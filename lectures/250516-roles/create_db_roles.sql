create database publictest;
use publictest;

GO

create table messages(
    [id] int primary key identity(1,1),
    [username] nvarchar(10),
    [subject] nvarchar(50),
    [body] nvarchar(1000)
);

alter table messages
    add [IP] nvarchar(20);

GO

-- skapa login för användare med lösenord

create login ITHS with password = '@I2T0H2S5';  
create user ITHS for login ITHS;

GO

alter role [db_datareader] add member ITHS;

GO

create procedure sendMessage @subject nvarchar(50), @message nvarchar(1000), @username nvarchar(10) = 'Anonymous' as 
begin 
    declare @IP_Address varchar(255);
    select @IP_Address = cast(CONNECTIONPROPERTY('client_net_address') as varchar);
    insert into messages values (@username, @subject, @message, @IP_Address)
end;

GO

grant execute on sendMessage to ITHS;

-- nedan kanske måste ligga i en separat query, osäker

exec sendMessage 'Hello', 'How are you?';