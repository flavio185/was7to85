PROFILE=@option.PROFILE@
if [[ $PROFILE == "Dmgr01" ]] 
then
  echo "Removendo dmgr."
  sudo su - websphere -c "
    /opt/WebSphere8.5.5/AppServer/bin/manageprofiles.sh -delete -profileName Dmgr01
    rm -rf /opt/WebSphere8.5.5/AppServer/profiles/Dmgr01
    /opt/WebSphere8.5.5/AppServer/bin/manageprofiles.sh -validateAndUpdateRegistry
  "
  echo "Dmgr removido."
else
  echo "Removendo node."
  sudo su - websphere -c "
    /opt/WebSphere8.5.5/AppServer/bin/manageprofiles.sh -delete -profileName Node01
    rm -rf /opt/WebSphere8.5.5/AppServer/profiles/Node01
    /opt/WebSphere8.5.5/AppServer/bin/manageprofiles.sh -validateAndUpdateRegistry
  "
  echo "Node removido"
fi 