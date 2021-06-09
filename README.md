This is my first jab at powershell scripting so pardon my unkempt scripting skills if you find any.

**Decription:**
The attached script (ODBC_DSN.ps1) can be used to create ODBC DSN's (32 and 64 bit) on remote windows computers/servers.
It has a prompt for credentials so you'll need to ensure the account that you are using has write access on these remote windows servers.
The servers.txt file on line#2 will contain the list of servers where you want to create these DSN's.
$HostedRegFile on line#5 - should be in the format as shown in the attached sample ODBC3264bit.reg. You'll need to modify the path of the dll file based on the version of the drivers you are using in your environment. I started building my code using the one provided in the References but in the end I had to make significant amount of changes for it to work per our requirements. 

I believe there is still a lot of scope to improve this code but I'll leave that up to you to figure out :)

**References:**
https://serverfault.com/questions/865296/pushing-a-hosted-registry-file-to-multiple-servers
