RESTORE DATABASE everyloop
FROM DISK = '/var/opt/mssql/data/everyloop.bak'
WITH MOVE 'everyloop' TO '/var/opt/mssql/data/everyloop.mdf',
MOVE 'everyloop_log' TO '/var/opt/mssql/data/everyloop_log.ldf';