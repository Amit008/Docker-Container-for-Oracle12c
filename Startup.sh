#!/bin/bash
  
DB_NAME=orcl

if [ "$1" == "CreateOnly" ];then

su -s /bin/bash oracle -c "lsnrctl start"
su -s /bin/bash oracle -c "cp /opt/Utility/PFILE/init.ora /u01/app/oracle/product/12.1.0.2/dbhome_1/dbs/init.ora"
su -s /bin/bash oracle -c "cp /u01/app/oracle/product/12.1.0.2/dbhome_1/dbs/init.ora /u01/app/oracle/product/12.1.0.2/dbhome_1/dbs/initorcl.ora"
su -s /bin/bash oracle -c "sqlplus /nolog @/opt/Utility/scripts/CreateDB.sql"
#su -s /bin/bash oracle -c "sqlplus / as sysdba @/u01/app/oracle/product/12.1.0.2/dbhome_1/rdbms/admin/catalog.sql"
#exit
#su -s /bin/bash oracle -c "sqlplus / as sysdba @/u01/app/oracle/product/12.1.0.2/dbhome_1/rdbms/admin/catproc.sql"
#exit
#su -s /bin/bash oracle -c "sqlplus / as sysdba shutdown immediate"
fi

if [ "$1" == "StartOnly" ];then

su -s /bin/bash oracle -c "lsnrctl start"
su -s /bin/bash oracle -c "cp /opt/Utility/PFILE/init.ora /u01/app/oracle/product/12.1.0.2/dbhome_1/dbs/init.ora"
su -s /bin/bash oracle -c "cp /u01/app/oracle/product/12.1.0.2/dbhome_1/dbs/init.ora /u01/app/oracle/product/12.1.0.2/dbhome_1/dbs/initorcl.ora"
su -s /bin/bash oracle -c "sqlplus /nolog @/opt/Utility/scripts/StartDB.sql"
 
fi
    
su -l root
 
