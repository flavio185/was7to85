cat <<EOF >/var/tmp/removeJVMArgs.py
import re

server = AdminTask.listServers()
servers = AdminUtilities.convertToList(server)
webservers = AdminConfig.list('WebServer').split('(')[0].splitlines()

#Aqui estão os argumentos que queremos remover do JVMArguments das jvms.
jvmArgs1="-Dwebsphere.workspace.root=/opt/WebSphere7/AppServer/wstemp"
jvmArgs2="-Dcom.ibm.websphere.servlet.temp.dir=/opt/WebSphere7/tmpjsp"
jvmArgs3="-Dwebsphere.workspace.root=/opt/WebSphere8.5.5/AppServer/wstemp"
jvmArgs4="-Dcom.ibm.websphere.servlet.temp.dir=/opt/WebSphere8.5.5/tmpjsp"
parametro=[]
parametro.append(jvmArgs1)
parametro.append(jvmArgs2)
parametro.append(jvmArgs3)
parametro.append(jvmArgs4)
for aServer in servers:
  for web in webservers:
    try:
        if aServer.find("dmgr") != 0 and aServer.find("nodeagent") != 0 and aServer.find( web ) != 0:
            sname = aServer[0:aServer.find("(")]
            nname = aServer[aServer.find("nodes/")+6:aServer.find("servers/")-1]
            sid = AdminConfig.getid("/Node:"+nname+"/Server:"+sname)
            jvm = AdminConfig.list('JavaVirtualMachine', sid)
            jvmArgs = AdminConfig.showAttribute(jvm, 'genericJvmArguments ')
            listJvmArgs = jvmArgs.split()
            #print sname,jvmArgs
            #print "antes"
            for param in parametro:
                try:
                    del listJvmArgs[listJvmArgs.index(param)]
                    print "INFO: Parametro ",param,"removido do appserver ",sname
                except:
                    continue#print "erro ao tentar remover",param   
            #EndFor                 
            jvmArgs = " ".join(listJvmArgs)
            AdminConfig.modify( jvm, [[ 'genericJvmArguments', jvmArgs ]] )
            #print sname, jvmArgs
            #print "depois"
        #EndIf
    except:
        print "ERRO: erro ao tentar remover"
    #EndFor
#EndFor

AdminConfig.save()
EOF

chmod 777 /var/tmp/removeJVMArgs.py

sudo su - websphere -c "
  /opt/WebSphere8.5.5/AppServer/profiles/Dmgr01/bin/wsadmin.sh -lang jython -f /var/tmp/removeJVMArgs.py
"

rm -rf /var/tmp/removeJVMArgs.py