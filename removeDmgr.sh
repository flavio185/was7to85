sudo su - websphere -c "
  /opt/WebSphere8.5.5/AppServer/bin/manageprofiles.sh -delete -profileName Dmgr01
  rm -rf /opt/WebSphere8.5.5/AppServer/profiles/Dmgr01
  /opt/WebSphere8.5.5/AppServer/bin/manageprofiles.sh -validateAndUpdateRegistry
"