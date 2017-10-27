#Copia de drivers bks e jdbc.
sudo su - websphere -c '

if [[ -d /opt/WebSphere7/AppServer/Drivers_Bks ]]; then
  echo "copiando arquivos de /opt/WebSphere7/AppServer/Drivers_Bks para /opt/WebSphere8.5.5/AppServer/"
  cp -r /opt/WebSphere7/AppServer/Drivers_Bks /opt/WebSphere8.5.5/AppServer/ &&
  echo "copiado DriversBKS"
else
  echo "/opt/WebSphere7/AppServer/Drivers_Bks não existe no servidor."
fi

if [[ -d /opt/WebSphere7/jdbc ]]; then
  echo "copiando arquivos de /opt/WebSphere7/jdbc /opt/WebSphere8.5.5"
  cp -r /opt/WebSphere7/jdbc /opt/WebSphere8.5.5 &&
  echo "copiado Drives jdbc"
else
  echo "/opt/WebSphere7/jdbc não existe no servidor."
fi

'
