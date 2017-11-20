
###########
#1 - vim httpd.conf - Alterar
#LoadModule was_ap22_module "/opt/WebSphere7/IHS/Plugins/bin/32bits/mod_was_ap22_http.so"
#por
#LoadModule was_ap22_module "/opt/WebSphere8.5.5/Plugins/bin/64bits/mod_was_ap22_http.so"

if [ ! -f /opt/IHSCONF/$(hostname -s)/conf/httpd.conf_was7 ]
then
  #echo "não existe"
  cp /opt/IHSCONF/$(hostname -s)/conf/httpd.conf /opt/IHSCONF/$(hostname -s)/conf/httpd.conf_was7
  sed -e '\''s/LoadModule was_ap22_module \"\/opt\/WebSphere7\/IHS\/Plugins\/bin\/32bits\/mod_was_ap22_http.so\"/LoadModule was_ap22_module \"\/opt\/WebSphere8\.5\.5\/Plugins\/bin\/64bits\/mod_was_ap22_http\.so\"/g'\'' -i /opt/IHSCONF/$(hostname -s)/conf/httpd.conf
  echo "finalizou o sed"
else
  echo "arquivo httpd.conf_was7 ja existe. O parametro do plugin no arquivo corrente é:"
  grep   mod_was_ap22_http.so /opt/IHSCONF/$(hostname -s)/conf/httpd.conf_was7
fi



################
#2alterar
# /opt/WebSphere7/IHS/bin/envvars por #/opt/WebSphere8.5.5/IHS/bin/envvars
#
if [ -! f /opt/IHSCONF/$(hostname -s)/bin/apachectl_was7 ]
then
  cp /opt/IHSCONF/$(hostname -s)/bin/apachectl /opt/IHSCONF/$(hostname -s)/bin/apachectl_was7
  sed -e '\''s/WebSphere7/WebSphere8.5.5/g'\'' -i /opt/IHSCONF/$(hostname -s)/bin/apachectl 
else
  echo "arquivo apachectl_was7 ja existe. O parametro do apachectl no arquivo corrente é:"
  grep   WebSphere /opt/IHSCONF/$(hostname -s)/bin/apachectl_was7
fi


###
#opt/WebSphere8.5.5/IHS/conf/admin.conf
#trocar @@AdminPort@@
#por 8008
#Copiar admin.passwd antigo

cp "/opt/WebSphere7/IHS/conf/admin.passwd" "/opt/WebSphere8.5.5/IHS/conf/admin.passwd"

#Com root alterar os serviçõs
#trocar 
#export IHS_HOME="/opt/WebSphere7/IHS/"
#por 
#export IHS_HOME="/opt/WebSphere8.5.5/IHS/"

#Alterar custom properties do plugin
#Servidores da Web > wasnmwdvlbr12 > Propriedades do Plug-in > Propriedades Customizadas > UseInsecure
#Nome: UseInsecure 
#valor: true

#Alterar Plugin
