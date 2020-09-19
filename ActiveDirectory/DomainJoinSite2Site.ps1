# ac

Param(
    [Parameter(Mandatory = $true)][string]$Domain,
    [Parameter(Mandatory = $true)][ipaddress]$DnsServer,
    [Parameter(Mandatory = $true)][string]$DomainPass,
    [Parameter(Mandatory = $true)][string]$Username,
    [string]$InterfaceAlias = 'Ethernet',
    [string]$OUPath
)


try {
    Set-DnsClientServerAddress -InterfaceAlias $InterfaceAlias -ServerAddresses $DnsServer
    $SecDomainPass = ConvertTo-SecureString $DomainPass -AsPlainText -Force
    $Credentials = New-Object System.Management.Automation.PSCredential ($Username, $SecDomainPass)
    
    if ($OUPath) {
        Add-Computer -DomainName $Domain -Credential $Credentials -OUPath $OUPath
    }
    else {
        Add-Computer -DomainName $Domain -Credential $Credentials
    }

    Set-DnsClientServerAddress -InterfaceAlias $InterfaceAlias -ResetServerAddresses
    
    if (!(Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain) {
        Write-Warning "Domain join failed, still WORKGROUP"
        exit 1
    }
}
catch {
    Set-DnsClientServerAddress -InterfaceAlias $InterfaceAlias -ResetServerAddresses  
    Write-Warning "Something went wrong with domain join: $_"
    exit 2
}
    
