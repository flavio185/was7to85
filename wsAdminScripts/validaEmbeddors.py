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
                          #pass
                          #pass
                        #print embeddor
                        #arqapps.write( "curl -vk --silent http://%s:%s/%s/Embeddor 2>&1| grep -i RUNNING\n" % (hostname, port, app))
                else:
                    pass
        else:
            pass
    else:
        pass
#arqapps.close()

#import urllib
#opener = urllib.FancyURLopener({})
#f = opener.open("http://www.python.org/")
#f.read()


#from lxml import html
#import requests

#with open('embeddors.txt', 'r') as f:
#    arq = f.readlines()

#for url in arq:
#    if "http" in url:
#      #print url  
#      page = requests.get(url)
#      tree = html.fromstring(page.content)
#      embeddor = tree.xpath('//p/text()')
#      print url, embeddor[1].split(":")[1]

#f.closed