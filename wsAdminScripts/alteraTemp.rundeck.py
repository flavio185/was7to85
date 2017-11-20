cat <<EOF >/var/tmp/alteraTemp.py
servers = AdminConfig.list( 'ServerEntry' ).splitlines()
servers.sort()
cname = AdminControl.getCell()
webservers = AdminConfig.list('WebServer').split('(')[0].splitlines()

for aServer in servers:
	for web in webservers:
		if aServer.find( web ) != 0:
			sname = aServer[0:aServer.find("(")] ###Pega o nome do servidor
			#print sname
			nname = aServer[aServer.find("nodes/")+6:aServer.find("|serverindex")] ###Pega o nome do node
			#print nname
			sid = AdminConfig.getid("/Node:"+nname+"/Server:"+sname)
			jvm = AdminConfig.list('JavaVirtualMachine', sid)
			property = AdminConfig.list('Property', jvm).split()
			root_dir = 0
			temp_dir = 0
			#print "aServer: ",aServer
			#print "sname: ",sname
			#print "nname: ",nname
			#print "sid: ",sid
			#print "jvm: ",jvm
			#print "property: ",property
			print ""
				
			for p in property:
				if p.find("was.repository.temp") == 0:
					#print p.split('(')[1]
					print "modificado propriedade was.repository.temp em ",sname
					AdminConfig.modify(p, '[[validationExpression ""] [name "was.repository.temp"] [description ""] [value "/opt/WebSphere8.5.5/AppServer/tmp"] [required "false"]]')
					#AdminConfig.show(p)
					temp_dir = 1
				#EndIf
				if p.find("websphere.workspace.root") == 0:
					#print p.split('(')[1]
					print "modificado propriedade websphere.workspace.rootem ",sname
					AdminConfig.modify(p, '[[validationExpression ""] [name "websphere.workspace.root"] [description ""] [value "/opt/WebSphere8.5.5/AppServer/wstemp"] [required "false"]]')
					#AdminConfig.show(p)
					root_dir = 1
				#EndIf
			#EndFor
			
			if temp_dir == 0:
				print "Adicionando propriedade was.repository.temp ",sname
				AdminConfig.create('Property', jvm, '[[validationExpression ""] [name "was.repository.temp"] [description ""] [value "/opt/WebSphere8.5.5/AppServer/tmp"] [required "false"]]')
				#AdminConfig.create('Property', '(cells/wasibeivlbr12Cell01/nodes/wasibeivlbr11.bs.br.bschNode/servers/apps_wasibeivlbr11_bkso_01|server.xml#JavaVirtualMachine_1460051907275)', '[[validationExpression ""] [name "was.repository.temp"] [description ""] [value "/opt/WebSphere8.5.5/AppServer/tmp"] [required "false"]]')
			#EndIf
			
			if root_dir == 0:
				print "Adicionando propriedade websphere.workspace.root em ",sname
				AdminConfig.create('Property', jvm, '[[validationExpression ""] [name "websphere.workspace.root"] [description ""] [value "/opt/WebSphere8.5.5/AppServer/wstemp"] [required "false"]]')
			#EndIf    

    #EndIf

  #EndFor
  
#EndFor
AdminConfig.save()

EOF

chmod 777 /var/tmp/alteraTemp.py

sudo su - websphere -c "
  /opt/WebSphere8.5.5/AppServer/profiles/Dmgr01/bin/wsadmin.sh -lang jython -f /var/tmp/alteraTemp.py
"

rm -rf /var/tmp/alteraTemp.py

""
