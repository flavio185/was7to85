#!/bin/bash
##Instalação do IHS
##Após copiar o agent.....zip para o destino/var/tmp
###Adicionar step que verifica se file system existe, se não ja para logo.
export INSTALADOR=${option.INSTALADOR}

sudo su - websphere -c 
mkdir -p /opt/WebSphere8.5.5/IM

rm -rf /opt/WebSphere8.5.5/InstallationManager

if [[ $INSTALADOR == "Sim" ]]; then
  #baixa instalador .zip.
  rm -rf /opt/WebSphere8.5.5/IM/* 
  svn export --username x158291 --password x158291 http://wasbkspvwbr05.bs.br.bsch:9090/svn/SCRIPTS/websphere/WAS8/agent.installer.linux.gtk.x86_64_1.8.5000.20160506_1125.zip /opt/WebSphere8.5.5/IM/agent.installer.linux.gtk.x86_64_1.8.5000.20160506_1125.zip --force --no-auth-cache 
fi
cd /opt/WebSphere8.5.5/IM 
unzip agent.installer.linux.gtk.x86_64_1.8.5000.20160506_1125.zip 
#altera installxml para o enviado por webwas.
cp install.xml_produban install.xml 
./userinstc -sP -log /tmp/im_log_install  -acceptLicense 
cd /opt/WebSphere8.5.5/InstallationManager/eclipse/tools 
#Install IHS
./imcl install com.ibm.websphere.IHS.v85_8.5.5011.20161206_1434 -repositories http://22.160.198.100/software/websphere/com.ibm.websphere.IHS.v85 -installationDirectory /opt/WebSphere8.5.5/IHS -acceptLicense -sP -sharedResourcesDirectory /opt/WebSphere8.5.5/InstallationManager/IMShared -preferences com.ibm.cic.common.core.preferences.keepFetchedFiles=false,com.ibm.cic.common.core.preferences.preserveDownloadedArtifacts=false -properties user.ihs.httpPort=80,user.ihs.allowNonRootSilentInstall=true

#Install Plugin
cd /opt/WebSphere8.5.5/InstallationManager/eclipse/tools 
mkdir -p /opt/WebSphere8.5.5/Plugins
./imcl install com.ibm.websphere.PLG.v85_8.5.5011.20161206_1434 -repositories http://22.160.198.100/software/websphere/com.ibm.websphere.PLG.v85 -installationDirectory /opt/WebSphere8.5.5/Plugins -acceptLicense -sP -sharedResourcesDirectory /opt/WebSphere8.5.5/InstallationManager/IMShared -preferences com.ibm.cic.common.core.preferences.keepFetchedFiles=false,com.ibm.cic.common.core.preferences.preserveDownloadedArtifacts=false -properties core.feature=true,com.ibm.jre.6_64bit=true

#Como Root
#rm -rf /opt/IHS &&
#cd /opt/ &&
#ln -s /opt/WebSphere8.5.5/IHS IHS
##
