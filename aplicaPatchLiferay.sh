#Favor seguir procedimento atentando aos comentários.
#Devemos instalar o mesmo patch instalado no was7
/opt/LR/LifeRay_6.1.20_EE/patching-tool/patching-tool.sh info
#verifica versão instalada was7. 
#Verifica se versão está em :
ll /opt/LR/LifeRay_6.1.20_EE/patching-tool/patches | grep 6120

cd /opt/LR/LifeRay_6.1.20_EE/patching-tool/
cp default.properties default.properties_was7

####sed pega WebSphere7 e transforma WebSphere8.5.5
#alterar arquivo, tudo que é WebSphere7 vira WebSphere8.5.5
vim /opt/LR/LifeRay_6.1.20_EE/patching-tool/default.properties

#Instala versão instalada anteriormente no was7 (confirmar que .zip correto está no diretório patches, que o default.properties está apontando)
/opt/LR/LifeRay_6.1.20_EE/patching-tool/patching-tool.sh install

/opt/LR/LifeRay_6.1.20_EE/patching-tool/patching-tool.sh info
#verifica versão instalada was8 (comparar com was7). 