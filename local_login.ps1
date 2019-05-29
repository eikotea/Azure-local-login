function login(){
    clear-Host
    Write-Host "Benutzen sie MFA(Multi Faktor Authentifizierung)?"
    $MFA = Read-Host -Prompt "(J/N)"
    $TenantName = Read-Host -Prompt "Tenat Name"
    $urlSPOAdmin = "https://$($TenantName)-admin.sharepoint.com"
    Clear-Host
    if (($MFA.ToLower()) -eq "j"){
        Write-Host -Verbose "Einloggen" -NoNewline
        for($i1 = 0; $i1 -lt 2; $i1++){
            Write-Host -NoNewline(".")
            start-sleep -s 1
        }Write-Host (".")
        Login-AzureRmAccount | out-null
        try{
            Connect-SPOService -Url $urlSPOAdmin -Credential $adminCredentials -ErrorAction SilentlyContinue| out-null
        }
        catch{
            Write-Host "Konnte keine Verbindung mit SharePoint-Online herstellen" -ForegroundColor Yellow
        }
    }
    else{
        $AdminUsername = Read-Host -Prompt "E-Mail"
        $AdminPassword = Read-Host -Prompt "Passwort" -AsSecureString
            
        $adminCredentials = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $AdminUsername, $AdminPassword
        Write-Host -Verbose "Einloggen" -NoNewline
        for($i1 = 0; $i1 -lt 2; $i1++){
            Write-Host -NoNewline(".")
            start-sleep -s 1
        }Write-Host (".")
        Login-AzureRmAccount -Credential $adminCredentials | out-null
        try{
            Connect-SPOService -Url $urlSPOAdmin -Credential $adminCredentials -ErrorAction SilentlyContinue| out-null
        }
        catch{
            Write-Host "Konnte keine Verbindung mit SharePoint-Online herstellen" -ForegroundColor Yellow
        }
    }
    Write-Host -ForegroundColor Green "Done"
}
login
