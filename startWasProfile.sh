##Instalação do websphere
##Após copiar o agent.....zip para o destino/var/tmp
###Adicionar step que verifica se file system existe, se não ja para logo.

sudo su - websphere -c "
mkdir -p /opt/WebSphere8.5.5/IM
#baixa instalador.
rm -rf /opt/WebSphere8.5.5/IM/* 
rm -rf /opt/WebSphere8.5.5/InstallationManager/eclipse/tools 
svn export --username x158291 --password x158291 http://wasbkspvwbr05.bs.br.bsch:9090/svn/SCRIPTS/websphere/WAS8/agent.installer.linux.gtk.x86_64_1.8.5000.20160506_1125.zip /opt/WebSphere8.5.5/IM/agent.installer.linux.gtk.x86_64_1.8.5000.20160506_1125.zip --force --no-auth-cache 
cd /opt/WebSphere8.5.5/IM 
unzip agent.installer.linux.gtk.x86_64_1.8.5000.20160506_1125.zip 
#altera installxml para o enviado por webwas.
cp install.xml_produban install.xml 
./userinstc -sP -log /tmp/im_log_install  -acceptLicense 
cd /opt/WebSphere8.5.5/InstallationManager/eclipse/tools 
./imcl install com.ibm.websphere.ND.v85_8.5.5010.20160721_0036 -repositories http://22.160.198.100/software/websphere/com.ibm.websphere_.ND.v85 -installationDirectory /opt/WebSphere8.5.5/AppServer -acceptLicense -sP -sharedResourcesDirectory /opt/WebSphere8.5.5/InstallationManager/IMShared -preferences com.ibm.cic.common.core.preferences.keepFetchedFiles=false,com.ibm.cic.common.core.preferences.preserveDownloadedArtifacts=false
"
