# Oracle-12C-Docker-Container
-----I'm Documenting Docker Containers for Learning purpose not for Production Use------- <br>
-----Oracle 12C is property of Oracle and I'm not bundling or sharing Oracle 12c with this <br>

To build and run this Container Required Oracle 12c to be downloaded from Oracle website<br>

Useful links:<br>
Oracle12 Links:
1.Download Oracle 12c Installers [64bit]<br>
http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html <br>
2.Documentation for Oracle 12c<br>
http://docs.oracle.com/database/121/index.htm<br>
Docker Links:<br>
3.How to start with Docker:<br>
https://docs.docker.com/docker-for-mac/ <br>
https://www.docker.com/ <br>
4.Documentation: <br>
https://docs.docker.com/<br>
5.Perl link:<br>
https://dev.perl.org/perl5/news/2011/perl-5.14.1.html <br>
<br>
Instruction to Build & Run Container <br>
Here I'm expecting your familiar with Docker and know how to configure it, I'm only mentioning here how to Build the Image and prepare container from Newly created Docker Image.<br>
----Build Oracle 12c Docker Image---- <br>
Before started building Docker Image you have to setup python http server to host your Installers [refer the URL in Dockerfile] <br>
Oracle 12c also need perl for some fixes to recompile due to some internal issues with bundled installer.
1.Download Dockerfile from Repository <br>
2.create Directory <UserDefined Name> and copy Dockerfile in it <br>
3. open the shell and go to the directory and execute this command: <br>
   docker build -t oracle12c:stable . <br>
   wait for this command to finish and it should finished successfully.<br>

Run Docker 12c Container:<br>
Most of time when I used my playground I have to switch off the container when work was done but I also want to preserve the state if I want to work again with same DB so I created option to Build DB once and can be used many times.

container comes with two option:<br>
1.CreateDBOnly<br>
docker run -v /Users/amit/Docker/Oracle12c/Utility:/opt/Utility:rw -v /Users/amit/Docker/Oracle12c/Plug_volume/adump:/u01/app/oracle/admin/orcl/adump:rw -v /Users/amit/Docker/Oracle12c/Plug_volume/fast_recovery_area:/u01/app/oracle/fast_recovery_area:rw -v /Users/amit/Docker/Oracle12c/Plug_volume/oradata:/u01/app/oracle/oradata:rw -t -iP --expose {portNo}  {Image-ID} /opt/Utility/scripts/Startup.sh CreateOnly <br>

2.StartDBOnly<br>
docker run -v /Users/amit/Docker/Oracle12c/Utility:/opt/Utility:rw -v /Users/amit/Docker/Oracle12c/Plug_volume/adump:/u01/app/oracle/admin/orcl/adump:rw -v /Users/amit/Docker/Oracle12c/Plug_volume/fast_recovery_area:/u01/app/oracle/fast_recovery_area:rw -v /Users/amit/Docker/Oracle12c/Plug_volume/oradata:/u01/app/oracle/oradata:rw -t -iP --expose {portNo}  {Image-ID} /opt/Utility/scripts/Startup.sh StartOnly <br>



These two flag need to be configured while running New Container<br>
1. if there is not exisiting Oracle DB we need to create DB first you can change the existing CreateDB.sql to change Database as per your need. <br>
2. State of Oracle12c database is stored on docker volumes locally on host Mac so before starting docker container with CreateDBonly we need to create couple of directories. <br>
<br>
3.To Start again the existing Oracle12c database using StartDBonly, make sure you have directories which was created during CreateDB.








