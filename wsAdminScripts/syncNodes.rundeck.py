#Copia de drivers bks.
# echo "copiando arquivos de /opt/WebSphere7/AppServer/Drivers_Bks para /opt/WebSphere8.5.5/AppServer/"
sudo su - websphere -c '
AdminNodeManagement.syncActiveNodes()

echo "copiado"


