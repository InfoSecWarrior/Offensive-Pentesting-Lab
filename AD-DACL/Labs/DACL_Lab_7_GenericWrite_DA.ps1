# ===============================================
# Lab 7: Grant 'irene' GenericWrite on Domain Admins group
# ===============================================

Import-Module ActiveDirectory

# Get attacker (irene)
$attacker = Get-ADUser "irene"
$attackerSID = New-Object System.Security.Principal.SecurityIdentifier($attacker.SID)

# Get target group (Domain Admins)
$target = Get-ADGroup "Domain Admins"
$targetDN = $target.DistinguishedName
$targetADSI = [ADSI]"LDAP://$targetDN"
$acl = $targetADSI.ObjectSecurity

# Clean existing ACEs for irene
$acl.Access | Where-Object { $_.IdentityReference -eq $attackerSID } | ForEach-Object {
    $acl.RemoveAccessRule($_)
}

# Add GenericWrite ACE
$ace = New-Object System.DirectoryServices.ActiveDirectoryAccessRule (
    $attackerSID,
    "GenericWrite",
    "Allow",
    [Guid]::Empty,
    "None"
)

$acl.AddAccessRule($ace)
$targetADSI.ObjectSecurity = $acl
$targetADSI.CommitChanges()

Write-Host "✅ 'irene' now has GenericWrite on Domain Admins" -ForegroundColor Green
