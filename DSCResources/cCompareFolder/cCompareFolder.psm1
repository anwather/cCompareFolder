﻿$currentPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Write-Debug -Message "CurrentPath: $currentPath"

# Load Common Code
Import-Module $currentPath\..\..\cCompareFolder.psm1 -Verbose:$false -ErrorAction Stop

function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $SourceFolder,

        [parameter(Mandatory = $true)]
        [System.String]
        $DestinationFolder
    )

    #Write-Verbose "Use this cmdlet to deliver information about command processing."

    #Write-Debug "Use this cmdlet to write debug information while troubleshooting."


    
    $returnValue = @{
    SourceFolder = $SourceFolder
    DestinationFolder = $DestinationFolder
    }

    $returnValue
    
}


function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $SourceFolder,

        [parameter(Mandatory = $true)]
        [System.String]
        $DestinationFolder
    )

    Import-Module $currentPath\..\..\cCompareFolder.psm1 -Verbose:$false -ErrorAction Stop

    Compare-Folder -SourceFolder $SourceFolder -DestinationFolder $DestinationFolder 

    #Write-Verbose "Use this cmdlet to deliver information about command processing."

    #Write-Debug "Use this cmdlet to write debug information while troubleshooting."

    #Include this line if the resource requires a system reboot.
    #$global:DSCMachineStatus = 1


}


function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $SourceFolder,

        [parameter(Mandatory = $true)]
        [System.String]
        $DestinationFolder
    )

    Write-Verbose "Running Test-TargetResource"

    #Write-Debug "Use this cmdlet to write debug information while troubleshooting."



    
    $result = Compare-Folder -SourceFolder $SourceFolder -DestinationFolder $DestinationFolder -Test -Verbose
    
    $result
    
}


Export-ModuleMember -Function *-TargetResource

