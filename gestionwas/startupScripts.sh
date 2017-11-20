$gestionWAS_HOME/scripts/private/housekeeping/startupScripts.sh

#!/bin/sh -x
WAS7_HOME=""
wasID=""
DMGR_PROFILE_PATH=""
WSADMIN_JACL=""
NODE_PROFILE_PATH=""
WSADMIN=""
WAS_HOME=""
WAS_ID=""
#### I have to load the gestionWAS's main initial script
if test -n "$gestionWAS_HOME"
then
  . $gestionWAS_HOME/bin/setupCmdLine.sh
else
  echo "ERROR: environment variable gestionWAS_HOME is not defined"
  exit 1
fi

###
echo $WAS7_HOME
echo $wasID
echo $DMGR_PROFILE_PATH
echo $WSADMIN_JACL
echo $NODE_PROFILE_PATH
echo $WSADMIN
echo $WAS_HOME
echo $WAS_ID
###
if [ "$OS_TYPE" = "WINDOWS" ]
then
  export packageName="$(basename $(dirname $0))"
else
  export packageName="$(basename $(dirname $BASH_SOURCE))"
  echo $packageName
fi

source "$gestionWAS_HOME/scripts/private/${packageName}/package.descriptor"

export SCRIPT_PATH="$gestionWAS_HOME/scripts/private/${packageName}"

export SCRIPT_TMP="$gestionWAS_HOME/tmp/${packageName}"

#### I have to create or recreate the SCRIPT_TMP directory if it does not exist
if [ ! -d "$gestionWAS_HOME/tmp/${packageName}" ]
then
  mkdir "$gestionWAS_HOME/tmp/${packageName}"
else
  rm -Rf "$gestionWAS_HOME/tmp/${packageName}"
  mkdir "$gestionWAS_HOME/tmp/${packageName}"
fi

#Will trigger clean_up on EXIT or when receiving SIGQUIT, SIGKILL or SIGTERM
#trap "clean_up ${SCRIPT_TMP}" "SIGQUIT" "SIGILL" "SIGTERM" "SIGABRT" "SIGINT"

#### Validate if package is disabled
if [ "$disabled" = "true" ]
then
  showWarning "Package $packageName is disabled"
  exit 1
fi
#### If config directory doesn't exist I should create it
if [ ! -d "$packageConfigDirectory" ]
then
  mkdir -p "$packageConfigDirectory"
fi

echo "packageConfigDirectory" $packageConfigDirectory
#### If localscripts directory doesn't exist I should create it
if [ ! -d "$packageLocalScriptDirectory" ]
then
  mkdir -p "$packageLocalScriptDirectory"
fi

#### load properties for this package
if [ -f "$packageConfigFile" ]
then
   . "$packageConfigFile"
fi

#### I have to validate gestionWAS version
validateGestionWAS ${gestionWAS_min_version_supported}

#### I have to validate packages requisites
validatePackages ${gestionWAS_packages_requisites}

if [ $? != 0 ]
then
  exit 1
fi

#### I have to load localscripts properties
if [ -f "$packageLocalScriptDirectory/startupScripts.sh" ]
then
   . $packageLocalScriptDirectory/startupScripts.sh
fi

#################################
#### Custom code must be put here
#################################
