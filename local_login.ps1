function login(){
    param(
        [switch]$SPO,
        [switch]$MFA,
        [string]$TenantName,
        [string]$subid
    )
    $urlSPOAdmin = "https://$($TenantName)-admin.sharepoint.com"
    if ($MFA){
        try{
            Login-AzureRmAccount | out-null
        }
        catch{
            log -text "Konnte keine Verbindung mit dem AzureRM Account herstellen: $_" -err
        }
        log -text "In Azure eingeloggt"
        if($SPO){
            try{
                log -text "Starte authentifizierung in SharePoint-Online"
                Connect-SPOService -Url $urlSPOAdmin -ErrorAction SilentlyContinue| out-null
            }
            catch{
                if(!($TenantName)){
                    log -text "Tenantname ist nicht angegeben. Geben sie einen Tenantnamen an und führen sie das Skript erneut aus!" -err
                }
                log -text "Konnte keine Verbindung mit SharePoint-Online herstellen: $_" -err
            }
            log -text "Authentifizierung in SharePoint-Online erfolgreich"
        }
    }
    else{
        $AdminUsername = Read-Host -Prompt "E-Mail"
        $AdminPassword = Read-Host -Prompt "Passwort" -AsSecureString  
        $adminCredentials = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $AdminUsername, $AdminPassword
        log -text "Email und Passwort erfolgreich eingelesen"
        try{
            Login-AzureRmAccount -Credential $adminCredentials | out-null
        }
        catch{
             log -text "Konnte keine Verbindung mit dem AzureRM Account herstellen: $_" -err
        }
        log -text "In Azure eingeloggt"
        if($SPO){
            try{
                log -text "Starte authentifizierung in SharePoint-Online"
                Connect-SPOService -Url $urlSPOAdmin -Credential $adminCredentials -ErrorAction SilentlyContinue| out-null
            }
            catch{
                if(!($TenantName)){
                    log -text "Tenantname ist nicht angegeben. Geben sie einen Tenantnamen an und führen sie das Skript erneut aus!" -err
                }
                log -text "Konnte keine Verbindung mit SharePoint-Online herstellen: $_" -err
            }
            log -text "Authentifizierung in SharePoint-Online erfolgreich"
        }        
    }
    if($subid){
        if($tenantid){
            try{
                Select-AzSubscription $subid -Tenant $tenantid| out-null
            }
            catch{
                log -text "Konnte nicht die angegebene Subscription(zusammenhang: Azure Subscription(Select-AzureRmSubscription)) auswaehlen!" -warning
            }
            try{
                Set-AzContext -Subscription $subid -Tenant $tenantid| out-null
            }
            catch{
                log -text "Konnte nicht die angegebene Subscription(zusammenhang: Azure Kontext(Set-AzureRmContext)) auswaehlen!" -warning
            }
        }
        else{
            try{
                Select-AzSubscription $subid | out-null
            }
            catch{
                log -text "Konnte nicht die angegebene Subscription(zusammenhang: Azure Subscription(Select-AzureRmSubscription)) auswaehlen!" -warning
            }
            try{
                Set-AzContext -Subscription $subid | out-null
            }
            catch{
                log -text "Konnte nicht die angegebene Subscription(zusammenhang: Azure Kontext(Set-AzureRmContext)) auswaehlen!" -warning
            }
        }
    }
}
