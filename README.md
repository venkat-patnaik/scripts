This powershell script can be used to create ODBC DSN's (32 and 64 bit) on remote windows computers/servers.
It has a prompt for credentials so you'll need to ensure the account that you are using has write access on these remote windows servers.
The servers.txt will contain the list of servers where you want to create these DSN's.
$HostedRegFile - should be in the format as shown in the attached sample ODBC3264bit.reg. You'll need to modify the path of the dll file based on the version of the drivers you are using in your environment. I started building my code using the one provided in the References but in the end I had to make significant amount of changes for it to work per our requirements. 

I believe there is still a lot of scope to improve this code but I'll that up to you :)

References: https://serverfault.com/questions/865296/pushing-a-hosted-registry-file-to-multiple-servers
