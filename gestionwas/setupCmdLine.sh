+ trap clean_up EXIT SIGQUIT SIGKILL SIGTERM
++ /bin/cat /opt/gestionWAS/version.txt
++ /bin/head -n 1
++ /bin/cut -d ' ' -f 2
+ export version=3.0
+ version=3.0
++ uname -a
+ OSNAME='Linux washppvlbr81.bs.br.bsch 2.6.32-573.45.1.el6.x86_64 #1 SMP Mon Jul 10 06:18:45 EDT 2017 x86_64 x86_64 x86_64 GNU/Linux'
+ test 'Linux washppvlbr81.bs.br.bsch 2.6.32-573.45.1.el6.x86_64 #1 SMP Mon Jul 10 06:18:45 EDT 2017 x86_64 x86_64 x86_64 GNU/Linux'
++ uname -a
++ grep CYGWIN
+ OSNAME=
+ test ''
+ export OS_TYPE=UNIX
+ OS_TYPE=UNIX
+ export OS_TYPE
+ '[' UNIX = WINDOWS ']'
+ export IHS_HOME=/opt/IHSCONF
+ IHS_HOME=/opt/IHSCONF
+ export WAS7_HOME=/opt/WebSphere7/AppServer
+ WAS7_HOME=/opt/WebSphere7/AppServer
+ export WAS85_HOME=/opt/WebSphere8.5.5/AppServer
+ WAS85_HOME=/opt/WebSphere8.5.5/AppServer
+ export JAVA_HOME=/opt/gestionWAS/java/java
+ JAVA_HOME=/opt/gestionWAS/java/java
+ export BANKSPHERE_HOME=/ArquitecturaE-business
+ BANKSPHERE_HOME=/ArquitecturaE-business
+ export SCRIPTS_HOME==/opt/gestionWAS/scripts
+ SCRIPTS_HOME==/opt/gestionWAS/scripts
+ export backupPath=/opt/gestionWAS/backups
+ backupPath=/opt/gestionWAS/backups
++ uname -a
+ OSNAME='Linux washppvlbr81.bs.br.bsch 2.6.32-573.45.1.el6.x86_64 #1 SMP Mon Jul 10 06:18:45 EDT 2017 x86_64 x86_64 x86_64 GNU/Linux'
++ echo Linux washppvlbr81.bs.br.bsch 2.6.32-573.45.1.el6.x86_64 '#1' SMP Mon Jul 10 06:18:45 EDT 2017 x86_64 x86_64 x86_64 GNU/Linux
++ grep AIX
+ AIX=
++ echo Linux washppvlbr81.bs.br.bsch 2.6.32-573.45.1.el6.x86_64 '#1' SMP Mon Jul 10 06:18:45 EDT 2017 x86_64 x86_64 x86_64 GNU/Linux
++ grep SunOS
+ SOLARIS=
++ echo Linux washppvlbr81.bs.br.bsch 2.6.32-573.45.1.el6.x86_64 '#1' SMP Mon Jul 10 06:18:45 EDT 2017 x86_64 x86_64 x86_64 GNU/Linux
++ grep Linux
+ LINUX='Linux washppvlbr81.bs.br.bsch 2.6.32-573.45.1.el6.x86_64 #1 SMP Mon Jul 10 06:18:45 EDT 2017 x86_64 x86_64 x86_64 GNU/Linux'
+ test ''
+ test ''
+ test 'Linux washppvlbr81.bs.br.bsch 2.6.32-573.45.1.el6.x86_64 #1 SMP Mon Jul 10 06:18:45 EDT 2017 x86_64 x86_64 x86_64 GNU/Linux'
+ export UNIX_NAME=LINUX
+ UNIX_NAME=LINUX
+ export gestionWAS_USER=websphere
+ gestionWAS_USER=websphere
+ '[' -f /opt/gestionWAS/localscripts/private/setupCmdLine.sh ']'
+ . /opt/gestionWAS/localscripts/private/setupCmdLine.sh
++ export mailTO=to@changeit.com
++ mailTO=to@changeit.com
++ export mailCC=cc@changeit.com
++ mailCC=cc@changeit.com
++ export http_proxy=
++ http_proxy=
++ export https_proxy=
++ https_proxy=
+ clean_up
+ '[' -d '' ']'
+ return 1
