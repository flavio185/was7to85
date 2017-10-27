###---Adicionar serviço automático-----
###precisa adicionar no sudo.
cd /opt/WebSphere8.5.5/AppServer/bin
#Add Dmgr
./wasservice.sh -add dmgr -serverName dmgr -profilePath /opt/WebSphere8.5.5/AppServer/profiles/Dmgr01/ -userid websphere 
#Add Node
./wasservice.sh -add nodeagent -serverName nodeagent -profilePath /opt/WebSphere8.5.5/AppServer/profiles/Node01/ -userid websphere 