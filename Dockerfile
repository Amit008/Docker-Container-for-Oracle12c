###Dockerfile
#################################################################
#############Installing Operating System#########################
FROM centos
RUN yum -y install unzip;yum install -y make;yum install -y gcc;yum install -y cc;yum install -y libstdc++;yum install -y libstdc++.i686 -y;yum install -y libstdc++-devel;yum install -y libstdc++-devel.i686;yum install -y libaio;yum install -y libaio.i686;yum install -y libaio-devel;yum install -y libaio-devel.i686;groupadd -g 54321 oinstall;groupadd -g 54322 dba;groupadd -g 54323 oper;groupadd -g 54327 asmdba;groupadd -g 54328 asmoper;groupadd -g 54329 asmadmin;useradd -G oinstall,dba,asmdba oracle;mkdir -p /u01/app/oracle/product/12.1.0.2/dbhome_1;mkdir -p /u01/app/oraInventory;mkdir -p /tmp/oracle;chown -R oracle:oracle /tmp/oracle;mkdir -p /opt/perl;chown -R oracle:oracle /opt/perl;chmod 775 /opt/perl;chown -R oracle:oinstall /u01;chmod 755 /u01


COPY db_install.rsp /tmp/db_install.rsp
#COPY dbca.rsp /tmp/dbca.rsp
COPY listener.ora /tmp/listener.ora
#COPY scripts/Startup.sh /opt/scripts/Startup.sh
#COPY scripts/startdb.sql /opt/scripts/startdb.sql

#####Check Packages are Installed Specific to oracle###########

ENV ORACLE_HOME=/u01/app/oracle/product/12.1.0.2/dbhome_1
ENV ORACLE_SID=orcl
ENV PATH=$PATH:$ORACLE_HOME/bin

USER root
RUN chown -R oracle:oracle /tmp/*

USER oracle


RUN curl http://<Ipaddress>:<PortNo>/linuxamd64_12102_database_1of2.zip --create-dirs -o /tmp/linuxamd64_12102_database_1of2.zip;curl http://<Ipaddress>:<PortNo>/linuxamd64_12102_database_2of2.zip --create-dirs -o /tmp/linuxamd64_12102_database_2of2.zip;unzip /tmp/linuxamd64_12102_database_1of2.zip -d /tmp/oracle;unzip /tmp/linuxamd64_12102_database_2of2.zip -d /tmp/oracle;curl http://<Ipaddress>:<PortNo>/perl-5.14.1.tar.gz --create-dirs -o /tmp/perl-5.14.1.tar.gz;tar -xvzf /tmp/perl-5.14.1.tar.gz -C /opt/perl --strip-components=1;rm -rf /tmp/linuxamd64_12102_database_1of2.zip;rm -rf /tmp/linuxamd64_12102_database_2of2.zip;rm -rf /tmp/perl-5.14.1.tar.gz;cd /tmp/oracle/database;./runInstaller -silent -force -waitforcompletion -responseFile /tmp/db_install.rsp -ignoresysprereqs -ignoreprereq;netca -silent -responseFile /tmp/oracle/database/response/netca.rsp;rm -rf /tmp/CVU_12.1.0.2.0_oracle;rm -rf /tmp/hsperfdata_oracle;rm -rf /tmp/oracle

USER root

RUN cd /u01/app/oraInventory;./orainstRoot.sh;cd /u01/app/oracle/product/12.1.0.2/dbhome_1;./root.sh;echo "ORACLE_HOME=/u01/app/oracle/product/12.1.0.2/dbhome_1" >> /home/oracle/.bash_profile;echo "ORACLE_SID=orcl" >> /home/oracle/.bash_profile;echo "export ORACLE_HOME">> /home/oracle/.bash_profile;echo "export ORACLE_SID" >> /home/oracle/.bash_profile;echo "export PATH=$PATH:$ORACLE_HOME/bin" >> /home/oracle/.bash_profile;chown -R oracle:oracle /tmp/listener.ora;chmod 755 /tmp/listener.ora;

USER oracle

RUN lsnrctl stop LISTENER;cp /u01/app/oracle/product/12.1.0.2/dbhome_1/javavm/jdk/jdk6/lib/libjavavm12.a /u01/app/oracle/product/12.1.0.2/dbhome_1/lib/;cd /u01/app/oracle/product/12.1.0.2/dbhome_1/rdbms/lib;mv config.o config.o.bad;cd $ORACLE_HOME/rdbms/lib;make -f ins_rdbms.mk install;cd $ORACEL_HOME/bin;relink all;cd /opt/perl;./Configure -des -Dprefix=$ORACLE_HOME/perl -Doptimize=-O3 -Dusethreads -Duseithreads -Duserelocatableinc;make clean;make;make install;cp /tmp/listener.ora /u01/app/oracle/product/12.1.0.2/dbhome_1/network/admin/;lsnrctl start LISTENER

USER root
RUN rm -rf /tmp/*;rm -rf /opt/perl
