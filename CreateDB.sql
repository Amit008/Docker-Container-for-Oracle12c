connect / as sysdba

create spfile from pfile;

startup nomount;

CREATE DATABASE orcl
   USER SYS IDENTIFIED BY system
   USER SYSTEM IDENTIFIED BY system
   LOGFILE GROUP 1 ('/u01/app/oracle/oradata/orcl/redo01a.log','/u01/app/oracle/oradata/orcl/redo01b.log') SIZE 100M BLOCKSIZE 512,
           GROUP 2 ('/u01/app/oracle/oradata/orcl/redo02a.log','/u01/app/oracle/oradata/orcl/redo02b.log') SIZE 100M BLOCKSIZE 512,
           GROUP 3 ('/u01/app/oracle/oradata/orcl/redo03a.log','/u01/app/oracle/oradata/orcl/redo03b.log') SIZE 100M BLOCKSIZE 512
   MAXLOGHISTORY 1
   MAXLOGFILES 16
   MAXLOGMEMBERS 3
   MAXDATAFILES 1024
   CHARACTER SET AL32UTF8
   NATIONAL CHARACTER SET AL16UTF16
   EXTENT MANAGEMENT LOCAL
   DATAFILE '/u01/app/oracle/oradata/orcl/system01.dbf'
     SIZE 700M REUSE AUTOEXTEND ON NEXT 10240K MAXSIZE UNLIMITED
   SYSAUX DATAFILE '/u01/app/oracle/oradata/orcl/sysaux01.dbf'
     SIZE 550M REUSE AUTOEXTEND ON NEXT 10240K MAXSIZE UNLIMITED
   DEFAULT TABLESPACE users
      DATAFILE '/u01/app/oracle/oradata/orcl/users01.dbf'
      SIZE 500M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED
   DEFAULT TEMPORARY TABLESPACE tempts1
      TEMPFILE '/u01/app/oracle/oradata/orcl/temp01.dbf'
      SIZE 20M REUSE AUTOEXTEND ON NEXT 640K MAXSIZE UNLIMITED
   UNDO TABLESPACE undotbs1
      DATAFILE '/u01/app/oracle/oradata/orcl/undotbs01.dbf'
      SIZE 200M REUSE AUTOEXTEND ON NEXT 5120K MAXSIZE UNLIMITED
   USER_DATA TABLESPACE usertbs
      DATAFILE '/u01/app/oracle/oradata/orcl/usertbs01.dbf'
      SIZE 200M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED;

@?/rdbms/admin/catalog.sql
@?/rdbms/admin/catproc.sql
@?/rdbms/admin/utlrp.sql

connect / as system
@?/sqlplus/admin/pupbld.sql


shutdown immediate;
startup
alter system set LOCAL_LISTENER='(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521))' scope=both;
alter system register;

exit

