#!/bin/bash
#altera propriedade do plugin para não precisar usar o ssl.
#StrictSecurity="false" UseInsecure="true"
#
#
#encontra plugin file
pluginFile=$(grep plugin-cfg.xml "/opt/IHSCONF/$(hostname -s)/conf/httpd.conf" | grep -v \#| cut -d" " -f 2)

##########
#Faz backup do arquivo.
if [ -f $pluginFile"_was7" ]
then
  echo "plugin_was7 existe"
  cp $pluginFile $pluginFile"_was7_"$(date +'%N')
else
  echo "plugin_was7 n existe"
  cp $pluginFile $pluginFile"_was7"
fi
#
#################

##gera array
arrayPlugin=(`grep "<Config" $pluginFile |grep -v \#`)

#########
#Adiciona/Altera StrictSecurity
#
#Tamanho da array
lenghtArray=${#arrayPlugin[@]}
#Pega o ultimo elemento da array.
lastElement=${arrayPlugin[lenghtArray-1]}
########
#subistitue valores se ja existem.
#
param1='StrictSecurity="false"' 
if [[ `echo ${arrayPlugin[@]}| grep "StrictSecurity"` ]]
then
  echo "parametro existe. altere."
  echo ${arrayPlugin[@]/StrictSecurity*/$param1}
else 
  echo "parametro não existe. inclua."
  #tira o ultimo parametro para não perder o ">"
  unset arrayPlugin[lenghtArray-1]
  #adiciona parametro e ultimo elemento.
  arrayPlugin=("${arrayPlugin[@]}" $param1 $lastElement)
fi

#########
#Adiciona/Altera UseInsecure
#
#Tamanho da array
lenghtArray=${#arrayPlugin[@]}
#Pega o ultimo elemento da array.
lastElement=${arrayPlugin[lenghtArray-1]}
########
#subistitue valores se ja existem.
#
param2='UseInsecure="true"'
if [[ `echo ${arrayPlugin[@]}| grep "UseInsecure"` ]]
then
  echo "parametro existe. altere."
  echo ${arrayPlugin[@]/UseInsecure*/$param2}
else 
  echo "parametro não existe. inclua."
  #tira o ultimo parametro para não perder o ">"
  unset arrayPlugin[lenghtArray-1]
  #adiciona parametro e ultimo elemento.
  arrayPlugin=("${arrayPlugin[@]}" $param2 $lastElement)
fi

#transforma array em variavel, pq fica mais facil de colocar no sed.
novoValor=${arrayPlugin[@]}

#altera plugin.
sed -e "s|<Config.*|${novoValor}|g" -i $pluginFile
sed -e "s|/WebSphere7/IHS/Plugins|/WebSphere8.5.5/Plugins|g" -i $pluginFile


#Fim
###########
