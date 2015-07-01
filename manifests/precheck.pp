class ibmwas::precheck(
  $responseFileBackup        = '/usr/bin/was-installation-location.txt',
  $sourcePath                = 'puppet:///modules/ibmwas'
){
  $installableProfileType = $::install_profile_type
  
  case $installableProfileType {
  'cell':               { 
		file {'was-details.txt':
		    ensure       => present,
		    path         => '/tmp',
		    mode         => '0777',
		    validate_cmd => '[ $( grep -i -c profileType % ) -eq 1 ] && [ $( grep -i -c PROF_profilePath % ) -eq 1 ] && [ $( grep -i -c PROF_dmgrProfileName % ) -eq 1 ] && [ $( grep -i -c PROF_appServerProfileName % ) -eq 1 ] && [ $( grep -i -c PROF_isDefault % ) ] && [ $( grep -i -c PROF_winserviceCheck % ) ] && [ $( grep -i -c PROF_enableService % ) ] && [ $( grep -i -c PROF_webServerCheck % ) ] && [ $( grep -i -c PROF_enableAdminSecurity % ) ] && [ $( grep -i -c PROF_adminUserName % ) ] && [ $( grep -i -c PROF_adminPassword % ) ]',
		    provider    => shell
		    }
 }
  'standAlone':         { 
    file {'was-details.txt':
		    ensure       => present,
		    path         => '/tmp',
		    mode         => '0777',
		    validate_cmd => '[ $( grep -i -c profileType % ) -eq 1 ] && [ $( grep -i -c PROF_templatePath % ) -eq 1 ] && [ $( grep -i -c PROF_profilePath % ) -eq 1 ] && [ $( grep -i -c PROF_profileName % ) -eq 1 ] && [ $( grep -i -c PROF_isDefault % ) -eq 1 ] && [ $( grep -i -c PROF_serverName % ) -eq 1 ] && [ $( grep -i -c PROF_isDeveloperServer % ) -eq 1 ] && [ $( grep -i -c PROF_enableService % ) -eq 1 ] && [ $( grep -i -c PROF_webServerCheck % ) -eq 1 ] && [ $( grep -i -c PROF_enableAdminSecurity % ) -eq 1 ]  && [ $( grep -i -c PROF_adminUserName % ) -eq 1 ]  && [ $( grep -i -c PROF_adminPassword % ) -eq 1 ]',
        provider    => shell
		    }
 }
  'custom':             { 
    file {'was-details.txt':
        ensure       => present,
        path         => '/tmp',
        mode         => '0777',
        validate_cmd => '[ $( grep -i -c profileType % ) -eq 1 ] && [ $( grep -i -c PROF_templatePath % ) -eq 1 ] && [ $( grep -i -c PROF_profilePath % ) -eq 1 ] && [ $( grep -i -c PROF_profileName % ) -eq 1 ] && [ $( grep -i -c PROF_isDefault % ) -eq 1 ] && [ $( grep -i -c PROF_federateLater % ) -eq 1 ] && [ $( grep -i -c PROF_dmgrHost % ) -eq 1 ] && [ $( grep -i -c PROF_dmgrPort % ) -eq 1 ] && [ $( grep -i -c PROF_dmgrAdminUserName % ) -eq 1 ] && [ $( grep -i -c PROF_dmgrAdminPassword % ) -eq 1 ]',
        provider    => shell
        }
 }
  'deploymentManager':  {
    file {'was-details.txt':
        ensure       => present,
        path         => '/tmp',
        mode         => '0777',
        validate_cmd => '[ $( grep -i -c profileType % ) -eq 1 ] && [ $( grep -i -c PROF_templatePath % ) -eq 1 ] && [ $( grep -i -c PROF_profilePath % ) -eq 1 ] && [ $( grep -i -c PROF_profileName % ) -eq 1 ] && [ $( grep -i -c PROF_isDefault % ) -eq 1 ] && [ $( grep -i -c PROF_serverType % ) -eq 1 ] && [ $( grep -i -c PROF_enableService % ) -eq 1 ] && [ $( grep -i -c PROF_enableAdminSecurity % ) -eq 1 ] && [ $( grep -i -c PROF_adminUserName % ) -eq 1 ] && [ $( grep -i -c PROF_adminPassword % ) -eq 1 ]',
        provider    => shell
        } 
 }
  default:              {
    file {'was-details.txt':
        ensure       => present,
        path         => '/tmp',
        mode         => '0777',
        validate_cmd => '[ $( grep -i -c profileType % ) -eq 1 ] && [ $( grep -i -c PROF_templatePath % ) -eq 1 ] && [ $( grep -i -c PROF_profilePath % ) -eq 1 ] && [ $( grep -i -c PROF_profileName % ) -eq 1 ] && [ $( grep -i -c PROF_isDefault % ) -eq 1 ] && [ $( grep -i -c PROF_serverName % ) -eq 1 ] && [ $( grep -i -c PROF_isDeveloperServer % ) -eq 1 ] && [ $( grep -i -c PROF_enableService % ) -eq 1 ] && [ $( grep -i -c PROF_webServerCheck % ) -eq 1 ] && [ $( grep -i -c PROF_enableAdminSecurity % ) -eq 1 ]  && [ $( grep -i -c PROF_adminUserName % ) -eq 1 ]  && [ $( grep -i -c PROF_adminPassword % ) -eq 1 ]',
        provider    => shell
        }
 }
}
  exec{"Validate WAS installed or not":
    command      => '[ $(cat /tmp/was-details.txt | grep -c -E "^[\-a-zA-Z]+" ) -gt 0 ]',
    logoutput    => false,
    onlyif       => "[ $(ls -l ${responseFileBackup} | wc -l ) -eq 0 ]",
    require      => File['was-details.txt'],
    provider     => shell
  }
  package {'xorg-x11-xinit':
    ensure       => installed,
    require      => Exec['Validate WAS installed or not']
    }
  package {'glibc':
    ensure       => installed,
    require      => Package['xorg-x11-xinit']
    }
  exec {'glibc-i686-installation':
    command      =>'yum install -y $( yum provides */ld-linux.so.2 | grep glibc | head -n 1 | awk \'{print $1}\' )',
    logoutput    => true,
    require      => Package['glibc'],
    provider     => shell,
    onlyif       => "[ $(locate ld-linux.so.2 | wc -l ) -eq 0 ]",
    timeout      => 0
  }
  exec {'installing Dependency rpm':
    command      => 'yum install -y libXau-*i686 libxcb-*i686 libX11-*i686 libXext-*i686 libXp-*i686 libICE-*i686 libuuid-*i686 libSM-*i686 libXt-*i686 libXmu-*i686 libXi-*i686 libXtst-*i686 libXrender-*i686 freetype-*0.2.i686 expat-*i686 fontconfig-*i686 libXft-*i686 compat-libstdc++-*i686 ksh-*x86_64 libgcc-*i686 libstdc++-*x86_64 expat-*x86_64 gtk2-*x86_64 ',
    logoutput    => true,
    require      => Exec['glibc-i686-installation'],
    provider     => shell,
    timeout      => 0
  }
  file{'/opt/was-installer.tar.gz':
    ensure       => present,
    source       => "${sourcePath}/was-installer.tar.gz",
    require      => File['was-details.txt'],
    mode         => '0777',
    replace      => true
  }
  exec { 'Extract WAS Tarball':
	  command      => "tar -xvf /opt/was-installer.tar.gz",
	  require      => File['/opt/was-installer.tar.gz'],
	  cwd          => '/opt/',
	  onlyif       => "[ $( ls -l /opt | grep -c WAS ) -eq 0 ]",
	  path         => '/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:',
	  logoutput    => true,
	  provider     => shell
      }
  file{ '/opt/WAS':
    ensure       => directory,
    require      => Exec['Extract WAS Tarball'],
    mode         => '0777'
      }
  exec{ 'Change Permission of Installer':
    path         => '/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:',
    require      => File['/opt/WAS'],
    command      => 'chmod -R 777 ./',
    cwd          => '/opt/WAS',
    logoutput    => true,
    provider     => shell
  }
}
