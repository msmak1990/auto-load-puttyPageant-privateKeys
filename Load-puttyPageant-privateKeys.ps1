<#
.Synopsis
   Short description
    This script will be used for loading the private keys using the Putty Pageant application.
.DESCRIPTION
   Long description
    2021-02-07 Sukri Created.
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
.INPUTS
   Inputs to this cmdlet (if any)
.OUTPUTS
   Output from this cmdlet (if any)
.NOTES
   General notes
    Author : Sukri Kadir
    Email  : msmak1990@gmail.com
.COMPONENT
   The component this cmdlet belongs to
.ROLE
   The role this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>

#import the external module into this script.
. "$PSScriptRoot\Get-ConfigurationValue"

#get the script file name.
$ScriptFileName = $MyInvocation.MyCommand.Name

#configuration file name.
$ConfigurationFileName = "PuttyPageant.cfg.ini"

#get the ini configuration file name.
$ConfigurationIniFile = "$PSScriptRoot\$ConfigurationFileName"

#get the configuration values.
$PuttyPageantDirectory = Get-ConfigurationValue -ConfigurationIniFile $ConfigurationIniFile -ConfigurationIniSection $ScriptFileName -ConfigurationIniKey "PUTTY_PAGEANT_PATH"
$PuttyPageantBinaryFileName = Get-ConfigurationValue -ConfigurationIniFile $ConfigurationIniFile -ConfigurationIniSection $ScriptFileName -ConfigurationIniKey "PUTTY_PAGEANT_FILE_NAME"
$PrivateKeyDirectory = Get-ConfigurationValue -ConfigurationIniFile $ConfigurationIniFile -ConfigurationIniSection $ScriptFileName -ConfigurationIniKey "PRIVATE_KEY_PATH"
$PrivateKeyFileName = Get-ConfigurationValue -ConfigurationIniFile $ConfigurationIniFile -ConfigurationIniSection $ScriptFileName -ConfigurationIniKey "PRIVATE_KEY_FILE_NAME"

#function to load the private keys using the Putty Pageant.
function Add-PuttyPageantPrivateKeys
{
    Param
    (
    #parameter for the base Putty Pageant binary directory.
        [ValidateNotNullOrEmpty()]
        [String]
        $PuttyPageantDirectory = $PuttyPageantDirectory,

    #parameter for the Putty Pageant binary file name.
        [ValidateNotNullOrEmpty()]
        [String]
        $PuttyPageantBinaryFileName = $PuttyPageantBinaryFileName,

        [ValidateNotNullOrEmpty()]
        [String]
    #parameter for the base private key directory.
        $PrivateKeyDirectory = $PrivateKeyDirectory,

        [ValidateNotNullOrEmpty()]
        [String]
    #parameter for the private key file names.
        $PrivateKeyFileName = $PrivateKeyFileName
    )

    Begin
    {
        #get full path of the Putty Pageant binary file.
        $PuttyPageant = "$PuttyPageantDirectory\$PuttyPageantBinaryFileName"

        #throw an error exception if no putty pageant is available.
        if (!$( Test-Path -Path $PuttyPageant -PathType Leaf ))
        {
            Write-Error -Message "[$PuttyPageant] does not exist. Exit." -Category ObjectNotFound -ErrorAction Stop
        }

        #throw exception if no existing on the private key directory.
        if (!$( Test-Path -Path $PrivateKeyDirectory -PathType Container ))
        {
            Write-Error -Message "[$PrivateKeyDirectory] does not exist. Exit." -Category ObjectNotFound -ErrorAction Stop
        }
    }
    Process
    {
        #get private key files (in array) recursively from the specific directory.
        [Array]$PrivateKeyFiles = Get-ChildItem -Path $PrivateKeyDirectory -Filter $PrivateKeyFileName -Recurse -Force -Verbose -ErrorAction Stop

        #verbose for the info.
        Write-Host "Private base Directory: $PrivateKeyDirectory"
        Write-Host "Private key file names: $PrivateKeyFiles"

        #private keys are available in array.
        if ($PrivateKeyFiles)
        {
            Start-Process -FilePath $PuttyPageant -ArgumentList $( $PrivateKeyFiles.Name ) -WorkingDirectory $PrivateKeyDirectory -NoNewWindow -Verbose -ErrorAction Stop
        }

        if (!$PrivateKeyFiles)
        {
            Write-Warning -Message "Private key(s) is not available from [$PrivateKeyDirectory]. Exit." -WarningAction Continue
        }
    }
    End
    {
        Write-Host "done."
    }
}

#start to write the log into a log file.
Start-Transcript -Path "$PSScriptRoot\$( $MyInvocation.MyCommand.Name )`.log"

#execute the function.
Add-PuttyPageantPrivateKeys

#stop the logging.
Stop-Transcript