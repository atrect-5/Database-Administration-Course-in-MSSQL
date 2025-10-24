-- Este Script muestra cuales son los codigos de error excistentes en SQL Server ordenados por Severidad en español
SELECT m.message_id, m.severity, m.is_event_logged, m.[text]
FROM sys.messages m
INNER JOIN sys.syslanguages l ON m.language_id = l.msglangid
WHERE l.alias = 'Spanish'
ORDER BY m.severity DESC, m.[text]
