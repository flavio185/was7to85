sudo su - websphere -c '
export hostname=$(hostname -s)
#export profileName=@option.PROFILE_NAME@
export cellName=@option.CELL_NAME@

if [[ -d /opt/WebSphere7/AppServer/profiles/Dmgr01 ]]; then
    if [[ -f /opt/WebSphere7/AppServer/profiles/Dmgr01/config/cells/$cellName/nodes/Dmgr01Node/serverindex.xml_PosMig ]]; then
        echo "Já existe backup do arquivo de configuração serverindex.xml_PosMig"
        echo "Provavelmente o was7 pode ser iniciado."
    elif [[ ! -f /opt/WebSphere7/AppServer/profiles/Dmgr01/config/cells/$cellName/nodes/Dmgr01Node/serverindex.xml_disabled ]]; then
        echo "Não foi encontrado o arquivo serverindex.xml_disabled."
        echo "Provavelmente o was8 ainda não foi pósMigrado ou iniciado."
    else
        cd /opt/WebSphere7/AppServer/profiles/Dmgr01/config/cells/$cellName/nodes/Dmgr01Node/ &&
        cp serverindex.xml serverindex.xml_PosMig &&
        cp serverindex.xml_disabled serverindex.xml &&
        echo "Arquivos alterados." &&
        echo "O dmgr do was7 pode ser iniciado."
    fi
fi

if [[ -d /opt/WebSphere7/AppServer/profiles/Node01 ]]; then
    export profileName=Node01
    export fullfile=$(find /opt/WebSphere7/AppServer/profiles/Node01/config/cells/$cellName/nodes/ -name $hostname* | head -1)
    export nodeName=$(basename $fullfile)
    if [[ -f /opt/WebSphere7/AppServer/profiles/$profileName/config/cells/$cellName/nodes/$nodeName/serverindex.xml_PosMig ]]; then
        echo "Já existe backup do arquivo de configuração serverindex.xml_PosMig"
        echo "Provavelmente o was7 pode ser iniciado."
    elif [[ ! -f /opt/WebSphere7/AppServer/profiles/$profileName/config/cells/$cellName/nodes/$nodeName/serverindex.xml_disabled ]]; then
        echo "Não foi encontrado o arquivo serverindex.xml_disabled."
        echo "Provavelmente o was8 ainda não foi pósMigrado ou iniciado."
    else
        cd /opt/WebSphere7/AppServer/profiles/$profileName/config/cells/$cellName/nodes/$nodeName/ &&
        cp serverindex.xml serverindex.xml_PosMig &&
        cp serverindex.xml_disabled serverindex.xml &&
        echo "Arquivos alterados." &&
        echo "O node do was7 pode ser iniciado."
    fi
fi
'