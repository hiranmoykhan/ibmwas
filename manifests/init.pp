# Class: ibmwas
#
# This module manages ibmwas
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class ibmwas(
    $responseFile                     = '/tmp/was-resposefile.txt',
	  $disableOSPrereqChecking          = 'UNSET',
	  $silentInstallLicenseAcceptance   = 'UNSET',
	  $disableNonBlockingPrereqChecking = 'UNSET',
	  $checkFilePermissions             = 'UNSET',
	  $installType                      = 'UNSET',
	  $installLocation                  = 'UNSET',
	  $cimSelected                      = 'UNSET',
	  $traceFormat                      = 'UNSET',
	  $traceLevel                       = 'UNSET',
	  $prof_validatePorts               = 'UNSET',
	  $prof_defaultPorts                = 'UNSET',
	  $prof_signingCertValidityPeriod   = 'UNSET',
	  $prof_personalCertValidityPeriod  = 'UNSET',
	  $prof_omitAction                  = 'UNSET',
	  $responseFileBackup              = '/tmp/was-installation-location.txt'
) {
  class { "ibmwas::precheck": }
  include ibmwas::params
  exec{'Creating Response file':
    command   => "cat /tmp/was-details.txt > ${responseFile}",
    require   => File['was-details.txt'],
    provider  => shell,
    logoutput => true
    }
  $disableOSPrereqChecking_real = $disableOSPrereqChecking ? {
    'UNSET' => $::ibmwas::params::disableOSPrereqChecking,
    default => $disableOSPrereqChecking,
    }
  $silentInstallLicenseAcceptance_real = $silentInstallLicenseAcceptance ? {
    'UNSET' => $::ibmwas::params::silentInstallLicenseAcceptance,
    default => $silentInstallLicenseAcceptance,
    }
  $disableNonBlockingPrereqChecking_real = $disableNonBlockingPrereqChecking ? {
    'UNSET' => $::ibmwas::params::disableNonBlockingPrereqChecking,
    default => $disableNonBlockingPrereqChecking,
    }
  $checkFilePermissions_real = $checkFilePermissions ? {
    'UNSET' => $::ibmwas::params::checkFilePermissions,
    default => $checkFilePermissions,
    }
  $installType_real = $installType ? {
    'UNSET' => $::ibmwas::params::installType,
    default => $installType,
    }
  $installLocation_real = $installLocation ? {
    'UNSET' => $::ibmwas::params::installLocation,
    default => $installLocation,
    }
  $cimSelected_real = $cimSelected ? {
    'UNSET' => $::ibmwas::params::cimSelected,
    default => $cimSelected,
    }
  $traceFormat_real = $traceFormat ? {
    'UNSET' => $::ibmwas::params::traceFormat,
    default => $traceFormat,
    }
  $traceLevel_real = $traceLevel ? {
    'UNSET' => $::ibmwas::params::traceLevel,
    default => $traceLevel,
    }
  $prof_validatePorts_real = $prof_validatePorts ? {
    'UNSET' => $::ibmwas::params::prof_validatePorts,
    default => $prof_validatePorts,
    }
  $prof_defaultPorts_real = $prof_defaultPorts ? {
    'UNSET' => $::ibmwas::params::prof_defaultPorts,
    default => $prof_defaultPorts,
    }
  $prof_signingCertValidityPeriod_real = $prof_signingCertValidityPeriod ? {
    'UNSET' => $::ibmwas::params::prof_signingCertValidityPeriod,
    default => $prof_signingCertValidityPeriod,
    }
  $prof_personalCertValidityPeriod_real = $prof_personalCertValidityPeriod ? {
    'UNSET' => $::ibmwas::params::prof_personalCertValidityPeriod,
    default => $prof_personalCertValidityPeriod,
    }
  $prof_omitAction_real = $prof_omitAction ? {
    'UNSET' => $::ibmwas::params::prof_omitAction,
    default => $prof_omitAction,
    }
  file_line{'Appending other variables to the file':
          require => Exec['Creating Response file'],
          path    => "${responseFile}",
          line    => "\n-OPT disableOSPrereqChecking=${disableOSPrereqChecking_real}\n-OPT silentInstallLicenseAcceptance=${silentInstallLicenseAcceptance_real}\n-OPT disableNonBlockingPrereqChecking=${disableNonBlockingPrereqChecking_real}\n-OPT checkFilePermissions=${checkFilePermissions_real}\n-OPT installType=${installType_real}\n-OPT installLocation=${installLocation_real}\n-OPT cimSelected=${cimSelected_real}\n-OPT traceFormat=${traceFormat_real}\n-OPT traceLevel=${traceLevel_real}\n-OPT PROF_validatePorts=${prof_validatePorts_real}\n-OPT PROF_defaultPorts=${prof_defaultPorts_real}\n-OPT PROF_signingCertValidityPeriod=${prof_signingCertValidityPeriod_real}\n-OPT PROF_personalCertValidityPeriod=${prof_personalCertValidityPeriod_real}\n-OPT PROF_omitAction=${prof_omitAction_real}"
      }
    exec{'Installation of WAS':
          require   => File_line['Appending other variables to the file'],
          command   => "./install -options ${responseFile} -silent",
          onlyif    => '[ $( locate profileRegistry.xml | grep -E "\/app\/IBM\/WebSphere\/AppServer\/" | wc -l ) -eq 0 ]',
          provider  => shell,
          cwd       => '/opt/WAS/',
          logoutput => true,
          timeout   => 0
      }
    exec{'Remove was-detailsfile':
          command   => "rm -f /tmp/was-details.txt && cp ${responseFile} /usr/bin/was-installed.txt",
          require   => Exec['Installation of WAS'],
          provider  => shell,
          logoutput => true,
          timeout   => 0
      }
    exec{'Remove installer Files':
          command   => "rm -f /opt/was-installer.tar.gz && cd /opt/ && rm -rf WAS JDK && rm -f ${responseFile}",
          require   => Exec['Remove was-detailsfile'],
          provider  => shell,
          logoutput => true,
          timeout   => 0
      }
}
