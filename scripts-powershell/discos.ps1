#Inicializa os discos
Initialize-Disk -Number 1 -PartitionStyle MBR
Initialize-Disk -Number 2 -PartitionStyle MBR

#Cria os Volumes
New-Partition -DiskNumber 1 -UseMaximumSize -DriveLetter G
New-Partition -DiskNumber 2 -UseMaximumSize -DriveLetter Y

#Formata
Format-Volume -DriveLetter G -NewFileSystemLabel "SQLData" -FileSystem NTFS -AllocationUnitSize 65536
Format-Volume -DriveLetter Y -NewFileSystemLabel "SQLLog" -FileSystem NTFS -AllocationUnitSize 65536