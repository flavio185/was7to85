cat <<EOF >/var/tmp/alteraTemp.py
servers = AdminConfig.list( 'ServerEntry' ).splitlines()
servers.sort()
cname = AdminControl.getCell()

for aServer in servers:
    if aServer.find("dmgr") == 0 or aServer.find("nodeagent") == 0:
            sname = aServer[0:aServer.find("(")] ###Pega o nome do servidor
            #print sname
            nname = aServer[aServer.find("nodes/")+6:aServer.find("|serverindex")] ###Pega o nome do node
            #print nname
            sid = AdminConfig.getid("/Node:"+nname+"/Server:"+sname)
            jvm = AdminConfig.list('JavaVirtualMachine', sid)
            property = AdminConfig.list('Property', jvm).split()
            for p in property:
              if p.find("was.repository.temp") == 0:
                #print p.split('(')[1]
                #print p
                AdminConfig.modify(p, '[[validationExpression ""] [name "was.repository.temp"] [description ""] [value "/opt/WebSphere8.5.5/AppServer/tmp"] [required "false"]]')
                AdminConfig.show(p)
              if p.find("websphere.workspace.root") == 0:
                #print p.split('(')[1]
                #print p
                AdminConfig.modify(p, '[[validationExpression ""] [name "websphere.workspace.root"] [description ""] [value "/opt/WebSphere8.5.5/AppServer/wstemp"] [required "false"]]')
                AdminConfig.show(p)
            

AdminConfig.save()
EOF

chmod 777 /var/tmp/alteraTemp.py

sudo su - websphere -c "
  /opt/WebSphere8.5.5/AppServer/profiles/Dmgr01/bin/wsadmin.sh -lang jython -f /var/tmp/alteraTemp.py
"

rm -rf /var/tmp/alteraTemp.py