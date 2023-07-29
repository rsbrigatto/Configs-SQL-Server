EXEC sys.sp_configure N'show advanced options', N'1';
GO
RECONFIGURE
GO

EXEC sys.sp_configure N'max degree of parallelism', N'8'; -- Modificar 8 para o número de processadores
EXEC sys.sp_configure N'cost threshold for parallelism', N'50';
EXEC sys.sp_configure N'remote admin connections', N'1';
EXEC sys.sp_configure N'backup compression default', N'1';

-- Definir memória do SQL Server para 90% da memória do servidor
DECLARE @stringToExecute NVARCHAR(400);
SELECT @stringToExecute = N'EXEC sys.sp_configure N''max server memory (MB)'', N'''
	+ CAST(CAST(physical_memory_kb / 1024 * .9 AS INT) AS NVARCHAR(20)) + N''';'
FROM sys.dm_os_sys_info
EXECUTE (@stringToExecute);
GO

RECONFIGURE;
GO
