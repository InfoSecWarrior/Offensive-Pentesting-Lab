# ===============================================
# Lab 8: Grant 'jack' GenericWrite on user 'kate'
# ===============================================

Import-Module ActiveDirectory

# Get attacker (jack)
$attacker = Get-ADUser "jack"
$attackerSID = New-Object System.Security.Principal.SecurityIdentifier($attacker.SID)

# Get target user (kate)
$target = Get-ADUser "kate"
$targetDN = $target.DistinguishedName
$targetADSI = [ADSI]"LDAP://$targetDN"
$acl = $targetADSI.ObjectSecurity

# Clean any existing ACEs for jack
$acl.Access | Where-Object { $_.IdentityReference -eq $attackerSID } | ForEach-Object {
    $acl.RemoveAccessRule($_)
}

# Grant GenericWrite
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

Write-Host "✅ 'jack' now has GenericWrite on user 'kate'" -ForegroundColor Green
