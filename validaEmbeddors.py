import sys
import re

hostname = "wasdwrivlbr04"
servers = AdminConfig.list( 'ServerEntry' ).splitlines()
servers.sort()
cname = AdminControl.getCell()

for aServer in servers:
    if aServer.find("web") == -1 and aServer.find("dmgr") == -1 and aServer.find("nodeagent") == -1 and aServer.find("IHS") == -1:
        if re.search(hostname, aServer):
            sname = aServer[0:aServer.find("(")] ###Pega o nome do servidor
            #print sname
            nname = aServer[aServer.find("nodes/")+6:aServer.find("|serverindex")] ###Pega o nome do node
            #print nname
            appList = AdminApp.list("WebSphere:cell="+cname+",node="+nname+",server="+sname+"")
            #print appList
            NamedEndPoints = AdminConfig.list('NamedEndPoint', aServer).split()
            #print NamedEndPoints
            for namedEndPoint in NamedEndPoints:
                endPointName = AdminConfig.showAttribute(namedEndPoint, "endPointName")
                #print endPointName
                endPoint = AdminConfig.showAttribute(namedEndPoint, "endPoint")
                if re.search(r'tcport', endPointName.lower()):
                    port = AdminConfig.showAttribute(endPoint, "port")
                    for app in appList.splitlines():
                        print "curl -vk --silent http://%s:%s/%s/Embeddor 2>&1| grep -i RUNNING" % (hostname, port, app)
                else:
                    pass
        else:
            pass
    else:
        pass


from lxml import html
import requests

with open('embeddors.txt', 'r') as f:
    arq = f.readlines()

for url in arq:
    if "http" in url:
      #print url  
      page = requests.get(url)
      tree = html.fromstring(page.content)
      embeddor = tree.xpath('//p/text()')
      print embeddor[1].split(":")[1]

f.closed