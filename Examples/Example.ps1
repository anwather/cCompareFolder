Configuration FolderTest
    {

    Import-DSCResource -ModuleName cCompareFolder

    Node localhost

        {
        cFolder Folder
            {
            SourceFolder = "C:\Temp\Source"
            DestinationFolder = "C:\Temp\Destination"
            }
        }


    }

#Prepare Module
Copy-Item C:\Temp\cCompareFolder -Destination 'C:\Program Files\WindowsPowerShell\Modules' -Force

Set-Location C:\temp

FolderTest 

Start-DSCConfiguration .\FolderTest -Wait -Verbose -Force