# ===============================================
# Lab 10: Grant 'nina' AllExtendedRights on user 'oscar'
# ===============================================

Import-Module ActiveDirectory

# Attacker
$attacker = Get-ADUser "nina"
$attackerSID = New-Object System.Security.Principal.SecurityIdentifier($attacker.SID)

# Target
$target = Get-ADUser "oscar"
$targetDN = $target.DistinguishedName
$targetADSI = [ADSI]"LDAP://$targetDN"
$acl = $targetADSI.ObjectSecurity

# Remove old ACEs for this attacker
$acl.Access | Where-Object { $_.IdentityReference -eq $attackerSID } | ForEach-Object {
    $acl.RemoveAccessRule($_)
}

# Add AllExtendedRights permission
$ace = New-Object System.DirectoryServices.ActiveDirectoryAccessRule (
    $attackerSID,
    "ExtendedRight",
    "Allow",
    [Guid]::Empty,
    "None"
)

$acl.AddAccessRule($ace)
$targetADSI.ObjectSecurity = $acl
$targetADSI.CommitChanges()

Write-Host "✅ 'nina' now has AllExtendedRights on user 'oscar'" -ForegroundColor Green
