#criado 
$gestionWAS_HOME="/opt/gestionWAS"
$gestionWAS_HOME/localscripts/private/was85
$gestionWAS_HOME/localconfig/private/was85
$gestionWAS_HOME/scripts/private/was85
$gestionWAS_HOME/tmp/was85
$gestionWAS_HOME/bin/setupCmdLine.sh_was85

#altera conteudo de was7 pra was85
/opt/gestionWAS/localscripts/private/housekeeping
$gestionWAS_HOME/localscripts/private/was85
$gestionWAS_HOME/localconfig/private/was85
$gestionWAS_HOME/scripts/private/was85
/opt/gestionWAS/bin/
/opt/gestionWAS/scripts/private/housekeeping/was
    for i in $(ls); do sed -i s/was7/was85/g $i; done
    for i in $(ls); do sed -i s/WAS7/WAS85/g $i; done
    for i in $(ls); do sed -i s/WebSphere7/WebSphere8.5.5/g $i; done
    for i in $(ls); do sed -i s/\"v7\"/\"v85\"/g $i; done

/opt/gestionWAS/scripts/private/was85

#Adicionado linhas was8
$gestionWAS_HOME/bin/setupCmdLine.sh

/opt/gestionWAS/scripts/private/was85was_startupScripts.sh
export WAS_ID="v85"

#Alterar pra was8.5
 /opt/gestionWAS/localconfig/private/housekeeping/housekeeping.conf
 /opt/gestionWAS/scripts/private/housekeeping/package.descriptor
/opt/gestionWAS/scripts/private/was85/