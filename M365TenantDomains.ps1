function Get-M365TenantDomains {
<#
.SYNOPSIS
Découvre tous les domaines rattachés à un tenant Microsoft 365/Entra ID à partir d’un domaine connu.

.DESCRIPTION
Interroge une API de découverte externe pour récupérer la liste complète des domaines liés au tenant (primaire et secondaires).
Retourne un tableau d’objets avec le domaine interrogé, le TenantId, le TenantName et chaque domaine découvert.
Optionnellement, exporte le résultat au format CSV (UTF‑8, sans type).

.PARAMETER Domain
Nom de domaine de départ (ex. contoso.com). Doit correspondre à un FQDN valide.

.PARAMETER OutCsv
Chemin de fichier CSV (optionnel). Si spécifié, les résultats sont exportés.

.OUTPUTS
System.Object (PSCustomObject) — un objet par domaine découvert, avec :
- QueriedDomain
- TenantId
- TenantName
- Domain

.EXAMPLE
PS> Get-M365TenantDomains -Domain "contoso.com"
Interroge l’API et affiche les domaines liés au tenant de contoso.com.

.EXAMPLE
PS> Get-M365TenantDomains -Domain "contoso.com" -OutCsv ".\contoso_tenant_domains.csv"
Idem, en exportant les résultats dans un CSV.

.NOTES
- Appel en lecture seule : aucune action de configuration côté tenant.
- Pensez à corréler ensuite avec Sign‑In/Audit Logs, règles Exchange, B2B et Conditional Access.
- L’API attend un domaine valide et peut retourner une liste vide si rien n’est rattaché.

#>    
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidatePattern('^[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')]
        [string]$Domain,

        [string]$OutCsv # chemin CSV optionnel
    )

    $base = "https://azmap.dev/api/tenant"
    $params = @{ domain = $Domain; extract = "true" }

    try {
        $resp = Invoke-RestMethod -Method GET -Uri $base -Body $params -TimeoutSec 60 -Headers @{
            'User-Agent' = 'PowerShell'
        }

        if (-not $resp) { throw "Réponse vide de l’API." }

        # Normalisation sortie
        $tenantId   = $resp.tenant_id
        $tenantName = $resp.tenant_name
        $domains    = @($resp.email_domains) | Where-Object { $_ } | Sort-Object -Unique

        if (-not $domains) {
            Write-Warning "Aucun domaine trouvé pour $Domain"
            return
        }

        $objects = $domains | ForEach-Object {
            [pscustomobject]@{
                QueriedDomain = $Domain
                TenantId      = $tenantId
                TenantName    = $tenantName
                Domain        = $_
            }
        }

        

        # Sortie à l’écran
        #Write-Host "Domaines   : $domain"
        #Write-Host "TenantName : $tenantName"
        #Write-Host "TenantId   : $tenantId"

        if ($OutCsv) {
            $objects | Export-Csv -NoTypeInformation -Encoding UTF8 -Path $OutCsv
            Write-Host "Exporté vers $OutCsv ('$($objects.Count)' domaines)."
        }

        return $objects
    }
    catch {
        # Message concis, sans fuite d’implémentation
        Write-Error ("Échec de la découverte pour '{0}' : {1}" -f $Domain, $_.Exception.Message)
    }
}




