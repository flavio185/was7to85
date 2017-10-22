for app in AdminApp.list().split():
	try:
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
	except:
		continue
	print('\n')

