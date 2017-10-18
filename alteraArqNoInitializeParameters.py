for app in AdminApp.list().split():
	try:
		newArq=""
		librs=AdminApp.view(app, '[ -MapSharedLibForMod [[ ]]]' ).split('\n')    
		for lib in librs:
			if lib.startswith('Module:  ') and not lib.endswith('ESCE'):
				print('aplicacao: '+ lib[7:] + ' ; ')
			if lib.startswith('Shared Libraries:'):
				libraries = lib[19:]
				libs = libraries.split('+')
				for library in libs:
					if len(library) != 0:
						if not library.startswith('WebSphere:name=API') and not library.startswith('WebSphere:name=ALTAIR')  and not library.startswith('WebSphere:name=AppLibs_SL') and not library.startswith('WebSphere:name=LibreriaArq'):
							libraryTT = library[15:].split(',')
					        print('Arquitetura: '+libraryTT[0]+';')
					        newArq=libraryTT[0].split("_")[2]
                        if lib.endswith('web.xml'):
                            print lib
                            newArq=libraryTT[0].split("_")[2]#print(libraryTT[0].split("_")[2])
                            modweb=lib[5:]
                            esce = modweb.split('.')[0]
                            hash = esce + modweb
                            print('AdminApp.edit(\'%s\',\'[ -MapInitParamForServlet [[ %s RigelBootStrapServlet bootStrapEncryptConfig null file:/ArquitecturaE-business/Xml/CfgRigel%s/gaia/ConfigurationManager.xml ][ %s RigelBootStrapServlet urlConfig null file:/ArquitecturaE-business/Xml/CfgRigel%s/gaia/kernel.xml ][ %s RigelBootStrapServlet variableConfigPath null /ArquitecturaE-business/Xml/CfgRigel%s/RigelJars_Configuration ]]]\')\n' %(app,hash,newArq,hash,newArq,hash,newArq))
                            #AdminApp.edit(app, '[ -MapInitParamForServlet [[ '+hash+' RigelBootStrapServlet bootStrapEncryptConfig null file:/ArquitecturaE-business/Xml/CfgRigel'+newArq+'/gaia/ConfigurationManager.xml ][ '+hash+' RigelBootStrapServlet urlConfig null file:/ArquitecturaE-business/Xml/CfgRigel'+newArq+'/gaia/kernel.xml ][ '+hash+' RigelBootStrapServlet variableConfigPath null /ArquitecturaE-business/Xml/CfgRigel'+newArq+'/RigelJars_Configuration ]]]') 
                            print('aplicativo sera atualizado: %s'%hash)   
                            print('')   
	except:
		continue
