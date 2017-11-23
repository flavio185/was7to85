#!/bin/bash
###########
#1 - vim httpd.conf - Alterar LoadModule no httpd.conf pra apontar pra was8 e 64bits
#LoadModule was_ap22_module "/opt/WebSphere7/IHS/Plugins/bin/32bits/mod_was_ap22_http.so"
#por
#LoadModule was_ap22_module "/opt/WebSphere8.5.5/Plugins/bin/64bits/mod_was_ap22_http.so"

#################
sudo su - websphere -c '
echo "alterando loadmodule no httpd.conf"
if [ ! -f /opt/IHSCONF/$(hostname -s)/conf/httpd.conf_was7 ]
then
  echo "fazendo backup do httpd.conf"
  cp /opt/IHSCONF/$(hostname -s)/conf/httpd.conf /opt/IHSCONF/$(hostname -s)/conf/httpd.conf_was7
  sed -e '\''s/LoadModule was_ap22_module.*/LoadModule was_ap22_module \"\/opt\/WebSphere8\.5\.5\/Plugins\/bin\/64bits\/mod_was_ap22_http\.so\"/g'\'' -i /opt/IHSCONF/$(hostname -s)/conf/httpd.conf
  echo "finalizou o sed"
else
  echo "arquivo httpd.conf_was7 ja existe. segue parametro do arquivo corrente:"
  grep   mod_was_ap22_http.so /opt/IHSCONF/$(hostname -s)/conf/httpd.conf
  echo ""
fi



################
#2alterar script apachectl para apontar pra was8
# /opt/WebSphere7/IHS/bin/envvars por #/opt/WebSphere8.5.5/IHS/bin/envvars
#
echo "alterando script apacchectl"
if [ ! -f /opt/IHSCONF/$(hostname -s)/bin/apachectl_was7 ]
then
  cp /opt/IHSCONF/$(hostname -s)/bin/apachectl /opt/IHSCONF/$(hostname -s)/bin/apachectl_was7
  sed -e '\''s/WebSphere7/WebSphere8.5.5/g'\'' -i /opt/IHSCONF/$(hostname -s)/bin/apachectl 
  echo "finalizado sed de alteração"
  echo ""
else
  echo "arquivo apachectl_was7 ja existe. O parametro do apachectl no arquivo corrente é:"
  grep   WebSphere /opt/IHSCONF/$(hostname -s)/bin/apachectl
  echo ""
fi


###
#opt/WebSphere8.5.5/IHS/conf/admin.conf
#trocar @@AdminPort@@
#por 8008
porta=$(grep Listen /opt/WebSphere7/IHS/conf/admin.conf| grep -v \# | head -1 | awk '\''{print $2}'\'')
echo $porta
sed -e "s|@@AdminPort@@|${porta}|g" -i /opt/WebSphere8.5.5/IHS/conf/admin.conf

#Copiar admin.passwd antigo
echo "copiando admin.passwd antigo"
cp "/opt/WebSphere7/IHS/conf/admin.passwd" "/opt/WebSphere8.5.5/IHS/conf/admin.passwd"

echo "Com root alterar os serviçõs /etc/init.d/service.IHS.admin e /etc/init.d/service.IHS.$(hostname -s)"
echo "trocar ""
echo "export IHS_HOME=\"/opt/WebSphere7/IHS/\""
echo "por" 
echo "export IHS_HOME=\"/opt/WebSphere8.5.5/IHS/\"
'