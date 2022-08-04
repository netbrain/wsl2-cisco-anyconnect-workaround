<#
.SYNOPSIS
    Cisco Anyconnect Workaround
.DESCRIPTION
    Start or stop the Cisco Anyconnect Workaround
.PARAMETER Action
    "start" or "stop"
.PARAMETER File
    Optional, path to resolv file

#>

Param(
    [String]$Action = "",
    [String]$File = "C:\dev\wsl2workaround-resolv.conf"
)

if ( "start" -ilike $Action )
{
    Get-NetAdapter | ? {$_.InterfaceDescription -like "*Cisco*" } |Set-NetIPInterface -InterfaceMetric 6000

    $dns = (Get-NetIPConfiguration | Where-Object {$_.InterfaceDescription -like "Cisco*"} | Select @{l="IP";e={$_.DNSServer.Serveraddresses}})
    Clear-Content -Path $File
    foreach($u in $dns.IP){
        Add-Content -Path $File -Value "nameserver $u`n" -Encoding "ascii" -NoNewline
    }
}
elseif ( "stop" -ilike $Action )
{
    Get-NetAdapter | ? {$_.InterfaceDescription -like "*Cisco*" } |Set-NetIPInterface -InterfaceMetric 1
    Clear-Content -Path $File
    Set-Content -Path $File -Value "nameserver 8.8.8.8`n" -Encoding "ascii" -NoNewline
}
else
{
    Get-help $PSCommandPath -Detailed
}

