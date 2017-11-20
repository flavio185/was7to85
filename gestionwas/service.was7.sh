#!/bin/bash
# The next lines are for chkconfig on RedHat systems.
# chkconfig: 2345 98 02
# description: Starts and stops WebSphere Application Server \
#              instances. This service was created via the \
#              wasservice command.
###############################################################################
### How to use this script on SuSe
###############################################################################
### Copy this script to /etc/init.d
### execute insserv /etc/init.d/service.was7.rc.sh
### start service: service service.was7 start
### for more information use man
###############################################################################
### BEGIN INIT INFO
# The next lines are for chkconfig on SuSE systems.
# Provides: service.was7
# Required-Start: $network $syslog
# Required-Stop:
# Default-Start: 2 3 4 5
# Default-Stop: 0 6
# Short-Description: Starts and stops WebSphere Application Server instances
# Description: Starts and stops WebSphere Application Server instances
### END INIT INFO

export USER_SERVICE=websphere
export gestionWAS_HOME=/opt/gestionWAS
WAS_DIR_ID=was85

if [ ! -d "${gestionWAS_HOME}/scripts/private/${WAS_DIR_ID}" ]
then
   echo "ERROR: gestionWAS is not installed"
   exit 1
fi

. ${gestionWAS_HOME}/scripts/private/${WAS_DIR_ID}/startupScripts.sh

case "$1" in
'start')

  isDMGR=`grep -i "dmgr01" ${WAS_HOME}/properties/profileRegistry.xml`
  isNODE=`egrep -i "Node01" ${WAS_HOME}/properties/profileRegistry.xml`

  if test "$isDMGR"
  then
    if ! test "`ps auxww | grep $WAS_HOME/profiles/Dmgr01 | grep -v grep `"
    then
        su -c "${gestionWAS_HOME}/scripts/private/${WAS_DIR_ID}/manageWASservices.sh profilePath=${DMGR_PROFILE_PATH} command=start serverName=dmgr" $USER_SERVICE
    fi
  fi
  if test "$isNODE"
  then
    if ! test "`ps auxww | grep $WAS7_HOME/profiles/Node01 | grep -v grep`"
    then
        su -c "${gestionWAS_HOME}/scripts/private/${WAS_DIR_ID}/manageWASservices.sh profilePath=${NODE_PROFILE_PATH} command=start serverName=nodeagent" $USER_SERVICE
    fi
  fi
  ;;
'stop')
  isDMGR=`grep -i "dmgr01" ${WAS_HOME}/properties/profileRegistry.xml`
  isNODE=`egrep -i  "node01" ${WAS_HOME}/properties/profileRegistry.xml`

  if test "$isDMGR"
  then
    if test "`ps auxww | grep $WAS_HOME/profiles/Dmgr01`"
    then
        su -c "${gestionWAS_HOME}/scripts/private/${WAS_DIR_ID}/manageWASservices.sh profilePath=${DMGR_PROFILE_PATH} command=stop serverName=dmgr" $USER_SERVICE
    else
        echo "NOTE: Dmgr proccess is stopped"
    fi
  fi
  if test "$isNODE"
  then
    if test "`ps auxww | grep $WAS_HOME/profiles/Node01`"
    then
        su -c "${gestionWAS_HOME}/scripts/private/${WAS_DIR_ID}/manageWASservices.sh profilePath=${NODE_PROFILE_PATH} command=stop serverName=ALL" $USER_SERVICE
        su -c "${gestionWAS_HOME}/scripts/private/${WAS_DIR_ID}/manageWASservices.sh profilePath=${NODE_PROFILE_PATH} command=stop serverName=nodeagent" $USER_SERVICE
    else
        echo "NOTE: Node agent and app.servers are stopped"
    fi
  fi
  ;;

'status')
    ps -ef | egrep "${NODE_PROFILE_PATH}|${DMGR_PROFILE_PATH}"  | grep -v "grep"
  ;;

*) echo "Usage: $0 { start | stop | status}"
  ;;
esac

