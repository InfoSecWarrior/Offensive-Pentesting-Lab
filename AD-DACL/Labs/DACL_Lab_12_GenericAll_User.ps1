# ===============================================
# Lab 12: Grant 'quinn' GenericAll on user 'rose'
# ===============================================

Import-Module ActiveDirectory

# Get attacker
$attacker = Get-ADUser "quinn"
$attackerSID = New-Object System.Security.Principal.SecurityIdentifier($attacker.SID)

# Get target
$target = Get-ADUser "rose"
$targetDN = $target.DistinguishedName
$targetADSI = [ADSI]"LDAP://$targetDN"
$acl = $targetADSI.ObjectSecurity

# Clean any existing ACEs
$acl.Access | Where-Object { $_.IdentityReference -eq $attackerSID } | ForEach-Object {
    $acl.RemoveAccessRule($_)
}

# Add GenericAll
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

Write-Host "✅ 'quinn' now has GenericAll on user 'rose'" -ForegroundColor Green
