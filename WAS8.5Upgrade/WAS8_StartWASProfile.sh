#Script para iniciar nodeagent ou dmgr.
#JOBNAME: WAS8_StartWASProfile
#Options: WAS_PROFILE: Dmgr01,Node01

if [[ @option.WAS_PROFILE@ == "Dmgr01" ]]; then
  echo "Iniciando Dmgr"
  sudo su - websphere -c '/opt/WebSphere8.5.5/AppServer/profiles/Dmgr01/bin/startManager.sh'
else
  echo "Iniciando nodeagent"
  sudo su - websphere -c '/opt/WebSphere8.5.5/AppServer/profiles/Node01/bin/startNode.sh'

fi