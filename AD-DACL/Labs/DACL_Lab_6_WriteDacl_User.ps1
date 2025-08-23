# ===============================================
# Lab 6: Grant 'grace' WriteDACL on user 'harry'
# ===============================================

Import-Module ActiveDirectory

# Get attacker (grace)
$attacker = Get-ADUser "grace"
$attackerSID = New-Object System.Security.Principal.SecurityIdentifier($attacker.SID)

# Get target user (harry)
$target = Get-ADUser "harry"
$targetDN = $target.DistinguishedName
$targetADSI = [ADSI]"LDAP://$targetDN"
$acl = $targetADSI.ObjectSecurity

# Cleanup: Remove existing ACEs for this user
$acl.Access | Where-Object { $_.IdentityReference -eq $attackerSID } | ForEach-Object {
    $acl.RemoveAccessRule($_)
}

# Grant WriteDACL (non-inheritable)
$ace = New-Object System.DirectoryServices.ActiveDirectoryAccessRule (
    $attackerSID,
    "WriteDacl",
    "Allow",
    [Guid]::Empty,
    "None"
)

$acl.AddAccessRule($ace)
$targetADSI.ObjectSecurity = $acl
$targetADSI.CommitChanges()

Write-Host "✅ 'grace' now has WriteDACL on user 'harry'" -ForegroundColor Green
