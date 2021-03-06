﻿Function Compare-Folder
    {
    [CmdletBinding()]
    Param($SourceFolder,$DestinationFolder,[switch]$Test)

    $source = Get-ChildItem $SourceFolder -Recurse
    $destination = Get-ChildItem $DestinationFolder


    
    try
        {
            $comp = Compare-Object -ReferenceObject $Source -DifferenceObject $destination -ErrorAction STOP
        }
    catch
        {
            Write-Verbose "$DestinationFolder is empty"
            
        }

    if (($null -eq $destination) -and (!($Test)))
        {
            Write-Verbose "Null and not test"
            $source | Copy-Item -Destination $DestinationFolder -Recurse -Verbose
            $comp = $null
        }
    
    if (($null -eq $destination) -and (($Test)))
        {
            Write-Verbose "Null and test"
            #$source | Copy-Item -Destination $DestinationFolder -Recurse -Verbose
            $comp = "Dummy Value"
        }

    


if ($Test)
    {
    if ($null -ne $comp)
        {
        <#switch($comp)
            {
                {$_.SideIndicator -eq "<="} {Write-Verbose "Source: $($_.InputObject) does not exist in $DestinationFolder";Copy-Item "$SourceFolder\$($_.InputObject)" -Destination $destinationFolder -Verbose}
                {$_.SideIndicator -eq "=>"} {Write-Verbose "Destination: $($_.InputObject) does not exist in $SourceFolder";Remove-Item "$DestinationFolder\$($_.InputObject)" -Force -Verbose}
            }#>
            Write-Verbose "Differences Found"
            return $false
        }
    else
        {
            Write-Verbose "Test: No differences detected between $SourceFolder and $DestinationFolder"
            return $true
        }
    }
else
    {
    if ($null -ne $comp)
        {
        switch($comp)
            {
                {$_.SideIndicator -eq "<="} {Write-Verbose "Source: $($_.InputObject) does not exist in $DestinationFolder";Copy-Item "$SourceFolder\$($_.InputObject)" -Destination $destinationFolder -Verbose}
                {$_.SideIndicator -eq "=>"} {Write-Verbose "Destination: $($_.InputObject) does not exist in $SourceFolder";Remove-Item "$DestinationFolder\$($_.InputObject)" -Force -Verbose}
            }
            Write-Verbose "Differences Found"
        #return $false
        }
    else
        {
            Write-Verbose "2. No differences detected between $SourceFolder and $DestinationFolder"
        #return $true
        }
    }

}

Export-ModuleMember *