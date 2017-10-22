if [[ $RD_OPTION_WAS_VERSION == "WebSphere7" ]]; then
  echo "Testando embeddors do WAS7"
elif [[ $RD_OPTION_WAS_VERSION == "WebSphere8.5.5" ]]; then
  echo "Testando embeddors do WAS8.5"
fi

cat <<EOF >/tmp/validaEmbeddors.py
import sys, re, urllib


#hostname = "wascicpvlbr25"
servers = AdminConfig.list( 'ServerEntry' ).splitlines()
servers.sort()
cname = AdminControl.getCell()

#arqapps = open('/home/websphere/embeddors.txt','w+')
#print('gerado o arquivo apps.py com todos os aplicativos desta infra com a configuracao de arquitetura %s' %arq)

for aServer in servers:
    if aServer.find("web") == -1 and aServer.find("dmgr") == -1 and aServer.find("nodeagent") == -1 and aServer.find("IHS") == -1:
        #if re.search(hostname, aServer):
        if aServer:
            sname = aServer[0:aServer.find("(")] ###Pega o nome do servidor
            #print sname
            nname = aServer[aServer.find("nodes/")+6:aServer.find("|serverindex")] ###Pega o nome do node
            ns=AdminConfig.getid("/Node:"+nname+"/")
            hostname = AdminConfig.showAttribute(ns,'hostName').split(".")[0]
            #print nname
            appList = AdminApp.list("WebSphere:cell="+cname+",node="+nname+",server="+sname+"")
            #print appList
            NamedEndPoints = AdminConfig.list('NamedEndPoint', aServer).split()
            #print NamedEndPoints
            for namedEndPoint in NamedEndPoints:
                endPointName = AdminConfig.showAttribute(namedEndPoint, "endPointName")
                #print endPointName
                endPoint = AdminConfig.showAttribute(namedEndPoint, "endPoint")
                #print endPoint
                if re.search(r'tcport', endPointName.lower()):
                    port = AdminConfig.showAttribute(endPoint, "port")
                    for app in appList.splitlines():
                        opener = urllib.FancyURLopener({})
                        #print sname, nname, app
                        #print ("http://%s:%s/%s/Embeddor" % (hostname, port, app))
                        if app.find("_JMX") > -1:
                            continue
                        if app.find("CCHERR_ENS") > -1 or app.find("MTCC_ENS") > -1:
                            app = app.split("_")[0]+"_ESCE"
                        try:
                          f = opener.open("http://%s:%s/%s/Embeddor" % (hostname, port, app))
                        except:
                          print ("KO \t http://%s:%s/%s/Embeddor \t Connection Refused" % (hostname, port, app))
                          continue
                        #
                        embeddor = f.read()
                        #print embeddor
                        if embeddor.find("Running") > -1 or embeddor.find("RUNNING") > -1 or  embeddor.find("running") > -1:
                          print ("OK \t http://%s:%s/%s/Embeddor \t Embeddor Running" % (hostname, port, app))
                        else:
                          print ("KO \t http://%s:%s/%s/Embeddor \t Embeddor Not Running" % (hostname, port, app))
EOF
chmod +x /tmp/validaEmbeddors.py

sudo su - websphere -c "
  /opt/$RD_OPTION_WAS_VERSION/AppServer/profiles/Dmgr01/bin/wsadmin.sh -lang jython -f /tmp/validaEmbeddors.py
"

rm -rf /tmp/validaEmbeddors.py