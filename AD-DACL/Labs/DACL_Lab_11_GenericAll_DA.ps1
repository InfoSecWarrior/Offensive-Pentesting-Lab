# ===============================================
# Lab 11: Grant 'peter' GenericAll on Domain Admins group
# ===============================================

Import-Module ActiveDirectory

# Attacker
$attacker = Get-ADUser "peter"
$attackerSID = New-Object System.Security.Principal.SecurityIdentifier($attacker.SID)

# Target: Domain Admins group
$target = Get-ADGroup "Domain Admins"
$targetDN = $target.DistinguishedName
$targetADSI = [ADSI]"LDAP://$targetDN"
$acl = $targetADSI.ObjectSecurity

# Remove any previous ACEs for attacker
$acl.Access | Where-Object { $_.IdentityReference -eq $attackerSID } | ForEach-Object {
    $acl.RemoveAccessRule($_)
}

# Add GenericAll permission
$ace = New-Object System.DirectoryServices.ActiveDirectoryAccessRule (
    $attackerSID,
    "GenericAll",
    "Allow",
    [Guid]::Empty,
    "None"
)

$acl.AddAccessRule($ace)
$targetADSI.ObjectSecurity = $acl
$targetADSI.CommitChanges()

Write-Host "✅ 'peter' now has GenericAll on Domain Admins" -ForegroundColor Green
