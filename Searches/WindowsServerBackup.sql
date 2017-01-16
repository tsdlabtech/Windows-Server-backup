SELECT 
   computers.computerid as `Computer Id`,
   computers.name as `Computer Name`,
   clients.name as `Client Name`,
   computers.domain as `Computer Domain`,
   computers.username as `Computer User`,
   IFNULL(crd1.RoleDefinitionId,0) as `Windows Server Backup-1`
FROM Computers 
LEFT JOIN inv_operatingsystem ON (Computers.ComputerId=inv_operatingsystem.ComputerId)
LEFT JOIN Clients ON (Computers.ClientId=Clients.ClientId)
LEFT JOIN Locations ON (Computers.LocationId=Locations.LocationID)
LEFT JOIN ComputerRoleDefinitions crd1 ON (crd1.ComputerId=Computers.ComputerId And crd1.RoleDefinitionId=(Select RoleDefinitionId From RoleDefinitions Where RoleDetectionGuid='93302d79-ab18-11e6-b6be-001d0967da05') And (crd1.Type=1 OR (crd1.CurrentlyDetected=1 and crd1.Type<>2)))
 WHERE 
((IFNULL(crd1.RoleDefinitionId,0) >0 ))
