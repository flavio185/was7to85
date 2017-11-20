###---Adicionar serviço automático-----
###precisa adicionar no sudo.
#Add Dmgr
/opt/WebSphere8.5.5/AppServer/bin/wasservice.sh -add dmgr -serverName dmgr -profilePath /opt/WebSphere8.5.5/AppServer/profiles/Dmgr01/ -userid websphere 
#Add Node
/opt/WebSphere8.5.5/AppServer/bin/wasservice.sh -add nodeagent -serverName nodeagent -profilePath /opt/WebSphere8.5.5/AppServer/profiles/Node01/ -userid websphere 