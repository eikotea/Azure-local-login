<############################################>
<# Skript um Module zu installieren         #>
<# die PS benötigt um Azure-VM Status       #>
<# abfrage durchzuführen                    #>
<# Set-ExecutionPolicy RemoteSigned         #>
<############################################>
$installmoduleAzRM = install-module -Name AzureRM
$installmoduleAz = Install-Module -Name Az -AllowClobber
$installmoduleSPO = Install-Module -Name Microsoft.Online.SharePoint.PowerShell
$importmoduleAzRM = Import-Module AzureRM
$importmoduleAz = import-Module -Name Az -AllowClobber
$importmoduleSPO = import-Module -Name Microsoft.Online.SharePoint.PowerShell

$installmoduleAzRM
Read-Host "Press ENTER"
$importmoduleAzRM
Read-Host "Press ENTER"
$installmoduleAz
Read-Host "Press ENTER"
$importmoduleAz
Read-Host "Press ENTER"
$installmoduleSPO
Read-Host "Press ENTER"
$importmoduleSPO
Read-Host "Press ENTER"