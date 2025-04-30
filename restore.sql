RESTORE DATABASE everyloop
FROM DISK = '/home/albot/coding/repos/databases/data/everyloop.bak'
WITH MOVE 'everyloop' TO '/var/opt/mssql/data/everyloop.mdf',
MOVE 'everyloop_log' TO '/var/opt/mssql/data/everyloop_log.ldf'