# ibmwas #

This is the ibmwas module. 
This will install Websphere Application Server 7 along with either cell, standalone, DMGR and custom profile.

User need to create a was-install.txt file with having either one of the details:

Cell Profile
-----------------------------
profileType=cell

PROF_profilePath=/app/IBM/WebSphere/AppServer/profiles

PROF_dmgrProfileName=Dmgr01

PROF_appServerProfileName=RBSITLV

PROF_isDefault="true"

PROF_winserviceCheck="false"

PROF_enableService="false"

PROF_webServerCheck=false

PROF_enableAdminSecurity="true"

PROF_adminUserName=Configadmin

PROF_adminPassword=password


#Non-Mandatory

PROF_hostName=

PROF_nodeName=

PROF_appServerNodeName=

PROF_cellName=

PROF_webServerCheck="false"

PROF_webServerType=

PROF_webServerOS=

PROF_webServerName=

PROF_webServerHostname=

PROF_webServerPort="80"

PROF_webServerPluginPath=

PROF_webServerInstallPath=



Standalone Profile
--------------------------------

profileType=standAlone

PROF_templatePath=/app/IBM/WebSphere/AppServer/profileTemplates/default

PROF_profilePath=/app/IBM/WebSphere/AppServer/profiles/RBSITLV

PROF_profileName=RBSITLV

PROF_isDefault="true"

PROF_serverName="server1"

PROF_isDeveloperServer="false"

PROF_enableService="false"

PROF_webServerCheck=false

PROF_enableAdminSecurity="true"

PROF_adminUserName=Configadmin

PROF_adminPassword=password


#Non-Mandatory

PROF_hostName=

PROF_nodeName=

PROF_cellName=

PROF_webServerCheck="false"

PROF_webServerType=

PROF_webServerOS=

PROF_webServerName=

PROF_webServerHostname=

PROF_webServerPort="80"

PROF_webServerInstallPath=

PROF_webServerPluginPath=



Custom Profile
--------------------------------

profileType=custom

PROF_templatePath=/app/IBM/WebSphere/AppServer/profileTemplates/managed

PROF_profilePath=/app/IBM/WebSphere/AppServer/profiles/SITLV

PROF_profileName=SITLV

PROF_isDefault="false"

PROF_federateLater="true"

PROF_dmgrHost="master.example.com"

PROF_dmgrPort="8879"

PROF_dmgrAdminUserName=configadmin

PROF_dmgrAdminPassword=password


#Non-Mandatory

PROF_hostName=

PROF_nodeName=

PROF_cellName=



DMGR Profile
--------------------------------

profileType=deploymentManager

PROF_templatePath=/app/IBM/WebSphere/AppServer/profileTemplates/management

PROF_profilePath=/app/IBM/WebSphere/AppServer/profiles/Dmgr01

PROF_profileName=Dmgr01

PROF_isDefault=true

PROF_serverType=DEPLOYMENT_MANAGER

PROF_enableService="false"

PROF_enableAdminSecurity="true"

PROF_adminUserName=Configadmin

PROF_adminPassword=password


#Non-Mandatory

PROF_hostName=

PROF_nodeName=

PROF_cellName=
