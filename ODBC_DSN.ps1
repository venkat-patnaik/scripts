#Pulling list of servers from servers.txt file
$servers = Get-Content "\\global_server\Scratch\Venkat\Servers.txt" 

#Registry file with the DSN names and their parameters
$HostedRegFile = "\\global_server\Scratch\Venkat\ODBC3264bit.reg"

#Prompt for user credentials
$credentials = Get-Credential

#Running the for loop for each server from the servers.txt file
    foreach ($server in $servers)
    {
        #Directory path
        $directory = "D:\ODBC Automation\"
        
        $Session = New-PSSession -computername $server -Credential $credentials

        Invoke-Command -session $Session -ScriptBlock{
        
        #If the directory does not exist, create it
        if (-not(Test-Path -Path $using:directory)){
            try{
                $null = New-Item -Path $using:directory -ItemType "directory" -Force -ErrorAction Stop
                Write-Host "The directory [$using:directory] has been created `n"
                }
            catch {
                    throw $_.Exception.Message
                  }
        }

        #If the directory already exists, show the message and do nothing
        else {
                Write-Host "`nSkipping creation of [$using:directory] directory because it already exists `n"
        }

        #Registry backup of the remote server
        Write-Output "Backing up registry on $using:server....`n"

        reg export HKLM\Software\ODBC\ "D:\ODBC Automation\$(Get-Date -Format yyyyMMdd-HHmmss)odbc64bit.reg" > $null #Suppressing default output text using $null
        reg export HKLM\Software\WOW6432Node\ODBC\ "D:\ODBC Automation\$(Get-Date -Format yyyyMMdd-HHmmss)odbc32bit.reg" > $null #Suppressing default output text using $null
        
        Write-Output "Registry backup complete.Creating DSNs on $using:server.....`n"

        } #end of scriptblock

        #Copying hosted registry file to the destination server
        Copy-Item -Path $HostedRegFile -Force -ToSession $Session -Destination "D:\ODBC Automation\" 
        
        #Writing DSN's to the registry
        Invoke-Command -session $Session -ScriptBlock{
        regedit /i /s "D:\ODBC Automation\ODBC3264bit.reg"
        }
        
        Write-Output "ODBC DSNs successfully created on $server`n"
    }