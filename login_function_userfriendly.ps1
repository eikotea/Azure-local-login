function login()
{
    $ErrorActionPreference = 'Stop'
    clear-Host
    $TenantName = Read-Host -Prompt "Tenat Name"
    $urlSPOAdmin = "https://$($TenantName)-admin.sharepoint.com"
    Write-Host "Benutzen sie MFA(Multi Faktor Authentifizierung)?"
    $MFA = Read-Host -Prompt "(J/N)"
    Clear-Host
    if (($MFA.ToLower()) -eq "j") 
    {
        #Azure
        Write-Host "Authentifiziere mit Azure / SharePoint Online`n"
        Write-Host -Verbose "`tEinloggen in Azure Service" -NoNewline
        for($i1 = 0; $i1 -lt 3; $i1++){
            Write-Host -NoNewline(".")
            start-sleep -s 1
        }
        #Login
        try{
            Login-AzureRmAccount | out-null
            Write-Host -ForegroundColor -NoNewline Green "[Done]"
        }
        catch{
            Write-Host "`t `t `t `t[Konnte keine Verbindung mit Azure-Service herstellen]" -ForegroundColor Yellow 
        }
        #SPO
        Write-Host -Verbose "`tEinloggen in SharePoint-Online Service" -NoNewline
        for($i1 = 0; $i1 -lt 3; $i1++){
            Write-Host -NoNewline(".")
            start-sleep -s 1
        }
        #Login
        try{
            Connect-SPOService -Url $urlSPOAdmin -Credential $adminCredentials -ErrorAction SilentlyContinue| out-null
            Write-Host -ForegroundColor -NoNewline Green "[Done]"
        }
        catch{
            Write-Host "`t[Konnte keine Verbindung mit SharePoint-Online herstellen]" -ForegroundColor Yellow 
        }
        Write-Host -ForegroundColor Green "`nBeendet"
    }
    elseif(($MFA.ToLower()) -eq "n")
    {
        $AdminUsername = Read-Host -Prompt "E-Mail"
        $AdminPassword = Read-Host -Prompt "Passwort" -AsSecureString
            
        $adminCredentials = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $AdminUsername, $AdminPassword
        clear-host

        #Azure
        Write-Host "Authentifiziere mit Azure / SharePoint Online`n"
        Write-Host -Verbose "`tEinloggen in Azure Service" -NoNewline
        for($i1 = 0; $i1 -lt 3; $i1++){
            Write-Host -NoNewline(".")
            start-sleep -s 1
        }
        #Login
        <#
            try{
            $loginaz = Login-AzureRmAccount -ErrorAction  | out-null
            if($loginaz -eq $true){
                Write-Host -ForegroundColor -NoNewline Green "[Done]"
            }
            elseif($loginaz -eq $false){
                Write-Host "elseifzweit HOOOWWWWWW"
            }
            }
            catch{
            Write-Host "`t `t `t `t [Konnte keine Verbindung mit Azure-Service herstellen]" -ForegroundColor Yellow 
            }
        #>
        try{
        Login-AzureRmAccount -Credential $adminCredentials | out-null
        Write-Host -ForegroundColor Green "`t `t `t [Done]"
        }
        catch{
            Write-Host "`t `t `t `t[Konnte keine Verbindung mit Azure-Service herstellen]" -ForegroundColor Yellow 
        }
        #SPO
        Write-Host -Verbose "`tEinloggen in SharePoint-Online Service" -NoNewline
        for($i1 = 0; $i1 -lt 3; $i1++){
            Write-Host -NoNewline(".")
            start-sleep -s 1
        }
        #Login
        try{
            Connect-SPOService -Url $urlSPOAdmin -Credential $adminCredentials | out-null
            Write-Host -ForegroundColor Green "`t [Done]"
        }
        catch{            
            Write-Host "`t `t[Konnte keine Verbindung mit SharePoint-Online herstellen]" -ForegroundColor Yellow 
        }
        Write-Host -ForegroundColor Green "`nBeendet"
    }
    else{Write-Host -ForegroundColor Red -BackgroundColor Black "Fehler bei der MFA auswahl!"}
}
login