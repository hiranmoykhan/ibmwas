class ibmwas::params{
  $disableOSPrereqChecking          = true
  $silentInstallLicenseAcceptance   = true
  $disableNonBlockingPrereqChecking = true
  $checkFilePermissions             = true
  $installType                      = 'installNew'
  $installLocation                  = '/app/IBM/WebSphere/AppServer'
  $cimSelected                      = false
  $traceFormat                      = 'ALL'
  $traceLevel                       = 'INFO'
  $prof_validatePorts               = true
  $prof_defaultPorts                = true
  $prof_signingCertValidityPeriod   = '1825'
  $prof_personalCertValidityPeriod  = '1825'
  $prof_omitAction                  = 'samplesInstallAndConfig defaultAppDeployAndConfig'
}
  
  
  