cat <<EOF >/var/tmp/addCustomPropWebDmgr.py
#rodar script no Dmgr
webservers = AdminConfig.list('WebServer').split()

for web in webservers:
    property = AdminConfig.list('Property', web).split()
    if property:
        for prop in property:
            if prop.find("UseInsecure") >= 0 :
                AdminConfig.modify(prop, '[[validationExpression ""] [name "UseInsecure"] [description ""] [value "true"] [required "false"]]')
                print "midificado ",prop
                AdminConfig.save()
            else:
                AdminConfig.create('Property', web, '[[validationExpression ""] [name "UseInsecure"] [description ""] [value "true"] [required "false"]]')
                print "adicionado ",AdminConfig.list('Property', web).split()
                AdminConfig.save()
    else:
        AdminConfig.create('Property', web, '[[validationExpression ""] [name "UseInsecure"] [description ""] [value "true"] [required "false"]]')
        print "adicionado ",AdminConfig.list('Property', web).split()
        AdminConfig.save()


      
    #EndIf

  #EndFor
  
#EndFor
AdminConfig.save()

EOF

chmod 777 /var/tmp/addCustomPropWebDmgr.py

sudo su - websphere -c "
  /opt/WebSphere8.5.5/AppServer/profiles/Dmgr01/bin/wsadmin.sh -lang jython -f /var/tmp/addCustomPropWebDmgr.py
"

rm -rf /var/tmp/addCustomPropWebDmgr.py
