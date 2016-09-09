connect / as sysdba
CREATE SPFILE FROM PFILE;
startup;
alter system set LOCAL_LISTENER='(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521))' scope=both;
alter system register;
exit
